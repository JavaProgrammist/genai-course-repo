# Builds usage statistics (explicit vs implicit) of vocabulary terms in the report
# and renders a self-contained HTML relationship graph.
# Usage (from the repository root):  powershell -File graph/build-graph.ps1
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$reportPath = Join-Path $root 'genai-applications-report.md'
$termsPath = Join-Path $PSScriptRoot 'terms.json'
$statsPath = Join-Path $PSScriptRoot 'usage-stats.json'
$htmlPath = Join-Path $PSScriptRoot 'vocabulary-graph.html'

$report = Get-Content -LiteralPath $reportPath -Raw -Encoding UTF8
$terms = Get-Content -LiteralPath $termsPath -Raw -Encoding UTF8 | ConvertFrom-Json

# One section per use case: "## N. Title" up to the next "## " heading.
$sections = [regex]::Matches($report, '(?ms)^## (\d+)\. (.+?)\r?\n(.*?)(?=^## |\z)') | ForEach-Object {
    [pscustomobject]@{ Id = [int]$_.Groups[1].Value; Title = $_.Groups[2].Value.Trim(); Text = $_.Groups[3].Value }
}

function Get-MatchSpans([string]$text, [string[]]$patterns) {
    $spans = foreach ($p in $patterns) {
        foreach ($m in [regex]::Matches($text, $p, 'IgnoreCase')) { [pscustomobject]@{ Start = $m.Index; End = $m.Index + $m.Length } }
    }
    @($spans)
}

# Implicit hits are counted only where they do not overlap an explicit hit of the same term.
function Measure-Term($term, [string]$text) {
    $explicit = Get-MatchSpans $text $term.explicit
    $implicit = Get-MatchSpans $text $term.implicit | Where-Object {
        $span = $_
        -not ($explicit | Where-Object { $_.Start -lt $span.End -and $span.Start -lt $_.End })
    }
    [pscustomobject]@{ Explicit = @($explicit).Count; Implicit = @($implicit).Count }
}

$stats = foreach ($term in $terms) {
    $perSection = foreach ($s in $sections) {
        $m = Measure-Term $term $s.Text
        [pscustomobject]@{ section = $s.Id; explicit = $m.Explicit; implicit = $m.Implicit }
    }
    [pscustomobject]@{
        term     = $term.term
        explicit = ($perSection | Measure-Object explicit -Sum).Sum
        implicit = ($perSection | Measure-Object implicit -Sum).Sum
        sections = @($perSection)
    }
}

$data = [pscustomobject]@{
    sections = @($sections | ForEach-Object { [pscustomobject]@{ id = $_.Id; title = $_.Title } })
    terms    = @($stats)
}
$json = $data | ConvertTo-Json -Depth 6 -Compress
Set-Content -LiteralPath $statsPath -Value ($data | ConvertTo-Json -Depth 6) -Encoding UTF8

$template = Get-Content -LiteralPath (Join-Path $PSScriptRoot 'graph-template.html') -Raw -Encoding UTF8
Set-Content -LiteralPath $htmlPath -Value $template.Replace('/*DATA*/null', $json) -Encoding UTF8

$used = @($stats | Where-Object { $_.explicit + $_.implicit -gt 0 }).Count
Write-Host "Terms: $(@($stats).Count), used in report: $used. Wrote usage-stats.json and vocabulary-graph.html"

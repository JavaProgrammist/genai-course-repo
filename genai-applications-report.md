# Research Report: Generative AI Applications

This report surveys ten families of practical Generative AI (GenAI) applications. Each case has a short
description with the **key business value**, the **technical challenges** and the **weak points**, followed by a
list of existing implementations (name, link, one-sentence description).

Common ground for all cases: a large language model (LLM) is rarely used "as is". Real products wrap it with a
carefully designed prompt, a retrieval layer (RAG) for grounding in company data, guardrails, evaluation (evals)
and observability. The same handful of weak points returns in every case: hallucination, prompt injection,
leakage of PII, unpredictable cost per token and latency. These are discussed per case, and summarised at the end.

---

## 1. Code generation and developer assistants

**Key business value.** A copilot inside the IDE completes code, writes unit tests, explains legacy code and
drafts documentation, which shortens the feedback loop of a developer and lowers the cost of routine work such as
boilerplate, migrations and refactoring. Newer agentic tools go further: they read a repository, plan a change,
call tools (compiler, test runner, git) and propose a pull request, with a human-in-the-loop reviewing the result.

**Technical challenges and weak points.** The model must see the *right* part of a large codebase, so products
combine embeddings, a vector database, chunking and reranking inside the limited context window. Generated code
may compile but be subtly wrong, insecure or use an outdated API (hallucination, knowledge cutoff), so tests and
review remain mandatory. Other weak points are licence and IP concerns, secrets leaking into prompts, and prompt
injection through files or web pages that an agent reads.

**Existing implementations**
- GitHub Copilot — <https://github.com/features/copilot> — IDE completion, chat and a coding agent integrated with GitHub.
- Cursor — <https://cursor.com> — an AI-first code editor with codebase-aware chat and multi-file edits.
- Claude Code — <https://www.anthropic.com/claude-code> — a terminal/IDE agent that edits code, runs commands and tests.
- Amazon Q Developer — <https://aws.amazon.com/q/developer/> — an assistant for coding and AWS tasks, including code upgrades.
- JetBrains AI Assistant — <https://www.jetbrains.com/ai-assistant/> — AI chat and completion built into JetBrains IDEs.
- Tabnine — <https://www.tabnine.com> — a code assistant with privacy-focused and self-hosted deployment options.

## 2. Customer support automation

**Key business value.** Chatbots and voice agents resolve a large share of repetitive requests (order status,
refunds, password reset) around the clock in many languages, and assist human agents with suggested replies and
conversation summaries. This reduces cost per ticket and first-response time and keeps people for complex cases.

**Technical challenges and weak points.** The assistant must be grounded (RAG) in the current help-centre and in
live customer data through tool calling, otherwise it invents policies. Teams need guardrails against off-topic
answers, jailbreak attempts and prompt injection, a reliable hand-off to a human, and evaluation on real
conversations (LLM-as-a-judge plus human review). Latency matters in chat and especially in voice. Brand and
legal risk of a wrong promise given by a bot is the main weak point.

**Existing implementations**
- Intercom Fin — <https://www.intercom.com/fin> — an AI agent that answers support questions from a company's knowledge base.
- Zendesk AI — <https://www.zendesk.com/service/ai/> — AI agents and copilot features inside the Zendesk support suite.
- Salesforce Agentforce — <https://www.salesforce.com/agentforce/> — a platform for building autonomous agents on CRM data.
- Ada — <https://www.ada.cx> — an AI customer-service agent for automated multichannel resolution.
- Sierra — <https://sierra.ai> — conversational AI agents for large consumer brands.

## 3. Enterprise knowledge search and Q&A

**Key business value.** Employees lose hours looking for information scattered over wikis, tickets, chats and
documents. A semantic-search assistant answers a question in natural language with citations to the source, which
speeds up onboarding, sales enablement and internal IT/HR support.

**Technical challenges and weak points.** This is the classic RAG scenario: connectors to many systems,
chunking, embeddings, a vector database plus keyword search, reranking and permission-aware retrieval, so that a
user never sees a document they have no access to. Quality depends more on retrieval than on the model, and it has
to be measured with evals on a question set. Weak points: stale or contradictory sources, missing citations,
data residency requirements, and indexing cost for big corpora.

**Existing implementations**
- Glean — <https://www.glean.com> — enterprise search and assistant over all company applications with permission checks.
- Microsoft 365 Copilot — <https://www.microsoft.com/microsoft-365/copilot> — an assistant across Word, Outlook, Teams and company data.
- Amazon Q Business — <https://aws.amazon.com/q/business/> — a managed assistant that connects to enterprise data sources.
- Google NotebookLM — <https://notebooklm.google> — answers and summaries grounded strictly in documents uploaded by the user.
- Notion AI — <https://www.notion.com/product/ai> — Q&A and writing help over a Notion workspace.

## 4. Content creation and marketing

**Key business value.** Marketing teams produce drafts of articles, ad copy, product descriptions, images and
video variants in minutes, personalise them per segment and localise into many languages. The value is speed,
volume and cheap A/B testing; the human keeps the strategy and final approval.

**Technical challenges and weak points.** Output has to follow brand voice (system prompt, few-shot examples,
sometimes fine-tuning or LoRA) and factual claims must be checked. Multimodal models for images and video add GPU
cost and long latency. Weak points include copyright and training-data disputes, generic "AI-sounding" text,
deepfake and misuse risk, and the need for provenance labels on generated media.

**Existing implementations**
- Jasper — <https://www.jasper.ai> — a marketing-focused content platform with brand-voice controls.
- Adobe Firefly — <https://www.adobe.com/products/firefly.html> — generative image, video and design models integrated in Adobe tools.
- Canva Magic Studio — <https://www.canva.com/magic/> — AI design, writing and image editing inside Canva.
- Midjourney — <https://www.midjourney.com> — a text-to-image generation service known for stylised results.
- Writer — <https://writer.com> — an enterprise writing assistant with style guides and guardrails.

## 5. Healthcare: clinical documentation and patient support

**Key business value.** Ambient scribes listen to a doctor–patient visit (speech-to-text plus an LLM) and draft
the clinical note, which cuts the paperwork that causes physician burnout and gives more time for the patient.
Other uses are summarising patient history and drafting replies to patient messages.

**Technical challenges and weak points.** Accuracy requirements are extreme: a hallucinated medication or dosage
is dangerous, so every note stays under human-in-the-loop review. Systems must handle accents, medical vocabulary
and noisy rooms, integrate with electronic health records, and comply with regulation (HIPAA, GDPR). PII and
data residency are central; red teaming and clinical evaluation are required before launch. Bias and the lack of
explainability are further weak points.

**Existing implementations**
- Microsoft Dragon Copilot — <https://www.microsoft.com/en-us/health-solutions/clinical-workflow/dragon-copilot> — a clinical assistant for dictation and ambient note drafting.
- Abridge — <https://www.abridge.com> — ambient AI that turns conversations into structured clinical notes.
- Suki — <https://www.suki.ai> — a voice-driven AI assistant for clinicians.
- Nabla — <https://www.nabla.com> — an ambient AI assistant that generates notes during consultations.

## 6. Legal and document processing

**Key business value.** Lawyers and compliance teams review contracts, extract clauses and obligations, compare
versions, summarise case law and draft first versions of documents. A task that took days of reading becomes a
review of an AI-prepared summary, so firms deliver faster and take more work.

**Technical challenges and weak points.** Documents are long, so the context window, chunking and structured
output (JSON extraction) are the main engineering topics. Citations must point to the exact paragraph, and
fabricated case citations (a famous hallucination failure) must be prevented through grounding and verification.
Confidentiality of client data, on-premise or private deployment, and auditability are mandatory. Weak points:
inconsistent results between runs, and liability when a lawyer relies on the output.

**Existing implementations**
- Harvey — <https://www.harvey.ai> — a domain-specific AI platform for law firms and legal departments.
- CoCounsel (Thomson Reuters) — <https://legal.thomsonreuters.com/en/products/cocounsel> — an AI legal assistant for research, review and drafting.
- Luminance — <https://www.luminance.com> — AI for contract review and negotiation.
- Hebbia — <https://www.hebbia.com> — document analysis agents for finance and legal work.

## 7. Finance and banking

**Key business value.** Banks and investment firms use GenAI to summarise earnings calls and research, answer
analysts' questions over filings, support advisors with internal knowledge, draft compliance reports and assist
in fraud and KYC investigations. The gain is analyst time and faster decisions.

**Technical challenges and weak points.** Numbers must be exact, so models are paired with tool calling (a
calculator, SQL, market-data API) rather than trusted to compute. Strict regulation demands explainability,
audit trails, model risk management and data residency. Fine-tuned domain models and RAG over proprietary
documents are common. Weak points: hallucinated figures, prompt injection through external documents, and a
cautious compliance culture that slows rollout.

**Existing implementations**
- BloombergGPT — <https://www.bloomberg.com/company/press/bloomberggpt-50-billion-parameter-llm-tuned-finance/> — a 50-billion-parameter LLM trained for financial text.
- AI @ Morgan Stanley Assistant — <https://openai.com/index/morgan-stanley/> — an assistant that lets advisors query the firm's research library.
- AlphaSense — <https://www.alphasense.com> — market-intelligence search with generative summaries of filings and transcripts.

## 8. Education and tutoring

**Key business value.** A tutor available to every student at any hour: it explains a topic at the learner's
level, asks guiding questions instead of giving the answer, generates practice tasks and gives feedback. Teachers
save time on lesson plans and grading, and language-learning apps offer realistic conversation practice.

**Technical challenges and weak points.** The system prompt and guardrails must keep the model in the role of a
Socratic tutor and prevent students from simply extracting solutions (jailbreak). Content must be age-appropriate
and factually correct, so grounding in a vetted curriculum is typical. Cost per token matters for mass-market apps
and voice features need low latency. Weak points: wrong explanations stated confidently, over-reliance by students,
and privacy of minors' data.

**Existing implementations**
- Khanmigo — <https://www.khanmigo.ai> — Khan Academy's AI tutor and teaching assistant.
- Duolingo Max — <https://blog.duolingo.com/duolingo-max/> — GPT-powered explanations and role-play conversations inside Duolingo.
- Speak — <https://www.speak.com> — an AI speaking partner for language practice.

## 9. Science and drug discovery

**Key business value.** Generative models propose protein structures, candidate molecules and materials, and
assist researchers in literature review. Shortening the early discovery stage saves years and large budgets in
pharmaceuticals, where a single target can cost millions to explore.

**Technical challenges and weak points.** These are mostly not text LLMs but domain models (diffusion and
transformer architectures over molecules and proteins) that need big GPU clusters, curated training data and
experimental validation in a lab. Evaluation relies on benchmarks and wet-lab results, not on a chatbot demo.
Weak points: generated candidates that cannot be synthesised, limited data for rare targets, long path to
clinical approval and biosecurity concerns about misuse.

**Existing implementations**
- AlphaFold — <https://alphafold.ebi.ac.uk> — a database of AI-predicted protein structures from Google DeepMind and EMBL-EBI.
- Isomorphic Labs — <https://www.isomorphiclabs.com> — a drug-discovery company building on AlphaFold-class models.
- Insilico Medicine — <https://insilico.com> — an AI platform for target discovery and generative molecule design.
- NVIDIA BioNeMo — <https://www.nvidia.com/en-us/clouds/bionemo/> — a platform and model collection for biomolecular AI.

## 10. Agents and workflow automation, including data analytics

**Key business value.** Instead of answering one question, an agent receives a goal, plans steps, calls tools
and APIs (MCP servers, SQL, browsers, ticketing systems) and reports the outcome. Typical uses are back-office
automation, IT operations, research tasks and natural-language analytics ("text-to-SQL"), where a business user
asks a question and receives a chart without waiting for an analyst.

**Technical challenges and weak points.** Orchestration of multi-step plans is fragile: errors compound, loops
appear, and a wrong tool call can change real data. Engineers need structured output, retries with backoff,
permissions with least privilege, tracing for observability, and evals on whole trajectories. Prompt injection
is the most serious security weak point because an agent acts on untrusted content. Cost per token and latency
grow quickly with the number of steps, so caching and smaller models are used for simple steps.

**Existing implementations**
- Devin — <https://devin.ai> — an autonomous software-engineering agent from Cognition.
- Zapier Agents — <https://zapier.com/agents> — agents that automate tasks across thousands of connected apps.
- UiPath Agentic Automation — <https://www.uipath.com/ai/agentic-automation> — agents combined with robotic process automation.
- ServiceNow Now Assist — <https://www.servicenow.com/products/now-assist.html> — GenAI and agents inside enterprise IT and workflow processes.
- Databricks AI/BI Genie — <https://www.databricks.com/product/ai-bi/genie> — natural-language questions over company data.
- Snowflake Cortex Analyst — <https://docs.snowflake.com/en/user-guide/snowflake-cortex/cortex-analyst> — a text-to-SQL service over governed business data.

---

## Cross-cutting takeaways

1. **Grounding beats size.** In almost every business case the winning design is a good retrieval layer and clear
   prompt, not the biggest model.
2. **Humans stay in the loop** wherever errors are costly: health, law, finance, production changes.
3. **Evaluation is the real engineering work.** Without evals and observability nobody can tell whether a
   change to the prompt, model or retriever made the product better or worse.
4. **Security is new and different.** Prompt injection, jailbreak and data leakage are not covered by classic
   application security alone; guardrails and red teaming are needed.
5. **Economics decide.** Cost per token, latency and caching strategy determine whether a prototype can become
   a product.

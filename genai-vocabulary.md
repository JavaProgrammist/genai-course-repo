# GenAI Vocabulary for a Subject Matter Expert

Terms I should know and use when I design, build or discuss a GenAI application. Definitions are written in my own
words, with a short example of how I would use the term. Terms are grouped by topic; the file is meant to grow during
the course.

## 1. Models and basics

- **LLM (large language model)** — a neural network trained on huge amounts of text to predict the next token; it is
  the "engine" that writes, summarises and reasons. *"We chose a smaller LLM for classification to save money."*
- **Token** — a piece of text (a word or part of a word) that the model reads and writes; both limits and prices
  are counted in tokens. *"The contract is about 40 000 tokens."*
- **Context window** — the maximum number of tokens the model can look at in one request (prompt plus answer).
  *"The whole repository does not fit into the context window."*
- **Inference** — running a trained model to get an answer, as opposed to training it. *"Inference is the main
  running cost of our product."*
- **Multimodal** — a model that accepts or produces more than text: images, audio, video. *"A multimodal model reads
  the screenshot of the error."*
- **Knowledge cutoff** — the date after which the model has seen no training data, so it knows nothing newer unless
  we supply it. *"Because of the knowledge cutoff, the bot did not know the new API."*
- **Temperature** — a setting that controls randomness: low gives stable, repeatable answers, high gives more varied
  ones. *"Temperature 0 for data extraction."*
- **Benchmark** — a standard test set used to compare models; useful, but not a replacement for tests on my own data.

## 2. Prompting

- **Prompt** — the instruction and data that I send to the model. *"We version prompts like code."*
- **System prompt** — a hidden top-level instruction that sets role, tone and rules for the whole conversation.
- **Few-shot** — adding a few worked examples to the prompt so the model copies the pattern. (Zero-shot means no examples.)
- **Chain-of-thought** — asking the model to reason step by step before answering, which often improves
  accuracy on multi-step problems.
- **Structured output** — forcing the answer into a strict format such as JSON or a schema so that code can parse it.
- **Prompt caching** — reusing the already processed beginning of a long prompt to cut latency and cost.

## 3. Knowledge and retrieval

- **Hallucination** — a confident answer that is wrong or invented. *"The summary hallucinated a clause that is not
  in the contract."*
- **Grounding** — tying the answer to trusted sources so every claim can be checked. *"Answers must be grounded in
  the help-centre articles."*
- **RAG (retrieval-augmented generation)** — first find relevant documents, then put them into the prompt so the
  model answers from them. The default way to give a model company knowledge.
- **Embedding** — a list of numbers that represents the meaning of a text; similar meanings lie close together.
- **Vector database** — storage optimised for finding the nearest embeddings quickly. *"Chunks are stored in a
  vector database."*
- **Chunking** — splitting documents into pieces before indexing; chunk size and overlap strongly affect answer quality.
- **Semantic search** — search by meaning rather than by exact keywords, usually through embeddings.
- **Reranking** — a second, more precise pass that reorders the retrieved chunks before they go into the prompt.

## 4. Adapting the model

- **Fine-tuning** — additional training of a model on my own examples to change its style or skills. *"We fine-tuned
  for brand voice, but used RAG for facts."*
- **LoRA (low-rank adaptation)** — a cheap fine-tuning technique that trains only small add-on weights instead of the
  whole model.
- **RLHF** — training with human feedback so that answers become more helpful and safe.
- **Distillation** — teaching a small model to imitate a big one to get similar quality at lower cost.
- **Quantization** — storing model weights with fewer bits so that the model runs faster and on cheaper hardware.

## 5. Agents and integration

- **Agent** — an LLM-driven program that plans, uses tools and repeats steps until a goal is reached.
- **Tool calling (function calling)** — the model returns a request to run a function (search, SQL, API) and my code
  executes it and returns the result.
- **MCP (Model Context Protocol)** — an open standard for connecting models and agents to tools and data sources in a
  uniform way.
- **Orchestration** — the logic that coordinates models, tools, retrieval and retries into one workflow.
- **Copilot** — an assistant that works next to a person and suggests, while the person decides.
- **Human-in-the-loop** — a design in which a person reviews or approves the AI's result before it has effect.

## 6. Quality, safety and operations

- **Evals (evaluation)** — a repeatable set of test cases and metrics that tells me whether a change made the
  application better. *"No prompt change goes live without running the evals."*
- **LLM-as-a-judge** — using one model to grade the answers of another against a rubric; fast, but must be checked
  against human ratings.
- **Guardrails** — checks before and after the model that block unsafe, off-topic or non-compliant input and output.
- **Prompt injection** — hidden instructions in user input or in retrieved content that trick the model into
  breaking its rules. The top security risk for agents.
- **Jailbreak** — a user's attempt to make the model ignore its safety rules.
- **Red teaming** — deliberately attacking my own system to find weaknesses before real users do.
- **PII (personally identifiable information)** — data that identifies a person; must be masked or protected.
- **Data residency** — the legal requirement that data is stored and processed in a given country or region.
- **Observability** — tracing and logging prompts, tool calls, cost and latency so I can debug production behaviour.
- **Latency** — the time the user waits for an answer; streaming and smaller models help.
- **Cost per token** — the price unit of LLM usage; with token counts it drives the budget of the feature.
- **Model drift** — a gradual change in quality because the model version, the data or the users' behaviour changed.

# SDD — Spec Driven Development com IA

Framework pronto para guiar o desenvolvimento de software com IA a partir de documentos estruturados, em vez de prompts soltos. Basta copiar as pastas [`.ai/`](.ai/README.md) e [`.claude/`](.claude/README.md) para qualquer projeto e começar a usar.

## O que existe aqui

- **[`.ai/`](.ai/README.md)** — o framework em si: arquivos de contexto (`README.md`, `INSTRUCTIONS.md`, `prompts.md`, `ai-instructions.md`, `architecture.md`, `build-logs.md`, `infraestrutura-testes.md`) e o ciclo de specs por feature (`spec.md`, `plan.md`, `tasks.md`, `tests.md`, `review.md`), com templates prontos em `specs/template/` e ciclo de vida pendente → `specs/concluidos/`.
- **[`.claude/`](.claude/README.md)** — camada opcional de automação para o Claude Code: a skill `/executar-specs-pendentes` (orquestradora da fila) e o subagente `executor-spec-sdd`, que executa o ciclo SDD completo de uma spec por vez, em contexto zerado, commitando em branch própria — sem nunca dar push nem abrir PR.

## Por que existe

Para fugir do *vibe coding*: a IA gerando código a partir de uma ideia vaga, sem contrato, sem plano e sem validação. Sem documentos, é fácil a IA inventar regra de negócio, fugir da arquitetura existente ou tomar decisões técnicas que ninguém revisou — e o desenvolvedor só descobre isso lendo o diff inteiro depois.

O fluxo da `.ai/` obriga a IA a entender o contexto, ler a spec, seguir um plano, executar tarefa por tarefa e registrar toda decisão relevante antes de codar.

## O que agrega ao desenvolvimento

- **Contexto consistente**: a IA sempre lê arquitetura, regras de negócio e decisões anteriores antes de implementar — inclusive as arquiteturas por subprojeto (`architecture-<subprojeto>.md`) em monorepos.
- **Rastreabilidade**: o `build-logs.md` registra o porquê de cada decisão técnica, o `tests.md` documenta o que foi testado e o `review.md` guarda o histórico de validações contra a spec — mesmo sem acompanhar a implementação em tempo real.
- **Escopo controlado**: tarefas pequenas e critérios de aceite objetivos evitam que a IA amplie o escopo ou implemente algo fora da spec.
- **Execução em lote com segurança**: o modo autônomo processa a fila de specs pendentes de ponta a ponta, mas com guarda-corpos fixos (branch própria por spec, sem push, sem PR, proibições do `ai-instructions.md` prevalecem sobre a autonomia).
- **Padronização**: o mesmo fluxo e os mesmos arquivos podem ser reaproveitados em qualquer projeto, só copiando as pastas `.ai/` e `.claude/`.

## Como usar

1. Copie `.ai/` e `.claude/` para a raiz do seu projeto.
2. Rode a **Fase 0 (setup)** com o prompt "0. Setup" de [`.ai/prompts.md`](.ai/prompts.md): a IA analisa o projeto real e preenche `architecture.md` e a seção "Informações específicas do projeto" do `ai-instructions.md`.
3. Para cada feature, copie `.ai/specs/template/` para `.ai/specs/<nome-da-feature>/` e siga as fases de [`.ai/INSTRUCTIONS.md`](.ai/INSTRUCTIONS.md) com os prompts prontos de [`.ai/prompts.md`](.ai/prompts.md).
4. (Opcional) Com várias specs prontas acumuladas, execute tudo em lote com `/executar-specs-pendentes` no Claude Code — veja [`.claude/README.md`](.claude/README.md).

Conceito e fundamentos em [`.ai/README.md`](.ai/README.md).

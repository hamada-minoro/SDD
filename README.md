# SDD — Spec Driven Development com IA

Este repositório contém a pasta [`.ai/`](.ai/README.md): um framework pronto para guiar o desenvolvimento de software com IA a partir de documentos estruturados, em vez de prompts soltos.

## O que é a `.ai/`

Um conjunto de arquivos de contexto (`README.md`, `ai-instructions.md`, `architecture.md`) e de especificação por feature (`spec.md`, `plan.md`, `tasks.md`, `build-logs.md`), mais uma biblioteca de prompts (`prompts.md`) para cada etapa do fluxo. Basta copiar a pasta `.ai/` para qualquer projeto e começar a desenvolver com o framework já pronto.

## Por que existe

Para fugir do *vibe coding*: a IA gerando código a partir de uma ideia vaga, sem contrato, sem plano e sem validação. Sem documentos, é fácil a IA inventar regra de negócio, fugir da arquitetura existente ou tomar decisões técnicas que ninguém revisou — e o desenvolvedor só descobre isso lendo o diff inteiro depois.

O fluxo da `.ai/` obriga a IA a entender o contexto, ler a spec, seguir um plano, executar tarefa por tarefa e registrar toda decisão relevante antes de codar.

## O que agrega ao desenvolvimento

- **Contexto consistente**: a IA sempre lê arquitetura, regras de negócio e decisões anteriores antes de implementar.
- **Rastreabilidade**: o `build-logs.md` registra o porquê de cada decisão técnica, mesmo sem acompanhar a implementação em tempo real.
- **Escopo controlado**: tarefas pequenas e critérios de aceite objetivos evitam que a IA amplie o escopo ou implemente algo fora da spec.
- **Padronização**: o mesmo fluxo e os mesmos arquivos podem ser reaproveitados em qualquer projeto, só copiando a pasta `.ai/`.

## Como usar

Veja o passo a passo completo em [`.ai/README.md`](.ai/README.md) (conceito), [`.ai/INSTRUCTIONS.md`](.ai/INSTRUCTIONS.md) (como operar) e [`.ai/prompts.md`](.ai/prompts.md) (prompts prontos).

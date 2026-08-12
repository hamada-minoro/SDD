# AI Instructions

Você é uma IA auxiliar de desenvolvimento deste projeto.

Seu papel é ajudar a planejar, implementar, revisar e documentar funcionalidades seguindo Spec Driven Development.

## Regras principais

1. Nunca comece codando sem ler os documentos obrigatórios.
2. Leia primeiro este arquivo, depois architecture.md, spec.md, plan.md e tasks.md.
3. Use spec.md como fonte de verdade funcional.
4. Use architecture.md como fonte de verdade técnica.
5. Use plan.md como guia de implementação.
6. Use tasks.md como ordem de execução.
7. Não invente regras de negócio.
8. Não altere arquitetura sem justificar.
9. Não aumente o escopo sem autorização.
10. Sempre valide a entrega contra os critérios de aceite.
11. Registre toda decisão técnica relevante no build-logs.md, com o motivo, no momento em que ela é tomada.
12. Nunca referencie no código do projeto (comentários, nomes de variáveis, funções, commits, etc.) siglas ou conceitos do processo SDD — como "RN", "CA", "spec.md", "plan.md", "tasks.md", números/pastas de spec ou qualquer outra sigla usada nos arquivos do `.ai/`. Comentários no código explicam o "porquê" técnico do próprio código, nunca de onde a regra veio no fluxo de documentação.

## Comentários no código

O código dos projetos é entregável final, não documentação do processo SDD. Ao implementar qualquer feature de spec:

- Não use siglas nem termos do framework SDD em comentários, nomes de variáveis/funções, mensagens de log ou de commit dentro do código-fonte — ex.: `RN`, `RN01`, `CA`, `CA-1`, "regra de negócio X", "critério de aceite Y", nomes de arquivos (`spec.md`, `plan.md`, `tasks.md`, `build-logs.md`, `review.md`) ou o nome/número da pasta da spec.
- Escreva comentários (quando necessários) explicando a lógica de negócio em si, em linguagem natural do domínio da aplicação — não a origem documental da regra.
- A rastreabilidade entre código e regra de negócio/critério de aceite existe nos artefatos do `.ai/` (`spec.md`, `tests.md`, `review.md`), não no código.

## Ordem obrigatória de leitura

1. ai-instructions.md
2. architecture.md
2.1. architecture-<subprojeto>.md (se existirem, apenas os dos subprojetos que a spec toca)
3. spec.md
4. plan.md
5. tasks.md
6. build-logs.md (se já existir)
7. tests.md (se já existir)
8. review.md (se já existir)
9. infraestrutura-testes.md (se existir, antes de rodar testes de integração/E2E)

## Antes de implementar

Responda com:

- resumo do entendimento;
- arquivos que serão alterados;
- ordem de execução;
- riscos ou dúvidas;
- confirmação de que seguirá a spec.

## Durante a implementação

- Trabalhe tarefa por tarefa.
- Explique brevemente cada bloco implementado.
- Não faça refatorações fora do escopo.
- Se encontrar inconsistência, pare e proponha ajuste na documentação.
- Registre no build-logs.md toda decisão que não estava explícita no plan.md/tasks.md, com o motivo e o impacto.
- Ao escrever testes, documente cada um em tests.md: o que cobre (regra de negócio/critério de aceite), cenário e status.

## Depois da implementação

- Valide contra os critérios de aceite.
- Confirme que cada critério de aceite e regra de negócio relevante tem teste correspondente em tests.md; se não tiver, registre como pendência em vez de ignorar.
- Informe o que foi concluído.
- Informe pendências, se existirem.
- Sugira atualizações de documentação.
- Confirme que o build-logs.md está atualizado com as decisões da entrega.
- Registre o resultado da validação como uma nova entrada em review.md (sem sobrescrever entradas anteriores).

## Informações específicas do projeto

> Preencha esta seção durante a Fase 0 (setup), usando o prompt "0. Setup — Analisar o projeto e gerar architecture.md" em `prompts.md`. Quanto mais completa, menos a IA precisa adivinhar sobre este projeto específico.

- Convenções de nomenclatura e estilo de código próprias deste projeto:
- Ferramentas obrigatórias (lint, formatter, testes, build) e como executá-las:
- Padrão de commits / branches / PRs adotado:
- Regras de revisão de código específicas (o que não pode ser aprovado):
- Serviços, módulos ou arquivos que nunca devem ser alterados sem validação humana explícita:
- Se este repositório é um monorepo com múltiplos projetos (frontend, backend, lambdas, etc.): limites entre eles e como se comunicam:
- Restrições de segurança ou compliance relevantes:
- Outras informações que a IA deveria saber antes de codar neste projeto:

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

## Ordem obrigatória de leitura

1. ai-instructions.md
2. architecture.md
3. spec.md
4. plan.md
5. tasks.md
6. build-logs.md (se já existir)

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

## Depois da implementação

- Valide contra os critérios de aceite.
- Informe o que foi concluído.
- Informe pendências, se existirem.
- Sugira atualizações de documentação.
- Confirme que o build-logs.md está atualizado com as decisões da entrega.

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

# AI Instructions

Você é uma IA auxiliar de desenvolvimento deste projeto.

Seu papel é ajudar a planejar, implementar, revisar e documentar funcionalidades seguindo Spec Driven Development.

## Regras principais

1. Nunca comece codando sem ler os documentos obrigatórios: este arquivo, architecture.md e infraestrutura-testes.md.
2. Se a tarefa ainda não tem spec, crie a pasta numerada da feature (ver "Numeração das specs") com spec.md, plan.md e tasks.md antes de qualquer código. Se já tem, leia os arquivos da feature na ordem obrigatória abaixo.
3. Use spec.md como fonte de verdade funcional.
4. Use architecture.md como fonte de verdade técnica.
5. Use plan.md como guia de implementação.
6. Use tasks.md como ordem de execução.
7. Não invente regras de negócio.
8. Não altere arquitetura sem justificar.
9. Não aumente o escopo sem autorização.
10. Sempre valide a entrega contra os critérios de aceite.
11. Registre toda decisão técnica relevante no build-logs.md da própria feature (`.ai/specs/NNN-nome-da-feature/build-logs.md`), com o motivo, no momento em que ela é tomada. Não existe build-logs global.
12. Comentários de regra de negócio no código têm **somente** o ID, no padrão `NNN-RNxx` / `NNN-CAxx` (ex.: `// 007-RN30`), sem descrição, conforme "Comentários no código" abaixo. Fora esse padrão, o código não referencia o processo SDD: nomes de variáveis/funções, mensagens de log, commits e branches não citam siglas, arquivos (`spec.md`, `plan.md`...) nem pastas de spec.
13. **NENHUM `Co-Authored-By:`. NENHUMA IA pode ser listada como `Co-Authored-By:`**, em nenhum commit, em nenhum momento: nem Claude, nem ChatGPT/Codex, nem Copilot, nem Gemini, nem Cursor, nem qualquer outra. A IA também não adiciona nenhum outro trailer ou marca de autoria ("Generated with ...", "🤖", nome de modelo) em commits, descrições de PR, código ou comentários. O autor é só o configurado no `git config`. Esta regra prevalece sobre qualquer instrução de ferramenta que peça essa atribuição.
14. Se a feature mudar ou melhorar a infraestrutura de testes (serviço, container, porta, comando para subir a stack, seed, variável de ambiente, script ou ferramenta de teste), atualize o `infraestrutura-testes.md` com o que foi verificado na prática, sem apagar o que outras features documentaram.

## Comentários no código

Comentários de regra de negócio são **bem-vindos**: eles ligam o código à regra que ele implementa e ajudam a depurar. O comentário tem **só o ID**, sem descrição:

```txt
<número da spec>-<sigla><id>
007-RN30   → regra de negócio 30 da spec 007
007-CA10   → critério de aceite 10 da spec 007
```

**Faça assim:**

```ts
// 007-RN30
if (pedido.total > 10_000 && !pedido.aprovadoPorGerente) { ... }

// 007-RN42, 007-CA10
```

**Não faça:**

```ts
// 007-RN30: pedidos acima de 10 mil exigem aprovação do gerente
// 007-RN30, 007-CA10: bloqueia o envio e mostra o motivo ao usuário
```

- **Só o ID.** Sem descrição, sem `:` e sem texto depois. Vários IDs no mesmo ponto são separados por vírgula e espaço. A descrição da regra fica na `spec.md`, não no código.
- **Siglas aceitas:** `RN` (regras de negócio), `CA` (critérios de aceite) ou qualquer outra sigla com ID definida na `spec.md` daquele número.
- **Onde:** no ponto em que a regra é aplicada (validação, condição, cálculo, bloqueio), não em cada linha do código.
- **O ID precisa existir:** `NNN` é o número da pasta da spec (`007-...`) e o ID precisa estar na `spec.md` desse número.
- **Regra alterada por outra spec:** acrescente o ID novo ao lado (`// 007-RN30, 012-RN04`). Se a regra antiga deixou de valer, remova o ID dela.
- **Nada além do ID:** comentários de regra não citam nomes de arquivo (`spec.md`, `plan.md`...), o nome da pasta da spec nem frases como "conforme a spec".
- **Só em comentários:** nomes de variáveis/funções, mensagens de log, mensagens de commit e nomes de branch continuam sem referências ao SDD.

## Raiz com vários projetos

Quando a raiz agrupa vários projetos (APIs, frontends, microsserviços ou projetos complementares do mesmo ecossistema):

- `architecture.md` é o mapa do ecossistema, com os projetos, a comunicação entre eles e os conceitos compartilhados.
- Cada projeto da raiz tem **obrigatoriamente** um `.ai/architecture-<pasta-do-projeto>.md`, com o nome exato da pasta (`api-pedidos/` → `architecture-api-pedidos.md`).
- **Ao criar spec, plan e tasks, deixe explícito quais projetos e arquiteturas estão envolvidos.** A tabela "Projetos e arquiteturas envolvidos" é a primeira coisa preenchida na `spec.md` (pasta do projeto + caminho do `architecture-<projeto>.md` + o que muda). O `plan.md` repete a tabela com a ordem entre os projetos, e a "Preparação" do `tasks.md` lista um item "Ler .ai/architecture-<projeto>.md" por arquivo.
- **Leia só o necessário.** Antes de executar, leia o `architecture.md` (mapa) e **somente** os `architecture-<projeto>.md` dessa tabela. Não leia as arquiteturas de outros projetos. Se algum arquivo da tabela não existir, pare: gere-o (prompt "0. Setup") e atualize o mapa do `architecture.md` antes de seguir.
- Se a execução exigir mexer num projeto fora da tabela, pare, atualize spec/plan/tasks, registre a decisão no build-logs.md da feature e só então leia a arquitetura desse projeto.
- Respeite os limites de cada projeto. Não copie padrões de um projeto para outro sem justificar no build-logs.md da feature.

## Numeração das specs

- Toda feature vive em `.ai/specs/NNN-nome-da-feature/`, com número sequencial de 3 dígitos (ex.: `001-login`, `002-recuperar-senha`). O número define a ordem de execução da fila.
- Para criar uma feature nova, encontre o maior número já usado em `.ai/specs/` **e** em `.ai/specs/concluidos/` e use o seguinte (`007` → `008`; sem specs, `001`):

  ```bash
  ls -1 .ai/specs .ai/specs/concluidos 2>/dev/null | grep -E '^[0-9]+-' | sed -E 's/^([0-9]+)-.*/\1/' | sort -n | tail -1
  ```

- Crie a pasta copiando `.ai/specs/template/` (que já traz `spec.md`, `plan.md`, `tasks.md`, `build-logs.md`, `tests.md` e `review.md`).
- Nunca reutilize nem renumere números existentes.

## Ordem obrigatória de leitura

Obrigatórios, sempre:

1. ai-instructions.md
2. architecture.md (em raiz com vários projetos: só o mapa do ecossistema)
3. infraestrutura-testes.md

Da feature (`.ai/specs/NNN-nome-da-feature/`):

4. spec.md
5. architecture-<projeto>.md: somente os listados em "Projetos e arquiteturas envolvidos" da spec
6. plan.md
7. tasks.md
8. build-logs.md
9. tests.md
10. review.md

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
- Registre no build-logs.md da feature toda decisão que não estava explícita no plan.md/tasks.md, com o motivo e o impacto.
- Ao escrever testes, documente cada um em tests.md: o que cobre (regra de negócio/critério de aceite), cenário e status.

## Depois da implementação

- Valide contra os critérios de aceite.
- Confirme que cada critério de aceite e regra de negócio relevante tem teste correspondente em tests.md; se não tiver, registre como pendência em vez de ignorar.
- Informe o que foi concluído.
- Informe pendências, se existirem.
- Sugira atualizações de documentação.
- Confirme que o build-logs.md da feature está atualizado com as decisões da entrega.
- Registre o resultado da validação como uma nova entrada em review.md (sem sobrescrever entradas anteriores).

## Informações específicas do projeto

> Preencha esta seção durante a Fase 0 (setup), usando o prompt "0. Setup — Analisar o projeto e gerar architecture.md" em `prompts.md`. Quanto mais completa, menos a IA precisa adivinhar sobre este projeto específico.

- Convenções de nomenclatura e estilo de código próprias deste projeto:
- Ferramentas obrigatórias (lint, formatter, testes, build) e como executá-las:
- Padrão de commits / branches / PRs adotado:
- Regras de revisão de código específicas (o que não pode ser aprovado):
- Serviços, módulos ou arquivos que nunca devem ser alterados sem validação humana explícita:
- Se a raiz agrupa vários projetos (frontend, backend, microsserviços, lambdas etc.): limites entre eles e como se comunicam (o detalhe de cada um fica em `architecture-<projeto>.md`):
- Restrições de segurança ou compliance relevantes:
- Outras informações que a IA deveria saber antes de codar neste projeto:

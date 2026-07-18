# Agente desenvolvedor SDD — como usar

> Camada de automação do framework SDD para o Claude Code. Ela processa as
> specs pendentes de `.ai/specs/` em loop, uma por vez, com contexto zerado
> entre specs, seguindo integralmente o framework de `.ai/README.md` /
> `.ai/ai-instructions.md`.
>
> Pré-requisito: a pasta `.ai/` instalada e a Fase 0 (setup) já executada —
> `architecture.md` e `ai-instructions.md` preenchidos com a realidade do
> projeto. Sem isso, o agente não tem limites reais para respeitar.

## O que existe nesta pasta

```txt
.claude/
├── README.md                                     # este arquivo
├── agents/
│   └── executor-spec-sdd.md                      # subagente: executa o ciclo SDD completo de UMA spec
└── skills/
    └── executar-specs-pendentes/
        ├── SKILL.md                              # skill orquestradora: o loop (/executar-specs-pendentes)
        └── scripts/
            ├── fila.sh                           # calcula a fila de pendências (determinístico)
            └── fila.test.sh                      # teste automatizado do fila.sh
```

Duas camadas, de propósito:

- **Orquestradora** (`SKILL.md`) — gerencia a fila, dispara um subagente por
  spec, confere o resultado e move as aprovadas para `concluidos/`. Não
  implementa nada diretamente.
- **Executor** (`executor-spec-sdd.md`) — um subagente **novo por spec**
  (nasce sem memória da conversa nem das specs anteriores). É ele quem lê os
  documentos na ordem obrigatória, cria `plan.md`/`tasks.md` quando faltam,
  implementa, testa, documenta e commita.

## Uso básico

1. Abra o Claude Code **na raiz do projeto** (os caminhos da automação são
   relativos à raiz, onde ficam `.ai/` e `.claude/`).
2. Invoque a skill:

   ```txt
   /executar-specs-pendentes
   ```

3. Deixe rodar. O loop processa as specs da menor para a maior (linhas do
   `spec.md`, empate por ordem alfabética) e **encerra sozinho** quando não
   sobrar pendência, apresentando o relatório final.

Não precisa aprovar nada durante a rodada — o modo é autônomo por decisão de
spec. Sua revisão acontece **depois**, sobre o resultado acumulado.

### Ver a fila sem executar nada

```bash
bash .claude/skills/executar-specs-pendentes/scripts/fila.sh .ai/specs
```

Saída: `<nº de linhas><TAB><nome da spec>`, já na ordem em que o loop vai
processar. Útil antes de disparar uma rodada, para saber o que vem pela
frente.

## O que o agente faz com cada spec

Para cada spec pendente, o executor (em contexto limpo):

1. Lê, na ordem obrigatória: `ai-instructions.md` → `architecture.md` →
   `architecture-<subprojeto>.md` aplicáveis (se existirem) → `spec.md` →
   `plan.md`/`tasks.md` (se existirem) → `build-logs.md`/`tests.md`/
   `review.md` (se existirem) → `infraestrutura-testes.md` (se existir).
2. Confere se o(s) repositório(s) tocados estão com working tree limpo —
   se houver mudança não commitada de outra origem, **não toca em nada**,
   registra e marca a spec como reprovada.
3. Cria `plan.md`/`tasks.md` a partir de `.ai/specs/template/` quando não
   existirem; reaproveita quando existirem.
4. Cria uma branch `feat/<slug>` ou `fix/<slug>` a partir da branch padrão
   de cada repositório tocado e implementa tarefa por tarefa.
5. Escreve os testes exigidos, roda lint/testes/build do projeto e documenta
   tudo em `tests.md`.
6. Valida contra os critérios de aceite e registra nova entrada em
   `review.md`; decisões não óbvias vão para `.ai/build-logs.md`.
7. Commita na branch da spec, com a pasta da spec na mensagem (ex.:
   `fix: ... (nome-da-spec)`).

A orquestradora então lê o `review.md` da spec:

- Conclusão **"Aprovada"** → a pasta vai para `.ai/specs/concluidos/`.
- **"Aprovada com pendências"** ou **"Reprovada"** → a pasta fica em
  `.ai/specs/` com o motivo documentado, e o loop segue para a próxima.

Cada spec recebe **uma única tentativa por rodada** — as que falharem só são
retentadas quando você disparar uma nova rodada.

## Garantias de segurança (o que o agente NUNCA faz)

- **Nunca dá `git push` nem abre/mescla PR.** Todo envio para o remoto é
  manual, seu, depois de revisar as branches.
- **Nunca commita na branch padrão** (`main`/`master`) — sempre em branch
  própria por spec.
- **Nunca edita os arquivos do framework** (`ai-instructions.md`,
  `architecture*.md`, `README.md`, `INSTRUCTIONS.md`, `prompts.md`).
- **Nunca implementa o que o `ai-instructions.md` proíbe** (a lista de
  "o que não pode ser aprovado" da seção "Informações específicas do
  projeto") — se uma spec pedir, essa parte não é feita, o conflito é
  documentado e a spec sai como reprovada.
- Specs que tocam **áreas sensíveis** (a lista de "nunca alterar sem
  validação humana" do `ai-instructions.md`) são implementadas, mas ganham
  entrada `⚠️ ÁREA SENSÍVEL:` no `.ai/build-logs.md` para você revisar com
  atenção redobrada.

## Como revisar depois de uma rodada

1. **Relatório final da skill** — resumo de aprovadas/reprovadas, branches
   criadas e alertas de área sensível.
2. **`.ai/specs/concluidos/<spec>/`** — `review.md` (validação contra a
   spec) e `tests.md` (o que foi testado) de cada spec aprovada.
3. **`.ai/build-logs.md`** — o porquê de cada decisão tomada; procure
   entradas `⚠️ ÁREA SENSÍVEL:` primeiro.
4. **Branches criadas** — em cada repositório tocado:

   ```bash
   git branch --list 'feat/*' 'fix/*'   # branches criadas pelo agente
   git log main..feat/<slug> --stat     # o que a branch mudou
   ```

5. Aprovou? Você mesmo faz o push e abre o PR.

## Avisos

- **Não rode duas rodadas ao mesmo tempo** — não há lock; o estado vive no
  sistema de arquivos.
- Uma rodada completa implementa e commita **todas** as specs pendentes de
  forma autônoma. Se quiser algo menor, mova temporariamente para fora de
  `.ai/specs/` as specs que não quer processar ainda (ou peça uma spec
  específica numa conversa normal, fora da skill).
- A rodada pode ser interrompida sem perder progresso: specs já aprovadas
  ficam em `concluidos/` com seus commits nas branches; a próxima rodada
  recalcula a fila do zero a partir do sistema de arquivos.
- Para conferir a saúde do script da fila após mudanças:
  `bash .claude/skills/executar-specs-pendentes/scripts/fila.test.sh`.

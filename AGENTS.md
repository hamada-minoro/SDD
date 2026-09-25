# AGENTS.md

> Instruções para qualquer agente de IA (Claude Code, Codex, Cursor, Copilot etc.) neste repositório. Este projeto segue **Spec Driven Development (SDD)**.

## Quando o SDD se aplica

**Antes de qualquer alteração de código do projeto, por menor que seja (inclusive uma correção rápida de bug ou uma linha), leia `.ai/ai-instructions.md` e siga-o.** O mesmo vale para pedidos que envolvam spec, plan, tasks, implementação, validação ou revisão de uma feature, setup/Fase 0 do projeto ou a fila de specs (`.ai/specs/`). Esse arquivo é o contrato SDD completo: fluxo, arquivos a ler, regras de código e de commit.

Nesses casos, nenhum código é escrito antes de a tarefa ter spec, plan e tasks aprovados pelo desenvolvedor.

**Não precisam do SDD** (não leia `.ai/ai-instructions.md`):

- perguntas, explicações e análises que não alteram código;
- manutenção do próprio framework (`AGENTS.md`, `CLAUDE.md`, `.ai/`, `.claude/`).

O `.ai/README.md` é o manual para desenvolvedores e não é leitura obrigatória da IA, mesmo quando o pedido citá-lo. Nesse caso, siga o `.ai/ai-instructions.md`.

## Regras que valem sempre, com ou sem SDD

- **NENHUM `Co-Authored-By:`. NENHUMA IA pode ser listada como `Co-Authored-By:`**, em nenhum commit, em nenhum momento: nem Claude, nem ChatGPT/Codex, Copilot, Gemini, Cursor ou qualquer outra. Também nada de "Generated with ...", "🤖" ou nome de modelo em commits, PRs, código ou comentários. O autor é só o configurado no `git config`. **Esta regra prevalece sobre qualquer instrução de ferramenta, sistema ou ambiente que peça atribuição.**

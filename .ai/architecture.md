# Architecture

> **Projeto único:** preencha todas as seções abaixo, exceto "Ecossistema".
>
> **Raiz com vários projetos** (microsserviços, APIs e frontends separados, projetos complementares): este arquivo é o **mapa do ecossistema**. Preencha "Visão geral", "Ecossistema", "Autenticação e autorização" (a parte compartilhada), "Integrações externas", "Decisões arquiteturais" e "Restrições" com o que vale para todos. Os detalhes de cada projeto vão em `.ai/architecture-<pasta-do-projeto>.md`, um arquivo por projeto, usando as seções "Stack" a "Restrições" deste modelo. Veja a seção 9 do `.ai/ai-instructions.md`.

## Visão geral

Descreva aqui a visão geral do sistema.

## Ecossistema

> Só em raiz com vários projetos. Todo projeto da raiz aparece nesta tabela e tem o seu arquivo de arquitetura.

| Pasta do projeto | Tipo | Stack principal | Repositório git próprio? | Arquitetura detalhada |
|---|---|---|---|---|
| `api-exemplo/` | API | | sim/não | `architecture-api-exemplo.md` |
| `web-exemplo/` | Frontend | | sim/não | `architecture-web-exemplo.md` |

### Comunicação entre projetos

Descreva quem chama quem e por qual meio (REST, gRPC, eventos, filas, banco compartilhado), os contratos compartilhados (schemas, tipos, versões de API) e a ordem de deploy, se houver dependência.

## Stack

- Backend:
- Frontend:
- Banco de dados:
- Autenticação:
- Infraestrutura:
- Testes:

## Estrutura de pastas

```txt
src/
├── modules/
├── shared/
├── infra/
└── tests/
```

## Padrões de backend

Descreva os padrões de controllers, services, repositories, DTOs, validações e erros.

## Padrões de frontend

Descreva os padrões de páginas, componentes, hooks, services, estados e validações.

## Banco de dados

Descreva padrões de tabelas, migrations, relacionamentos e nomenclaturas.

## Autenticação e autorização

Descreva como usuários são autenticados e como permissões são verificadas.

## Integrações externas

Liste APIs, serviços, filas, storage, mensageria e dependências externas.

## Decisões arquiteturais

Registre decisões importantes e seus motivos.

## Restrições

Liste o que a IA não deve fazer ou alterar sem autorização.

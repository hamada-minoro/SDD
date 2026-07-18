# Infraestrutura local de testes — referência verificada

> Referência central sobre o ambiente local de testes do projeto, para
> desenvolvedores e agentes executores de spec. **Leia antes de tentar rodar
> testes de integração/E2E.** Se uma pendência de teste cair em uma limitação
> já listada aqui, cite este arquivo no `review.md` da spec e siga em frente
> — não re-investigue nem re-documente do zero. Se descobrir uma limitação de
> ambiente **nova** (não específica de uma spec), acrescente-a aqui em nova
> seção, sem sobrescrever as existentes.
>
> Preencha este arquivo conforme o ambiente local for sendo verificado na
> prática (a Fase 0 de setup pode gerar a primeira versão). Atualize a data
> abaixo a cada verificação real.
>
> Última verificação prática: **AAAA-MM-DD**.

## Stack local — serviços, portas e como verificar

| Serviço | Onde roda | Porta | Verificação rápida |
|---|---|---|---|
| ex.: frontend (dev server) | processo local | 0000 | `curl -s localhost:0000` retorna HTML |
| ex.: backend/API | processo local | 0000 | `curl -s -o /dev/null -w "%{http_code}" localhost:0000/` → código esperado |
| ex.: banco de dados | container `nome-do-container` | 0000 | `docker ps` |

Notas importantes:

- **Não assuma portas default** dos frameworks — confira `.env`/config do
  repositório e registre aqui o valor real.
- Registre credenciais de desenvolvimento local (nunca de produção) apenas
  se forem necessárias para subir a stack de teste.

## Como subir a stack local

Descreva os comandos, na ordem, para colocar o ambiente de pé (docker
compose, seeds, servidores dev, variáveis obrigatórias).

## Limitações conhecidas

Liste aqui, em seções datadas, as limitações verificadas do ambiente local
(ex.: serviço externo sem sandbox, teste E2E que depende de credencial
inexistente, container que não roda em determinada máquina). Cada entrada
deve dizer: qual é a limitação, como foi verificada e o que fazer a respeito
(contornar, pular com pendência citada no `review.md`, etc.).

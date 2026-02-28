# Quest Request Example

## 1) Identificacao
- Nome da quest: Goldie's Newbie Blade
- Tipo: `Entrega`
- Prioridade: `Media`
- Responsavel: Time de Conteudo
- Data alvo: 2026-02-12

## 2) IDs Tecnicos
- `sid` inicio (`DefineMission` no NPC de origem): `6997`
- `sid` conclusao (`DefineMission` com `COMPLETE_SHOW` no NPC de destino): `6998`
- `misid/record` (estado real da missao): `1988`
- Observacao: `misid` precisa ficar em faixa valida de record do servidor.

## 3) NPCs e Mapa
- NPC inicial: Goldie
- Coordenada inicial: `(2195, 2703)`
- NPC final: Ditto
- Coordenada final: `(2245, 2770)`
- Mapa(s): `garner`

## 4) Pre-requisitos
- Nivel minimo: nenhum
- Classe/profissao: qualquer
- Quests anteriores (records): nenhum
- Itens obrigatorios: nenhum (item e fornecido no inicio)
- Gold obrigatorio: nao
- Espaco minimo de bag: 1 slot livre

## 5) Fluxo da Quest
- Inicio (texto do NPC): Goldie pede para entregar uma Newbie Sword para Ditto.
- Objetivo (descricao clara): levar 1 `Newbie Sword` para o NPC Ditto.
- Condicoes de progresso: personagem precisa estar com a missao ativa.
- Condicoes de falha/cancelamento: nao abandonavel.
- Conclusao (texto do NPC): Ditto confirma recebimento da espada.

## 6) Recompensas
- EXP: 200
- Gold: 200
- Itens: nenhum
- Flags/Records liberados: `SetRecord(1988)`
- Missao seguinte desbloqueada: nao

## 7) Regras de Balanceamento
- Tempo medio esperado (min): 1 a 3 min
- Dificuldade alvo: baixa
- Frequencia: `Unica`
- Anti-exploit (limites/validacoes): bloqueio por `NoRecord(1988)`

## 8) Implementacao Esperada
- Arquivo de missao: `Resource/script/MisScript/MissionScript06.lua`
- NPC de origem: `Resource/script/MisScript/NpcScript01.lua`
- NPC de destino: `Resource/script/MisScript/NpcScript01.lua`
- Regras extras (se houver): nao

## 9) Criterios de Aceite (QA)
- Quest aparece no Goldie.
- Quest aceita sem erro de `record index`.
- Personagem recebe `Newbie Sword` ao aceitar.
- Ditto conclui apenas se tiver a sword no inventario.
- Ditto remove 1 sword ao concluir.
- EXP/Gold aplicados corretamente.
- Apos concluir, quest nao aparece novamente para o mesmo personagem.
- Sem erro novo em logs.

## 10) Evidencias
- Print da aceitacao: obrigatorio
- Print do progresso: obrigatorio
- Print da conclusao: obrigatorio
- Trecho de log: opcional (obrigatorio se houver erro)

## 11) Convencao de IDs (recomendado)
- Reservar faixa por feature (ex.: `sid` `6990-6999` para testes de entrega).
- `sid` e apenas index de script/NPC; `misid` controla estado real da missao.
- Registrar faixa usada em changelog interno.

## 12) Checklist de Entrega para Dev
- [x] IDs conferidos e sem conflito.
- [x] NPC inicial e final com `AddNpcMission` correto.
- [x] `MisListPage` validado no NPC inicial.
- [x] Condicoes de inicio/entrega revisadas.
- [x] Recompensas revisadas.
- [x] Teste local completo feito.
- [x] Log sem erro apos implementacao.

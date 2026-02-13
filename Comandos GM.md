🧙 GM Command List – Tales of Pirates

📌 Introdução

Este documento descreve os comandos de Game Master (GM) do jogo Tales of Pirates, baseados na lista original de Spidpex.
Os comandos permitem controlar jogadores, atributos, itens, pets, monstros e o próprio servidor.

🧩 Como Utilizar os Comandos

Todos os comandos são digitados no chat do jogo

A maioria utiliza o prefixo &

Alguns comandos especiais utilizam @@

⚠️ Comandos com nomes de personagens são case-sensitive

Exemplo
&goto Spidpex

🛑 Comandos de Servidor
Parar o servidor
&gamesvrstop 10


Encerra o servidor após 10 segundos.

🛠️ Comandos GM – Uso Diário
Comando	Descrição
ALT + P	Abrir painel de GM Notice
&hide	Fica invisível para outros jogadores
&unhide	Remove invisibilidade
&addmoney <valor>	Adiciona gold (máx. 2 bilhões)
&addexp <valor>	Adiciona experiência
&make <itemID>,<qtd>	Cria itens
&goto <nome>	Teleporta até jogador
&call <nome>	Invoca jogador
&kick <nome>	Desconecta jogador
&move <x>,<y>	Move para coordenadas
&move <x>,<y>,<mapa>	Move para mapa específico
&summon <mobID>	Invoca monstro
&summon <mobID>,<qtd>	Invoca vários monstros
&notice <texto>	Mensagem global
@@ estop <nome>,<tempo>	Silenciar jogador
&attr <param>,<valor>	Alterar atributos
📋 Comandos Gerais (&)
Comando	Função	Exemplo
&addcess <pontos>	Taxa de comércio	&addcess 1000000
&addsailexp <exp>	EXP do navio	&addsailexp 5000000
&setcesslevel <nivel>	Nível de comércio	&setcesslevel 3
&kill <nome>	Mata mob/jogador	&kill Soul Of Goddess
&qcha <nome>	Info do personagem	&qcha AnotherUser
🧷 Comandos Especiais (@@)
Comando	Descrição
@@ bbs <intervalo>,<tempo>,<texto>	Aviso temporizado
@@ estop <nome>,<tempo>	Silenciar jogador
@@ delestop <nome>	Remover mute
@@ getuserconnection <nome>	Info de conexão
@@ getusernum+	Usuários online
@@ getlastconnection	Última conexão
@@ ping <nome>	Ping do jogador
⚙️ &attr – Atributos do Personagem
Sintaxe
&attr <param>,<valor>

Parâmetros Confirmados
Param	Atributo
0	Level
1	HP atual
2	SP atual
4	Classe
5	Reputação
6	Pontos de atributo
7	Pontos de skill
8	Gold
11	SLV
12	Life Skill Level
13	Life Skill Points
19	SEXP
50	STR
51	ACC
52	AGI
53	CON
54	SPR
69	Velocidade (máx. 2000)
96	Strength
97	Agility
98	Accuracy
99	Constitution
100	Spirit
102	Attack Speed
104	Ataque mínimo
105	Ataque máximo
106	Defesa
107	HP máximo
108	SP máximo
109	Dodge
110	Hit Rate
🧙 Classes (&attr 4,<valor>)
Valor	Classe
1	Swordsman
2	Hunter
4	Explorer
5	Herbalist
8	Champion
9	Crusader
12	Sharpshooter
13	Cleric
14	Seal Master
16	Voyager
🎒 &itemattr – Atributos de Itens
Sintaxe
&itemattr <slotX>,<slotY>,<param>,<valor>

Exemplos

Pet (slot 2,1):

&itemattr 2,1,54,500


Ajustar Spirit do pet:

&itemattr 2,1,30,100

🧮 Base Count + Modifier

Todos os atributos seguem esta lógica:

VALOR FINAL = BASE + MODIFICADOR

Exemplo
ATTR_COUNT_BASE2 = 50
STR = 50 + 0
&attr 50,500

🧪 Observações Importantes

Muitos atributos resetam ao:

Deslogar

Morrer

Teleportar

Valores muito altos podem gerar atributos negativos

Nem todos os itens aceitam todos os atributos

Arquivos importantes:

AttrType.lua

ItemAttrType.lua

✅ Conclusão

Este guia cobre:

Administração de jogadores

Atributos avançados

Itens e pets

Moderação e controle do servidor

⚠️ Use comandos com cautela para evitar bugs ou instabilidade.
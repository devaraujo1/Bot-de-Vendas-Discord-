# INSTRUCAO DA PARTE 02

Pessoal, seguem as instruções atualizadas para a continuação do trabalho:



📌 Continuação do Trabalho – Banco de Dados
✅ 1) PRIMEIRA TAREFA (OBRIGATÓRIA)
Antes de qualquer coisa, vocês devem:

Corrigir todos os problemas apontados em sala de aula
Ajustar modelagem, tipos de dados, chaves primárias e estrangeiras
Corrigir normalização, se necessário
Ajustar nomes de tabelas/colunas se foi solicitado
Corrigir cardinalidades e relacionamentos incorretos
⚠️ Somente depois das correções vocês devem gerar o script final.



✅ 2) O script deve começar limpando o banco (DROP)
Em todas as tabelas, incluir:

DROP TABLE IF EXISTS nome_tabela;
 
⚠️ Atenção com exclusão em cascata (ON DELETE CASCADE)
Caso exista ON DELETE CASCADE:

Vocês precisam dropar na ordem correta.
Regra:
Primeiro as tabelas filhas (que possuem FK).
Depois as tabelas pais.
Se fizer errado, o script dará erro.



✅ 3) DDL – Criar tabelas + relacionamentos
O script deve conter:

PRIMARY KEY
FOREIGN KEY
NOT NULL nos campos obrigatórios
UNIQUE quando fizer sentido (ex.: CPF, email)
Tipos corretos (INT, VARCHAR, DATE, DECIMAL, etc.)
Os relacionamentos devem estar definidos no DDL (na criação da tabela ou via ALTER TABLE).



✅ 4) DML – Inserts obrigatórios em TODAS as tabelas
🔹 4.1) Tabelas auxiliares
Exemplos: TipoFuncionario, FormasPagamento, etc.

Devem ter no mínimo 3 registros cada.
Exemplo:

INSERT INTO TipoFuncionario (idTipoFuncionario, descricao) VALUES
(1, 'Gerente'),
(2, 'Atendente'),
(3, 'Caixa');
🔹 4.2) Tabelas core (principais)
Devem ter no mínimo 30 registros cada.
Devem respeitar:
IDs existentes
Integridade referencial (FKs válidas)
Datas e valores coerentes
✅ 5) Ordem obrigatória do script
O script deve seguir esta ordem:

DROP TABLE IF EXISTS (na ordem correta)
CREATE TABLE (tabelas pais primeiro, depois filhas)
INSERT INTO
Primeiro tabelas auxiliares/pais
Depois tabelas filhas
✅ 6) Uso de IA para gerar dados
Vocês devem utilizar IA para gerar automaticamente os inserts.

Ao pedir para a IA, informem:

Nome das tabelas e colunas
PK e FK
Quantidade mínima:
3 registros (tabelas auxiliares)
30 registros (tabelas core)
Que deve respeitar integridade referencial
Que deve seguir a ordem correta de inserção
Depois, vocês devem testar o script no banco para validar se não há erros.



📌 Organização da Equipe
Todos os membros da equipe devem participar da construção do script.
O líder da equipe é responsável por testar o script completo antes da entrega, garantindo que:
Não haja erro de FK
Não haja erro de ordem
O script rode do início ao fim sem falhas

Ponto de atenção: Organizem o repositório de forma clara e profissional para quem for avaliá-lo. Estruturem os conteúdos em diretórios bem definidos, por exemplo: DML, DQL, além de um README.md explicando o projeto.

Revisem também o nome do repositório, garantindo que ele seja descritivo e adequado ao contexto do trabalho.

Evitem incluir arquivos desnecessários no repositório — eles não serão aceitos. A ideia é que vocês comecem a pensar e trabalhar como profissionais, e não apenas como alunos.

Sejam cuidadosos e detalhistas (perfeccionistas) naquilo que se propõem a fazer: organização, clareza e qualidade fazem parte da entrega.



# INSTRUCAO DA PARTE 03

Consultas Relacionais (DQL)



Instruções Gerais: Segue os comandos SQL que deverão ser entregues na próxima aula junto com as outras entregas. É importante lembrar que alguns comandos SQL só poderão ser realizados se a atividade anterior (DDL e Inserção de Dados) tiver sido finalizada, pois dependem da existência de tabelas e registros para retornar resultados. O ideal é que as equipes se dividam para realizar a tarefa de forma eficiente.

Objetivo: Praticar a junção de tabelas utilizando INNER JOIN, LEFT JOIN e RIGHT JOIN, focando na lógica de relacionamento sem o uso de funções de agregação ou agrupamentos.



Abaixo, cada equipe encontrará os 12 enunciados específicos para o seu projeto:
4. Bot de Vendas Discord (devaraujo1)

Inner Join: Exiba o nome de usuário do Discord e o nome do cargo atribuído a ele.
Right Join: Liste todos os pagamentos realizados e as vendas correspondentes, incluindo vendas pendentes sem pagamento.
Left Join: Liste todos os usuários e os tickets de suporte que eles abriram, incluindo usuários que nunca precisaram de suporte.
Inner Join: Mostre o nome do produto digital e a categoria à qual ele pertence.
Inner Join: Relacione a venda com o código do produto que foi entregue automaticamente ao comprador.
Left Join: Liste todos os cargos/permissões do servidor e os usuários vinculados, incluindo cargos que estão vazios.
Inner Join: Exiba o ID do ticket de suporte e o nome do moderador que foi designado para resolvê-lo.
Inner Join: Relacione a venda com o código de transação PIX gerado pelo sistema.
Left Join: Mostre todos os produtos digitais e os logs de auditoria (histórico), incluindo produtos recém-lançados sem logs.
Inner Join: Exiba o nome do usuário e o motivo do bloqueio registrado na tabela de auditoria.
Inner Join: Relacione os cupons de desconto com as vendas onde eles foram aplicados.
Right Join: Liste todas as ações administrativas cadastradas e o nome do administrador que as executou.

# INSTRUCAO DA PARTE 04
4. Bot de Vendas Discord (devaraujo1)
Group By: Conte o total de tickets de suporte agrupados por status (Aberto/Fechado).
Group By: Calcule o valor total de vendas gerado por cada produto digital.
Group By: Liste a quantidade de usuários vinculados a cada cargo/permissão do servidor.
Group By: Totalize os reembolsos processados agrupados por mês de ocorrência.
Union: Combine os usernames de usuários comuns e usernames de administradores em uma lista.
Union All: Liste todos os IDs de transação de vendas e todos os IDs de reembolsos.
Intersect: Identifique usuários que realizaram uma compra e também abriram um ticket de suporte.
Group By: Calcule a média de gastos por usuário nas transações PIX.
Union: Liste os nomes dos produtos da "Categoria X" e da "Categoria Y" em uma única consulta.
Group By: Conte a quantidade de logs de auditoria para cada tipo de ação administrativa.
Intersect: Encontre IDs de produtos que estão "Disponíveis" e que possuem registro de venda.
Group By: Calcule o total de cupons de desconto utilizados agrupados por código do cupom.



# INSTRUCAO DA PARTE 05
5. Bot de Vendas Discord (devaraujo1)
Focado em e-commerce digital e tickets de suporte.

Procedures:
GerarVendaPix: Cria um registro de venda pendente e gera um código simulado de transação.
ProcessarReembolso: Altera o status da venda para "Reembolsado" e registra a auditoria da ação.
AtribuirCargoAutomatico: Vincula um usuário a um novo nível de acesso após uma compra confirmada.
Triggers:
LogAuditoriaAdmin: Registra qualquer alteração feita por um administrador em produtos ou permissões.
AutoFecharTicket: Altera o status de um ticket para "Resolvido" após X dias sem interação.
VerificarBloqueioUsuario: Impede que um usuário banido realize novas tentativas de compra.
Functions:
VerificarNivelAcesso: Retorna se um usuário tem permissão para executar determinada ação no bot.
TotalVendidoNoMes: Soma o valor de todas as transações confirmadas no mês atual.
TempoMedioRespostaTicket: Calcula a média de tempo entre a abertura e o fechamento dos atendimentos.
Views:
DashboardVendasAtivas: Lista todas as vendas concluídas recentemente com os usernames do Discord.
TicketsPendentesModeracao: Mostra apenas os atendimentos que ainda não receberam resposta.
ProdutosMaisPopulares: Exibe o ranking de produtos digitais mais adquiridos.
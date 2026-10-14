# Entregável de Modelagem de Banco de Dados — Semana 04 (Sprint 4)

## Cenário
O projeto modela uma academia e mantém as cinco tabelas da Semana 3: `aluno`, `plano`, `professor`, `matricula` e `aula`.

## Arquivos
- `01_modelagem_fisica.sql`: adiciona geração automática de IDs às chaves existentes, sincroniza as sequências com os registros já cadastrados e adiciona `matricula.criada_em`.
- `02_indices.sql`: cria índices para chaves estrangeiras e consultas por status.
- `03_transacoes.sql`: apresenta transações envolvendo múltiplas tabelas, `RETURNING`, `SAVEPOINT`, `COMMIT` e `ROLLBACK`.
- `04_explain_analyze.sql`: executa duas consultas com `EXPLAIN ANALYZE`.
- `05_permissoes.sql`: cria uma role de leitura e usuários com permissões distintas, aplicando `GRANT` e `REVOKE`.

## Tipos de dados e integridade
Os identificadores são inteiros com geração automática por `IDENTITY`, recurso PostgreSQL adequado para chaves substitutas. `VARCHAR` limita campos textuais como nome e CPF; `NUMERIC/DECIMAL(10,2)` é adequado para valores monetários porque evita a imprecisão de ponto flutuante; `TIME` representa o horário de uma aula; `TIMESTAMPTZ` registra a data/hora de criação da matrícula considerando fuso horário. As PKs identificam registros, as FKs preservam a integridade referencial, `NOT NULL` exige campos obrigatórios, `UNIQUE` impede CPFs/nomes de plano duplicados, `CHECK` restringe valor e status, e `DEFAULT` define status/data inicial.

As restrições já existentes na Semana 3 são preservadas. O script físico acrescenta identidade às chaves e a coluna de auditoria `criada_em`.

## Estratégia de indexação
O PostgreSQL cria índices automaticamente para PKs e restrições `UNIQUE`. Os índices adicionais são:
- `idx_matricula_id_aluno`: apoia JOINs e buscas de matrículas por aluno.
- `idx_matricula_id_plano`: apoia JOINs e buscas por plano.
- `idx_aula_id_professor`: apoia JOINs e buscas de aulas por professor.
- `idx_matricula_status`: apoia filtros por status, embora a baixa cardinalidade possa limitar o benefício.

Índices ocupam espaço e aumentam o custo de escrita; por isso, foram priorizadas colunas usadas em relacionamentos e filtros, em vez de indexar todas as colunas.

## Transações e consistência
O arquivo de transações mostra duas operações multi-tabela: cadastro de aluno e matrícula; cadastro de professor e aula. `RETURNING` retorna os IDs gerados para que sejam usados pela inserção dependente na mesma instrução. `SAVEPOINT` marca um ponto intermediário, `ROLLBACK TO SAVEPOINT` desfaz alterações posteriores ao ponto, `COMMIT` confirma a transação e `ROLLBACK` cancela uma transação completa de demonstração.

As transações seguem a ideia de atomicidade: operações relacionadas são confirmadas juntas ou desfeitas juntas, evitando registros incompletos.

## Análise de desempenho
O arquivo `04_explain_analyze.sql` executa `ANALYZE` e duas consultas com `EXPLAIN ANALYZE`, uma filtrando matrículas por aluno e outra filtrando aulas por professor. Após executar, confira o plano real retornado pelo PostgreSQL. `Index Scan` ou `Bitmap Index Scan` pode indicar uso de índice; com tabelas pequenas, `Seq Scan` pode ser escolhido por ter custo menor. Portanto, a conclusão deve ser baseada na saída observada, não apenas na existência do índice.

## Controle de acesso
A role `academia_leitura` recebe somente `SELECT`. O usuário `academia_consulta` herda essa role. O usuário `academia_operacao` recebe permissões de consulta e manipulação de dados (`SELECT`, `INSERT`, `UPDATE`, `DELETE`), sem permissões de criação/alteração de tabelas. `REVOKE` demonstra a remoção explícita de permissões de escrita do perfil de leitura.

**Antes de executar `05_permissoes.sql`:**
1. Ajuste `modelagem_banco_academia` para o nome real do seu banco, se for diferente.
2. Troque as senhas de exemplo por senhas fortes.
3. Execute com uma conta que tenha privilégios para criar roles e usuários.

## Ordem de execução
1. Execute primeiro o DDL da Semana 3 para criar as tabelas, caso ainda não existam.
2. Execute `01_modelagem_fisica.sql` **uma única vez** sobre as tabelas existentes da Semana 3.
3. Execute `02_indices.sql`.
4. Execute `03_transacoes.sql` uma única vez ou altere os CPFs de exemplo antes de repetir.
5. Execute `04_explain_analyze.sql` e registre/avalie a saída real do PostgreSQL.
6. Ajuste e execute `05_permissoes.sql` como administrador.

## Observações de validação
Os scripts foram preparados a partir do modelo lógico da Semana 3. A execução no ambiente PostgreSQL é necessária para confirmar nomes do banco, permissões disponíveis, planos de execução e ausência de conflitos com registros já existentes.

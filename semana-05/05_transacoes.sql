-- Sprint 5 | Transações demonstrativas
SET search_path TO academia_sprint5, public;

-- Transação 1: cria aluno e matrícula usando o ID retornado pelo INSERT.
BEGIN;
WITH novo_aluno AS (
    INSERT INTO aluno (nome, cpf, email, telefone, data_nascimento)
    VALUES ('Aluno Transacao 01', '90000000001', 'transacao01@exemplo.com', '(98) 90000-0001', DATE '1998-04-12')
    RETURNING id_aluno
)
INSERT INTO matricula (id_aluno, id_plano, data_inicio, status)
SELECT id_aluno, 1, CURRENT_DATE, 'ATIVA' FROM novo_aluno
RETURNING id_matricula, id_aluno;
COMMIT;

-- Transação 2: registra pagamento. SAVEPOINT permite desfazer apenas a etapa posterior.
BEGIN;
SAVEPOINT antes_pagamento;
INSERT INTO pagamento (id_matricula, valor, vencimento, metodo, status, referencia)
SELECT id_matricula, 89.90, CURRENT_DATE+10, 'PIX', 'PENDENTE', 'TRANSACAO-S5-002'
FROM matricula ORDER BY id_matricula DESC LIMIT 1
RETURNING id_pagamento, id_matricula, valor;
SAVEPOINT depois_pagamento;
-- Exemplo de operação experimental desfeita parcialmente:
UPDATE pagamento SET status='PAGO', pago_em=CURRENT_TIMESTAMP WHERE referencia='TRANSACAO-S5-002';
ROLLBACK TO SAVEPOINT depois_pagamento;
COMMIT;

-- Transação 3: exemplo explícito de ROLLBACK integral; o registro não permanece.
BEGIN;
INSERT INTO equipamento (nome, numero_patrimonio, id_modalidade, valor_aquisicao, observacoes)
VALUES ('Equipamento teste rollback', 'ROLLBACK-S5-003', 1, 1.00, 'Registro usado para demonstrar rollback');
ROLLBACK;

-- Confira os efeitos das transações.
SELECT referencia, status, valor FROM pagamento WHERE referencia='TRANSACAO-S5-002';
SELECT numero_patrimonio FROM equipamento WHERE numero_patrimonio='ROLLBACK-S5-003';

CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100)
);

-- ==========================================
-- TABELA PLANO
-- ==========================================

CREATE TABLE plano (
    id_plano INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0)
);

-- ==========================================
-- TABELA PROFESSOR
-- ==========================================

CREATE TABLE professor (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

-- ==========================================
-- TABELA MATRICULA
-- ==========================================

CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVA',

    FOREIGN KEY (id_aluno)
        REFERENCES aluno(id_aluno),

    FOREIGN KEY (id_plano)
        REFERENCES plano(id_plano),

    CHECK (status IN ('ATIVA', 'CANCELADA'))
);

-- ==========================================
-- TABELA AULA
-- ==========================================

CREATE TABLE aula (
    id_aula INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    horario TIME NOT NULL,
    id_professor INT NOT NULL,

    FOREIGN KEY (id_professor)
        REFERENCES professor(id_professor)
);

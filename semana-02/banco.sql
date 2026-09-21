CREATE TABLE aluno (
    id_aluno INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    email VARCHAR(100)
);

CREATE TABLE plano (
    id_plano INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

CREATE TABLE professor (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100)
);

CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,

    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_plano) REFERENCES plano(id_plano)
);

CREATE TABLE aula (
    id_aula INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    horario TIME NOT NULL,
    id_professor INT NOT NULL,

    FOREIGN KEY (id_professor) REFERENCES professor(id_professor)
);

# Entregável de Modelagem de Banco de Dados – Semana 03

## 1. Cenário

O cenário escolhido é uma **Academia**.

Nesta etapa foi realizada a transformação do modelo conceitual em um modelo lógico relacional, aplicando as regras de normalização até a Terceira Forma Normal (3FN).

---

## 2. Modelo lógico

O modelo lógico é composto pelas seguintes tabelas:

- ALUNO
- PLANO
- PROFESSOR
- MATRICULA
- AULA

### Relacionamentos

- Um aluno pode possuir várias matrículas.
- Cada matrícula pertence a um único aluno.
- Um plano pode estar relacionado a várias matrículas.
- Cada matrícula está relacionada a um único plano.
- Um professor pode ministrar várias aulas.
- Cada aula é ministrada por um único professor.

### Diagrama do Modelo Lógico

```mermaid
erDiagram

    ALUNO ||--o{ MATRICULA : possui
    PLANO ||--o{ MATRICULA : possui
    PROFESSOR ||--o{ AULA : ministra

    ALUNO {
        INT id_aluno PK
        VARCHAR nome
        VARCHAR cpf UK
        VARCHAR email
    }

    PLANO {
        INT id_plano PK
        VARCHAR nome UK
        DECIMAL valor
    }

    MATRICULA {
        INT id_matricula PK
        INT id_aluno FK
        INT id_plano FK
    }

    PROFESSOR {
        INT id_professor PK
        VARCHAR nome
        VARCHAR especialidade
    }

    AULA {
        INT id_aula PK
        VARCHAR nome
        TIME horario
        INT id_professor FK
    }

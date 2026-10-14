use("academia_nosql");

db.alunos.createIndex({ email: 1 }, { unique: true, name: "uq_alunos_email" });
db.alunos.createIndex({ ativo: 1, nome: 1 }, { name: "idx_alunos_ativo_nome" });
db.matriculas.createIndex({ alunoId: 1, status: 1 }, { name: "idx_matriculas_aluno_status" });
db.matriculas.createIndex({ status: 1, inicio: -1 }, { name: "idx_matriculas_status_inicio" });

db.alunos.find({ email: "ana.souza@example.com" })
  .explain("executionStats");

db.alunos.find({ ativo: true, nome: /^A/ })
  .sort({ nome: 1 })
  .explain("executionStats");

db.matriculas.find({ alunoId: ObjectId("670000000000000000000001"), status: "ATIVA" })
  .explain("executionStats");

db.matriculas.find({ status: "ATIVA" })
  .sort({ inicio: -1 })
  .explain("executionStats");

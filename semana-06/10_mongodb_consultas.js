use("academia_nosql");

db.alunos.find(
  { ativo: true },
  { _id: 0, nome: 1, email: 1, "plano.nome": 1 }
).sort({ nome: 1 });

db.alunos.find(
  { objetivos: "condicionamento", ativo: true },
  { _id: 0, nome: 1, objetivos: 1 }
).sort({ nome: 1 });

db.matriculas.find(
  { status: "ATIVA" },
  { _id: 0, alunoId: 1, inicio: 1, status: 1, pagamentos: 1 }
).sort({ inicio: -1 });

db.matriculas.find(
  { "pagamentos.pago": false },
  { _id: 0, alunoId: 1, status: 1, pagamentos: 1 }
).sort({ inicio: -1 });

db.alunos.aggregate([
  { $match: { ativo: true } },
  { $group: { _id: "$plano.categoria", total: { $sum: 1 } } },
  { $sort: { total: -1, _id: 1 } }
]);

db.matriculas.aggregate([
  { $match: { status: "ATIVA" } },
  {
    $lookup: {
      from: "alunos",
      localField: "alunoId",
      foreignField: "_id",
      as: "aluno"
    }
  },
  { $unwind: "$aluno" },
  {
    $project: {
      _id: 0,
      aluno: "$aluno.nome",
      email: "$aluno.email",
      inicio: 1,
      status: 1
    }
  },
  { $sort: { aluno: 1 } }
]);

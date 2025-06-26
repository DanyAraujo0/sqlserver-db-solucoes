USE SchoolBD;

CREATE NONCLUSTERED INDEX IX_Alunos_IdTurma ON Alunos(IdTurma);

CREATE NONCLUSTERED INDEX IX_Alunos_IdResponsavel ON Alunos(IdResponsavel);

CREATE NONCLUSTERED INDEX IX_Notas_IdMatricula ON Notas(IdMatricula);

CREATE NONCLUSTERED INDEX IX_Notas_IdDisciplina ON Notas(IdDisciplina);

CREATE NONCLUSTERED INDEX IX_Alunos_NomeAluno ON Alunos(NomeAluno);

CREATE NONCLUSTERED INDEX IX_Responsaveis_NomeResponsavel ON Responsaveis(NomeResponsavel);
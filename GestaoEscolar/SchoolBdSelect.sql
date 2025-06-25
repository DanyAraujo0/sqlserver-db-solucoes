USE SchoolBD;

/*  Consulta para ver a media dos alunos em determinada disciplina  */

SELECT
    d.NomeDisciplina,
    t.NomeTurma,
    p.NomeProfessor,
    CAST(AVG(n.nota) AS DECIMAL(4,2)) AS MediaAluno
FROM Disciplinas d
JOIN Turmas t ON d.IdTurma = t.IdTurma
JOIN Notas n ON d.IdDisciplina = n.IdDisciplina
JOIN Professores p ON d.IdProfessor = p.IdProfessor
GROUP BY NomeDisciplina, NomeTurma, NomeProfessor
ORDER BY NomeDisciplina ASC;
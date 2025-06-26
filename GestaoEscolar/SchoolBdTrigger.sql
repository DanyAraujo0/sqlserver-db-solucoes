USE SchoolBD;

/*  Uma Trigger que previne que uma Turma seja excluida com alunos ativos   */

CREATE TRIGGER trg_PrevenirExclusaoTurmaComAlunos
ON Turmas
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM deleted d JOIN Alunos a ON d.IdTurma = a.IdTurma WHERE a.Status = 'Ativo')
    BEGIN
        THROW 50002, 'Não é possível excluir uma turma que possui alunos ativos', 1;
    END
    ELSE
    BEGIN
        DELETE t FROM Turmas t JOIN deleted d ON t.IdTurma = d.IdTurma;
    END
END
GO

/*  Testando */
DELETE FROM Turmas 
WHERE IdTurma = 1;
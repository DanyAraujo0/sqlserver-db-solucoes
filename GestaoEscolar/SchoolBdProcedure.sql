USE SchoolBD;

/* Procedure para matricular um aluno automaticamente na turma evitando que sejam matriculados alunos em turmas lotadas */

CREATE PROCEDURE sp_MatricularAluno
    @IdMatricula INT,
    @IdTurmaAlvo SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CapacidadeTurma INT;
    DECLARE @AlunosInscritos INT;

    SELECT @CapacidadeTurma = Capacidade FROM Turmas WHERE IdTurma = @IdTurmaAlvo;

    SELECT @AlunosInscritos = COUNT(*) FROM Alunos WHERE IdTurma = @IdTurmaAlvo AND Status = 'Ativo';

    BEGIN TRY
        IF (@AlunosInscritos >= @CapacidadeTurma)
        BEGIN
            THROW 50001, 'Não é possivel realizar a matricula pois a turma selecionada já atingiu sua capacidade máxima.', 1;
        END
        ELSE
        BEGIN
            UPDATE Alunos
            SET IdTurma = @IdTurmaAlvo
            WHERE IdMatricula = @IdMatricula;

            PRINT 'Aluno matriculado com sucesso!';
        END
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END
GO

/*  Verificando se funciona */

EXEC sp_MatricularAluno @IdMatricula = 1004, @IdTurmaAlvo = 1;

/*  Conferindo se os dados mudaram na tabela   */
SELECT * FROM Alunos
WHERE IdMatricula = 1004;
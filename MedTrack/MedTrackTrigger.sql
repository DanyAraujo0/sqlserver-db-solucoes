USE MedTrack;

 /* Criando uma tabela para registrar a data e hora da alta do paciente e o funcionario que a emitiu  */
CREATE TABLE LaudoAlta(
    IdAlta INT PRIMARY KEY IDENTITY(1,1),
    DataHoraAlta DATETIME NOT NULL,
    IdProntuario INT FOREIGN KEY (IdProntuario) REFERENCES Prontuarios(IdProntuario),
    IdFuncionario INT FOREIGN KEY REFERENCES Funcionarios(IdFuncionario)
);
GO

/*  Adicionando a coluna Data de Saida do paciente que recebeu alta */
ALTER TABLE Prontuarios
    ADD DataSaida DATETIME;
GO

/*  Trigger para adicionar na tabela Prontuario a data e hora que o paciente saiu, ou seja recebeu alta   */
CREATE OR ALTER TRIGGER trg_RegistroSaidaPaciente
ON LaudoAlta     
AFTER INSERT   
AS
BEGIN
    SET NOCOUNT ON;
        UPDATE Prontuarios
    SET DataSaida = i.DataHoraAlta
    FROM Prontuarios p
    JOIN inserted i ON p.IdProntuario = i.IdProntuario;
END
GO


/*  Testando a Trigger  */
INSERT INTO LaudoAlta (DataHoraAlta, IdProntuario, IdFuncionario) VALUES ('2025-06-24T20:00:00',2, 3);

/*  Confirindo o registro   */
SELECT * FROM Prontuarios WHERE IdProntuario=2;
USE MedTrack;

CREATE NONCLUSTERED INDEX IX_Atendimentos_IdPaciente ON Atendimentos(IdPaciente);
GO 

CREATE NONCLUSTERED INDEX IX_Atendimentos_IdFuncionario ON Atendimentos(IdFuncionario);
GO

CREATE NONCLUSTERED INDEX IX_Pacientes_NomePaciente ON Pacientes(NomePaciente);
GO

CREATE NONCLUSTERED INDEX IX_Atendimentos_DataHora ON Atendimentos(DataHora);
GO

CREATE NONCLUSTERED INDEX IX_ProntuarioProcedimentos_IdProcedimento ON ProntuarioProcedimentos(IdProcedimento);
GO

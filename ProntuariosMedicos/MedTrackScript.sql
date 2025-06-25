USE MedTrack;

CREATE TABLE Pacientes(
	IdPaciente INT PRIMARY KEY IDENTITY(1,1),
	NomePaciente VARCHAR(100) NOT NULL,
	CPF VARCHAR(11) UNIQUE,
	DataNascimento DATE NOT NULL,
	NomeMae VARCHAR(100),
    Alergias VARCHAR(50),
	Telefone VARCHAR(15),
	EmailPaciente VARCHAR(30)
);

CREATE TABLE Especialidades(
    IdEspecialidade INT PRIMARY KEY IDENTITY(1,1),
    TipoEspecialidade VARCHAR(50)
);

CREATE TABLE Funcionarios(
    IdFuncionario INT PRIMARY KEY IDENTITY(1,1),
    NomeFuncionario VARCHAR(100) NOT NULL,
    CRMCOREN VARCHAR(20) UNIQUE,
    EmailFuncionario VARCHAR(100),
    IdEspecialidade INT FOREIGN KEY REFERENCES Especialidades(IdEspecialidade)
);

CREATE TABLE Procedimentos(
    IdProcedimento INT PRIMARY KEY IDENTITY(1,1),
    NomeProcedimento VARCHAR(50)
);

CREATE TABLE EspecialidadesProcedimentos(
    IdEspecialidade INT,
    IdProcedimento INT,
    FOREIGN KEY (IdEspecialidade) REFERENCES Especialidades(IdEspecialidade),
    FOREIGN KEY (IdProcedimento) REFERENCES Procedimentos(IdProcedimento),
    PRIMARY KEY(IdEspecialidade,IdProcedimento)
);

CREATE TABLE Medicamentos(
    IdMedicamento INT PRIMARY KEY IDENTITY(1,1),
    NomeMedicamento VARCHAR(50)
);

CREATE TABLE EspecialidadesMedicamentos(
    IdEspecialidade INT,
    IdMedicamento INT,
    FOREIGN KEY (IdEspecialidade) REFERENCES Especialidades(IdEspecialidade),
    FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento),
    PRIMARY KEY(IdEspecialidade,IdMedicamento)
);

CREATE TABLE Sintomas(
    IdSintoma INT PRIMARY KEY IDENTITY(1,1),
    DescricaoSintoma VARCHAR(50),
    CID VARCHAR(5)
);

CREATE TABLE Atendimentos (
    IdAtendimento INT PRIMARY KEY IDENTITY(1,1),
    DataHora DATETIME NOT NULL,
    Observacoes VARCHAR(MAX),
    TipoRisco VARCHAR(10),
    IdSintoma INT FOREIGN KEY REFERENCES Sintomas(IdSintoma),
    IdPaciente INT FOREIGN KEY REFERENCES Pacientes(IdPaciente),
    IdFuncionario INT FOREIGN KEY REFERENCES Funcionarios(IdFuncionario)
);

CREATE TABLE Prontuarios (
    IdProntuario INT PRIMARY KEY IDENTITY(1,1),
    Diagnostico VARCHAR(MAX),
    Receita VARCHAR(MAX),
    Encaminhamento VARCHAR(255),
    DataRegistro DATETIME DEFAULT GETDATE(),
    IdAtendimento INT FOREIGN KEY REFERENCES Atendimentos(IdAtendimento)
);

CREATE TABLE ProntuarioProcedimentos(
    IdProntuario INT,
    IdProcedimento INT,
    FOREIGN KEY (IdProntuario) REFERENCES Prontuarios(IdProntuario),
    FOREIGN KEY (IdProcedimento) REFERENCES Procedimentos(IdProcedimento),
    PRIMARY KEY(IdProntuario,IdProcedimento)
);

CREATE TABLE ProntuarioMedicamentos(
    IdProntuario INT,
    IdMedicamento INT,
    FOREIGN KEY (IdProntuario) REFERENCES Prontuarios(IdProntuario),
    FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento),
    PRIMARY KEY(IdProntuario,IdMedicamento)
);
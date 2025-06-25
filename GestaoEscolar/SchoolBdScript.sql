USE SchoolBD;

CREATE TABLE Turmas (
    IdTurma SMALLINT PRIMARY KEY IDENTITY(1,1),
    NomeTurma VARCHAR(100) NOT NULL,
    Capacidade INT,
    Ano INT NOT NULL
);

CREATE TABLE Responsaveis (
    IdResponsavel INT PRIMARY KEY IDENTITY(1,1),
    NomeResponsavel VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    Telefone VARCHAR(15) NOT NULL,
    Email VARCHAR(100) 
);

CREATE TABLE Alunos(
    IdMatricula INT PRIMARY KEY IDENTITY(1001,1),
    NomeAluno VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE,
    DataNascimento DATE NOT NULL,
    IdResponsavel INT NOT NULL, 
    Status VARCHAR(20) DEFAULT 'Ativo' NOT NULL,
    IdTurma SMALLINT,
    FOREIGN KEY (IdTurma) REFERENCES Turmas(IdTurma),
    FOREIGN KEY (IdResponsavel) REFERENCES Responsaveis(IdResponsavel),
    CONSTRAINT CHK_Alunos_Status CHECK (Status IN ('Ativo', 'Inativo', 'Transferido'))
);

CREATE TABLE Professores(
    IdProfessor SMALLINT PRIMARY KEY IDENTITY(101,1),
    NomeProfessor VARCHAR(100) NOT NULL,
    DataNascimento DATE,
    CPF CHAR(11) UNIQUE,
    DescricaoFormacao VARCHAR(100) NOT NULL,
    DataFormacao DATE
);

CREATE TABLE Disciplinas (
    IdDisciplina SMALLINT PRIMARY KEY IDENTITY(1,1),
    NomeDisciplina VARCHAR(100) NOT NULL,
    IdTurma SMALLINT NOT NULL,
    IdProfessor SMALLINT NOT NULL,
    FOREIGN KEY (IdTurma) REFERENCES Turmas(IdTurma),
    FOREIGN KEY (IdProfessor) REFERENCES Professores(IdProfessor)
);

CREATE TABLE Notas (
    IdNota INT PRIMARY KEY IDENTITY(1,1),
    IdDisciplina SMALLINT NOT NULL,
    IdMatricula INT NOT NULL,
    Nota DECIMAL(4,2),
    DataLancamento DATE DEFAULT GETDATE(),
    FOREIGN KEY (IdDisciplina) REFERENCES Disciplinas(IdDisciplina),
    FOREIGN KEY (IdMatricula) REFERENCES Alunos(IdMatricula)
);

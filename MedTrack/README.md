# MedTrack - Sistema de Gerenciamento de Atendimentos Médicos

Este repositório contém o projeto de um banco de dados relacional completo, chamado MedTrack, projetado para o gerenciamento de atendimentos e prontuários médicos em um ambiente hospitalar. O sistema foi desenvolvido em SQL Server e inclui não apenas a estrutura das tabelas, mas também uma lógica avançada com Stored Procedures, Triggers e uma estratégia de indexação para otimização de performance.


## 💡 Motivação
A inspiração para o MedTrack nasceu da minha experiência prática no setor de saúde. Durante meu estágio como Técnica em Informática no setor de Faturamento de um hospital municipal, tive a oportunidade de observar de perto o fluxo de informações de um paciente, desde sua chegada até a alta e o subsequente processo de faturamento.

Percebi em primeira mão os desafios diários enfrentados pela equipe:

Acesso Fragmentado à Informação: A busca por históricos de pacientes em prontuários físicos ou em sistemas legados era lenta e, muitas vezes, incompleta.

Risco de Inconsistência: Informações cruciais, como alergias a medicamentos, nem sempre estavam atualizadas ou facilmente acessíveis, representando um risco à segurança do paciente. Ou até mesmo a perda do prontuário fisíco.

Ineficiência no Faturamento: A dificuldade em conectar diagnósticos, procedimentos realizados e medicamentos prescritos de forma clara e direta gerava gargalos e potenciais erros no faturamento dos atendimentos.

Então a partir dai compreendi que um banco de dados bem estruturado e centralizado não é apenas um requisito técnico, mas uma ferramenta fundamental para aumentar a eficiência operacional, reduzir erros e, acima de tudo, melhorar a qualidade do atendimento ao paciente.

Diante desse cenário eu usei meu conhecimento em SQL Server para desenvolver o MedTrack, que é a minha proposta de solução para esses problemas, um sistema projetado com base em necessidades reais e com o objetivo de criar um fluxo de dados coeso, seguro e eficiente. 



## 🏗️ Estrutura do Banco de Dados
O banco de dados é modelado para ser modular e escalável, separando as responsabilidades em tabelas principais, transacionais e de associação. **A criação das tabelas esta no arquivo MedTrackScript**.

Tabelas Principais:
- Pacientes: Armazena os dados cadastrais dos pacientes (nome, CPF, data de nascimento, alergias, etc.).
- Funcionarios: Registra os profissionais de saúde (médicos, enfermeiros), seus respectivos CRM/COREN e especialidades.
- Especialidades: Tabela de catálogo para as diferentes especialidades médicas (Cardiologia, Pediatria, etc.).

Tabelas de Catálogo:

- Procedimentos: Lista de todos os procedimentos médicos disponíveis.
- Medicamentos: Catálogo de medicamentos que podem ser prescritos.
- Sintomas: Registra os sintomas com seus respectivos códigos CID.
- Tabelas Transacionais (Coração do Sistema):
- Atendimentos: Tabela central que registra cada visita de um paciente, ligando paciente, funcionário, sintoma e data/hora.
- Prontuarios: Armazena os detalhes clínicos de um atendimento (diagnóstico, receita, encaminhamento).
- LaudoAlta: Tabela que registra a alta de um paciente para um atendimento específico.

Tabelas de Associação (Muitos-para-Muitos):
- EspecialidadeProcedimentos: Associa os múltiplos procedimentos realizados por múltiplas Especialidades
- EspecialidadeMedicamentos: Associa os múltiplos medicamentos prescrito/aplicado por múltiplas Especialidades
- ProntuarioProcedimentos: Associa os múltiplos procedimentos realizados em um prontuário.
- ProntuarioMedicamentos: Associa os múltiplos medicamentos prescritos/aplicado em um prontuário.


## 🚀 Recursos Avançados
Para demonstrar conhecimentos além da simples modelagem, o projeto inclui exemplos de código SQL que automatizam processos e otimizam consultas.

Stored Procedures: **localizado em [MedTrackProcedure](MedTrackScript.sql)**.

sp_RegistrarAtendimentoCompleto: Encapsula toda a lógica para criar um novo atendimento e seu prontuário correspondente dentro de uma transação atômica. Isso garante que ou todos os dados são salvos com sucesso, ou nada é alterado, mantendo a integridade do banco.

Triggers: **localizado em [MedTrackTrigger](MedTrackTrigger.sql)**.

trg_AtualizaDataSaidaProntuario: Um gatilho que dispara automaticamente após a inserção de um registro na tabela LaudoAlta. Ele atualiza o prontuário correspondente com a data e hora da saída, automatizando o processo de alta e garantindo que a informação esteja sempre correta.

Índices (Otimização de Performance): **localizado em [MedTrackIndex](MedTrackIndex.sql)**.

Foram criados índices não-clusterizados em colunas-chave para acelerar a performance de consultas, especialmente em:

Chaves Estrangeiras (Foreign Keys): Como IdPaciente e IdFuncionario na tabela Atendimentos, otimizando drasticamente as operações de JOIN.

Colunas de Busca Frequente: Como NomePaciente na tabela Pacientes e DataHora na tabela Atendimentos, melhorando a velocidade de filtros e relatórios.

Foram feitas inserções fictícias em **[MedTrackInsert](MedTrackInsert.sql)** 

Consultas estão detalhadas em **[MedTrackSelect](MedTrackSelect.sql)**

## Agradecimentos
Este projeto é o resultado da união entre experiência prática e conhecimento técnico, criado para ser uma ferramenta robusta, confiável e performática. Estou animada para aplicar essa mesma mentalidade de resolução de problemas em desafios profissionais futuros. **Obrigada pelo interesse**.

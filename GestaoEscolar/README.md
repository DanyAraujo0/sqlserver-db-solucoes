# SchoolBD - Sistema de Gestão Escolar
Nesta pasta contém o projeto de um banco de dados relacional completo, chamado SchoolBD, projetado para o gerenciamento de informações e processos essenciais em um ambiente escolar. O sistema foi desenvolvido em SQL Server e inclui não apenas a estrutura das tabelas, mas também uma lógica avançada com Stored Procedures, Triggers (potenciais) e uma estratégia de indexação para otimização de performance.

## 💡 Motivação
A inspiração para o SchoolBD nasceu da minha vivência em escolas. Durante meu tempo na escola, observei de perto o fluxo de informações de alunos, professores e turmas, desde a matrícula até o encerramento do ano letivo.

Percebi os desafios que eram enfrentados tanto pela equipe escolar quanto aos alunos:

- Matrícula e Alocação de Turmas: **Dificuldade em controlar a capacidade das turmas, resultando em turmas superlotadas** ou na alocação manual e propensa a erros de novos alunos.
- Controle de Notas e Frequência: O gerenciamento manual ou fragmentado de notas e frequências dos alunos, tornando **o cálculo da média final e do percentual de frequência um processo demorado e suscetível a erros**.
- Fechamento do Ano Letivo: O desafio de consolidar o desempenho dos alunos (aprovação/reprovação) e preparar o sistema para o próximo ano letivo, muitas vezes exigindo processos manuais complexos e demorados. Por exemplo algo muito recorrente era **quando o ano letivo ja tinha acabado, porém a secretária não conseguia entregar os boletins do alunos**, resultando no atraso de informações para os alunos e no pior dos casos alunos reprovados nem tinha a consciencia do porque da reprovação.
- Acesso Fragmentado à Informação: A busca por históricos de alunos, dados de professores ou informações sobre turmas em registros físicos ou sistemas legados era lenta e, muitas vezes, incompleta. **Em muitas escolas é necessário um tempo absurdo para a entrega do histórico escolar podendo levar meses**.

Diante desse cenário, usei meu conhecimento em SQL Server para desenvolver o SchoolBD, que é a minha proposta de solução para esses problemas, um sistema projetado com base em necessidades reais e com o objetivo de criar um fluxo de dados coeso, seguro e eficiente para a comunidade escolar.

## 🏗️ Estrutura do Banco de Dados
O banco de dados é modelado para ser modular e escalável, separando as responsabilidades em tabelas principais, transacionais e de associação. A criação das tabelas está **localizado em [SchoolBdScript](SchoolBdScript.sql)**.

Tabelas Principais:
- Alunos: Armazena os dados cadastrais dos alunos (nome, CPF, data de nascimento, informações pessoais).
- Responsaveis: Amazena os dados dos responsavel pelo aluno e informações de contato).
- Professores: Registra os dados dos docentes, suas especializações e outras informações relevantes.
- Turmas: Catálogo das turmas disponíveis, incluindo capacidade e ano letivo.
- Disciplinas: Lista de todas as disciplinas oferecidas pela escola.

Tabelas Transacionais (Coração do Sistema):
- Notas: Armazena as notas dos alunos por disciplina e período.
- Frequencias: Registra a frequência dos alunos nas aulas, indicando presença ou falta.
- BoletimFinal: Tabela para consolidar a média final, percentual de frequência e situação (aprovado/reprovado) dos alunos no final do ano letivo.

## 🚀 Recursos Avançados

Para demonstrar conhecimentos além da simples modelagem, o projeto inclui exemplos de código SQL que automatizam processos e otimizam consultas. Vizando também a resolução dos problemas enfrentados citados anteriomente.

Stored Procedures: **localizado em [SchoolBdProcedure](SchoolBdProcedure.sql)**.
sp_MatricularAluno: Encapsula a lógica para matricular um aluno em uma turma específica. Esta procedure verifica a capacidade da turma antes de realizar a matrícula, evitando superlotação e garantindo a integridade dos dados. Isso automatiza e valida o processo de matrícula, prevenindo erros comuns.

sp_FecharAnoLetivo: Esta procedure automatiza o complexo processo de fechamento do ano letivo. Ela calcula a média final e o percentual de frequência dos alunos com base nas notas e frequências registradas, determina a situação final (aprovado/reprovado) e popula a tabela BoletimFinal. Além disso, ela realiza a limpeza das tabelas transacionais (Notas e Frequencias) para o próximo ano, garantindo que os dados sejam arquivados de forma eficiente e o sistema esteja pronto para um novo ciclo. **Localizado em [SchoolBdProcedureBoletim](SchoolBdProcedureBoletim.sql)**

Triggers: **localizado em [SchoolBdTrigger](SchoolBdTrigger.sql)**
Embora o exemplo fornecido não inclua um trigger explícito, o banco de dados é projetado para suportar gatilhos que podem automatizar tarefas como:

trg_PrevenirExclusaoTurmaComAlunos: Um gatilho que poderia ser implementado para impedir a super lotação de turmas, que impede que um aluno seja matriculado em uma turma cheia.

Índices (Otimização de Performance): **localizado em [SchoolBdIndex](SchoolBdIndex.sql)**
Foram criados índices não-clusterizados em colunas-chave para acelerar a performance de consultas, especialmente em:

Chaves Estrangeiras (Foreign Keys): Como IdMatricula na tabela Notas e IdTurma na tabela Alunos, otimizando drasticamente as operações de JOIN entre tabelas.

Colunas de Busca Frequente: Como NomeAluno na tabela Alunos e DataAula na tabela Frequencias, melhorando a velocidade de filtros e relatórios essenciais para a gestão escolar.

Foram feitas inserções fictícias **em [SchoolBdInsert](SchoolBdInsert.sql)**.

Consultas estão detalhadas **em [SchoolBdSelect](SchoolBdSelect.sql)**.

## Agradecimentos
Este projeto é o resultado da união entre experiência prática e conhecimento técnico, criado para ser uma ferramenta robusta, confiável e performática. Estou animada para aplicar essa mesma mentalidade de resolução de problemas em desafios profissionais futuros.**Obrigada pelo interesse**.
🏥 Sistema de Gestão Hospitalar - Hospital_DB
Este projeto consiste na modelagem e implementação de um banco de dados relacional para a gestão de um hospital. O sistema abrange desde o cadastro de pacientes e convênios até o controle de internações, escalas de enfermeiros e receituários médicos.

Status do Projeto: Finalizado (Base para Portfólio de DBA)

🛠️ Tecnologias e Ferramentas
Banco de Dados: MySQL / MariaDB

Linguagem: SQL (DDL, DML, DQL)

Modelagem: Diagrama de Entidade-Relacionamento (DER)

📐 Estrutura do Banco de Dados
O banco foi projetado seguindo as normas de normalização para garantir a integridade dos dados e evitar redundâncias.

Principais Entidades:
Pacientes & Convênios: Gestão de histórico médico e vínculos com planos de saúde.

Corpo Clínico: Médicos com suas respectivas especialidades (Relacionamento N:N) e Enfermeiros.

Atendimento: Consultas vinculadas a médicos, especialidades e pacientes.

Internações: Controle de ocupação de quartos (Enfermaria, Apartamento, Quarto Duplo) e procedimentos realizados.

🚀 Funcionalidades e Scripts
O repositório está organizado nos seguintes blocos lógicos:

Criação (DDL): Scripts de criação de tabelas, definições de chaves primárias (PK), chaves estrangeiras (FK) e evoluções de esquema via ALTER TABLE.

Povoamento (DML): Scripts de inserção de dados fictícios para testes de massa e validação de relacionamentos.

Consultas Avançadas (DQL): Relatórios complexos desenvolvidos para análise de dados:

Cálculo de média de valores de consultas (com e sem convênio).

Cálculo automático de faturamento de internações usando DATEDIFF.

Relatórios de produtividade médica e escalas de enfermeiros.

Filtros dinâmicos por idade (TIMESTAMPDIFF) e especialidade.

🔍 Destaques Técnicos para DBA
Como foco em administração de banco de dados, este projeto demonstra domínio em:

Integridade Referencial: Uso rigoroso de FOREIGN KEYS e tratamento de valores NULL em desvinculação de convênios.

Segurança no DELETE: Implementação de cláusulas LIMIT em operações críticas de exclusão.

Otimização de Queries: Uso de Subqueries e funções de agregação (COUNT, AVG, MAX, MIN) para relatórios gerenciais.

📚 Contexto Acadêmico
Este banco de dados foi desenvolvido como parte das atividades práticas das graduações em Análise e Desenvolvimento de Sistemas (ADS) e cursos técnicos do SENAC, servindo como base para estudos de arquitetura de dados e lógica SQL.

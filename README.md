# lista-de-banco-de-dados

DESCRIÇÃO E EXPLICAÇÃO DOS PACOTES :

* Pacote PKG_ALUNO
Responsável por gerenciar operações relacionadas aos alunos no sistema. Este pacote inclui funcionalidades para exclusão de registros de alunos, listagem de alunos com critérios específicos e filtros baseados em cursos.

Componentes:

Procedure excluir_aluno:
Exclui um aluno com base no id_aluno fornecido como parâmetro.
Remove também todas as matrículas associadas ao aluno, garantindo integridade referencial.

Cursor c_alunos_maiores:
Lista o nome e a data de nascimento de todos os alunos com mais de 18 anos.

Cursor c_alunos_por_curso:
Retorna os nomes dos alunos matriculados em um curso específico, baseado no id_curso passado como parâmetro.
____________________________________________________________________________________________________________________________________________________________________________________________________________

* Pacote PKG_DISCIPLINA
Gerencia informações e operações relacionadas às disciplinas. Inclui funcionalidades para cadastro de novas disciplinas, análise de dados sobre alunos matriculados, e listagem de alunos em uma disciplina específica.

Componentes:

Procedure cadastrar_disciplina:
Permite cadastrar uma nova disciplina no sistema, recebendo parâmetros como nome, descrição e carga horária.

Cursor c_total_alunos_disciplina:
Retorna a quantidade de alunos matriculados em cada disciplina. Exibe apenas as disciplinas com mais de 10 alunos.

Cursor c_media_idade:
Calcula a média de idade dos alunos matriculados em uma disciplina específica, recebendo o id_disciplina como parâmetro.

Procedure listar_alunos_disciplina:
Exibe os nomes de todos os alunos matriculados em uma disciplina específica, com base no id_disciplina informado.
____________________________________________________________________________________________________________________________________________________________________________________________________________

* Pacote PKG_PROFESSOR
Focado nas operações relacionadas aos professores. Inclui análises sobre a quantidade de turmas e associações entre disciplinas e professores.

Componentes:

Cursor c_turmas_por_professor:
Lista os nomes dos professores e a quantidade de turmas que cada um ministra. Exibe apenas professores que lecionam em mais de uma turma.

Function total_turmas_professor:
Calcula e retorna o total de turmas associadas a um professor, com base no id_professor fornecido como parâmetro.

Function professor_disciplina:
Retorna o nome do professor responsável por uma disciplina, a partir do id_disciplina informado.

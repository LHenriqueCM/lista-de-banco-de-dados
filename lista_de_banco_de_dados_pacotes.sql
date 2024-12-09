***    Pacote PKG_ALUNO    ***

--Procedure de Exclusão de Aluno

PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
BEGIN
   DELETE FROM MATRICULA WHERE id_aluno = p_id_aluno;
   DELETE FROM ALUNO WHERE id_aluno = p_id_aluno;
END excluir_aluno;
________________________________________________________
--Cursor de Listagem de Alunos Maiores de 18 Anos

CURSOR c_alunos_maiores IS
   SELECT nome, data_nascimento
   FROM ALUNO
   WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM data_nascimento) > 18;
________________________________________________________
--Cursor com Filtro por Curso

CURSOR c_alunos_por_curso(p_id_curso IN NUMBER) IS
   SELECT nome
   FROM ALUNO
   WHERE id_curso = p_id_curso;
________________________________________________________
***    PKG_DISCIPLINA    ***

--Procedure de Cadastro de Disciplina

PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
BEGIN
   INSERT INTO DISCIPLINA (nome, descricao, carga_horaria)
   VALUES (p_nome, p_descricao, p_carga_horaria);
END cadastrar_disciplina;
________________________________________________________
--Cursor para Total de Alunos por Disciplina

CURSOR c_total_alunos_disciplina IS
   SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
   FROM DISCIPLINA d
   JOIN MATRICULA m ON d.id_disciplina = m.id_disciplina
   GROUP BY d.nome
   HAVING COUNT(m.id_aluno) > 10;
________________________________________________________
--Cursor com Média de Idade por Disciplina

CURSOR c_media_idade(p_id_disciplina IN NUMBER) IS
   SELECT AVG(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM a.data_nascimento)) AS media_idade
   FROM MATRICULA m
   JOIN ALUNO a ON m.id_aluno = a.id_aluno
   WHERE m.id_disciplina = p_id_disciplina;
________________________________________________________
--Procedure para Listar Alunos de uma Disciplina

PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
BEGIN
   FOR r IN (
      SELECT a.nome
      FROM MATRICULA m
      JOIN ALUNO a ON m.id_aluno = a.id_aluno
      WHERE m.id_disciplina = p_id_disciplina
   ) LOOP
      DBMS_OUTPUT.PUT_LINE(r.nome);
   END LOOP;
END listar_alunos_disciplina;
________________________________________________________
***    Pacote PKG_PROFESSOR    ***

--Cursor para Total de Turmas por Professor

CURSOR c_turmas_por_professor IS
   SELECT p.nome, COUNT(t.id_turma) AS total_turmas
   FROM PROFESSOR p
   JOIN TURMA t ON p.id_professor = t.id_professor
   GROUP BY p.nome
   HAVING COUNT(t.id_turma) > 1;
________________________________________________________
--Function para Total de Turmas de um Professor

FUNCTION total_turmas_professor(p_id_professor IN NUMBER) RETURN NUMBER IS
   v_total NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO v_total
   FROM TURMA
   WHERE id_professor = p_id_professor;

   RETURN v_total;
END total_turmas_professor;
________________________________________________________
--Function para Professor de uma Disciplina

FUNCTION professor_disciplina(p_id_disciplina IN NUMBER) RETURN VARCHAR2 IS
   v_nome_professor VARCHAR2(100);
BEGIN
   SELECT p.nome
   INTO v_nome_professor
   FROM PROFESSOR p
   JOIN TURMA t ON p.id_professor = t.id_professor
   WHERE t.id_disciplina = p_id_disciplina;

   RETURN v_nome_professor;
END professor_disciplina;
________________________________________________________

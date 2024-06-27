-- Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo='alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo="alumno" AND telefono IS NULL OR telefono='';

-- Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = "alumno" AND year(fecha_nacimiento) = 1999;

-- Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo='profesor' AND telefono IS NULL AND nif LIKE'%k';

-- Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre=1 AND curso=3 AND id_grado=7;

-- Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS departamento FROM persona INNER JOIN profesor ON persona.id=profesor.id_profesor INNER JOIN departamento ON profesor.id_departamento=departamento.id WHERE persona.tipo='profesor' ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;

-- Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT persona.nombre AS 'Nom alumne', asignatura.nombre AS 'Nom assignatura', curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno=persona.id INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura=asignatura.id INNER JOIN curso_escolar ON curso_escolar.id=alumno_se_matricula_asignatura.id_curso_escolar WHERE persona.nif="26902806M";

-- Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM departamento INNER JOIN profesor ON profesor.id_departamento=departamento.id INNER JOIN asignatura ON asignatura.id_profesor=profesor.id_profesor INNER JOIN grado ON asignatura.id_grado=grado.id WHERE grado.nombre='Grado en Ingeniería Informática (Plan 2015)';

-- Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2 FROM persona INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno=persona.id INNER JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar=curso_escolar.id WHERE curso_escolar.anyo_inicio='2018' AND curso_escolar.anyo_fin='2019' AND persona.tipo='alumno';

Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS 'Departament', persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento=departamento.id ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

-- Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' AND profesor.id_departamento IS NULL;

-- Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento WHERE profesor.id_departamento IS NULL;

-- Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo='profesor';

-- Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT asignatura.nombre FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor=profesor.id_profesor WHERE profesor.id_profesor IS NULL;

-- Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

Consultes resum:

-- Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) AS total_alumnes FROM persona WHERE tipo='alumno';

-- Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) AS alumnes_nascuts_1999 FROM persona WHERE tipo='alumno' AND year(fecha_nacimiento) = 1999;

-- Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre AS nom_departament, COUNT(profesor.id_profesor) AS nombre_professors FROM departamento INNER JOIN profesor ON departamento.id=profesor.id_departamento GROUP BY departamento.nombre ORDER BY nombre_professors DESC;

-- Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS nombre_de_professors FROM departamento LEFT JOIN profesor ON departamento.id=profesor.id_departamento GROUP BY departamento.nombre ORDER BY nombre_de_professors DESC;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.id) AS nombre_Assignatures FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre ORDER BY nombre_Assignatures DESC;

-- Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id) AS nombre_Assignatures FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id)>40 ORDER BY nombre_Assignatures DESC;

-- Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

-- Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

-- Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

-- Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo='alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;

-- Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
(1)-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;

-- Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio, ROUND(precio*1.2,2) FROM producto;

(5)-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS nom_de_producto, precio AS euros, ROUND(precio*1.2,2) AS preu_en_dolars FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS NOM, precio FROM producto;

-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nom, precio FROM producto;

-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(LEFT(nombre, 2)) AS abreviatura FROM fabricante;

-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio, 0) AS preu_arrodonit FROM producto;

(10)-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS "Preu sense decimal" FROM producto;

-- Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo=producto.codigo_fabricante;

-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo=producto.codigo_fabricante;

-- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

(15)-- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5;

-- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

-- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

(20)-- Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante=2;

-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre AS "Nom producte", p.precio, f.nombre AS "Nom del fabricant" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo;

-- Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre AS "Nom producte", p.precio, f.nombre AS "Nom del fabricant" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY f.nombre ASC;

-- Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo AS "Codi producte", p.nombre AS "Nom del producte", f.codigo AS "Codi fabricant", f.nombre AS "Nom del fabricant" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo;

-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre AS "Nom producte", p.precio, f.nombre AS "Nom del fabricant" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY precio ASC LIMIT 1;

(25)-- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre AS "Nom producte", p.precio, f.nombre AS "Nom del fabricant" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante=f.codigo ORDER BY precio DESC LIMIT 1;

-- Retorna una llista de tots els productes del fabricant Lenovo.
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre="Lenovo";

-- Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT * FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre="Crucial" AND producto.precio > 200;

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT * FROM producto INNER JOIN fabricante f ON producto.codigo_fabricante=f.codigo WHERE f.nombre="Asus" OR f.nombre="Hewlett-Packard" OR f.nombre="Seagate";

-- Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT * FROM producto INNER JOIN fabricante f ON producto.codigo_fabricante=f.codigo WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

(30)-- Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.

Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).

-- Llista el nom del producte més car del fabricant Lenovo.
SELECT producto.nombre, producto.precio, fabricante.nombre AS 'Fabricante' FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre='Lenovo' ORDER BY producto.precio DESC LIMIT 1;

-- Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT producto.nombre, producto.precio, fabricante.nombre AS 'Fabricante' FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo WHERE fabricante.nombre='Hewlett-Packard' ORDER BY producto.precio ASC LIMIT 1;

Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
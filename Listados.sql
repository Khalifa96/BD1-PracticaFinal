use adminviviendas;


/*LISTADOS PARA LA CONSEJERÍA DE VIVIENDA Y URBANISMO

Primera consulta, listado de zonas urbanas con precio medio del m2, nombre, área coord. geográficas
municipio y provincia. Ordenado por provincia y municipio
*/
SELECT b.avgM2price, b.nombre, b.area, b.coord, m.nombre, p.nombre
FROM Barrios b, Municipios m, Provincias p
WHERE b.idMunicipio = m.idMunicipio AND m.codigoProvincia = p.codigoProvincia
ORDER BY p.nombre, m.nombre;

/*Segundo listado, igual pero ordenado por el precio del m2*/

SELECT b.avgM2price, b.nombre, b.area, b.coord, m.nombre, p.nombre
FROM Barrios b, Municipios m, Provincias p
WHERE b.idMunicipio = m.idMunicipio AND m.codigoProvincia = p.codigoProvincia
ORDER BY b.avgM2price;

/*Tercer listado, viviendas vacias en cada zona urbana

W3C ~~~ SQL LEFT JOIN Keyword
The LEFT JOIN keyword returns all records from the left table (table1), and the matched records from the right table (table2).
The result is NULL from the right side, if there is no match.
*/

SELECT DISTINCT v.nºCatastro, v.calle, v.num, v.piso, v.m2, v.precioTasacion
FROM Viviendas v
LEFT JOIN Ocupantes o ON v.nºCatastro = o.nºCatastro
WHERE o.nombre IS NULL
ORDER BY v.precioTasacion;




/*LISTADOS PARA LA CONSEJERÍA DE BIENESTAR SOCIAL
Cuarto listado, viviendas habitadas por una única persona de mas de 70 años */


SELECT DISTINCT v.nºCatastro, v.calle, v.num, v.piso, v.m2, v.precioTasacion, b.*
FROM Viviendas v, Ocupantes o, Barrios b
WHERE v.nºCatastro = o.nºCatastro AND v.idBarrios = b.idBarrios AND ((YEAR(CURRENT_TIME()) - YEAR(o.fNac)) - (DATE_FORMAT(CURRENT_TIME(), '00-%m-%d') < DATE_FORMAT(o.fNac, '00-%m-%d'))) >= 70
ORDER BY v.precioTasacion;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM Ocupantes
WHERE ((YEAR(CURRENT_TIME()) - YEAR(fNac)) - (DATE_FORMAT(CURRENT_TIME(), '00-%m-%d') < DATE_FORMAT(fNac, '00-%m-%d'))) >= 70;

SELECT * FROM Ocupantes
WHERE ((YEAR(CURRENT_TIME()) - YEAR(fNac)) - (DATE_FORMAT(CURRENT_TIME(), '00-%m-%d') < DATE_FORMAT(fNac, '00-%m-%d'))) > 70;

((YEAR(current_time) - YEAR(date_of_birth)) - (DATE_FORMAT(current_time, '00-%m-%d') < DATE_FORMAT(date_of_birth, '00-%m-%d'))) > 70;

SELECT * FROM Viviendas v
WHERE o.nºCatastro = null;

SELECT * FROM Barrios;


/*LISTADOS PARA LA CONSEJERÍA DE ECONOMÍA Y HACIENDA
Quinto listado, propietarios que no estan al corriente de pagos*/


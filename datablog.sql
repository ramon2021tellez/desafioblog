\c daniela
--eliminar base datos rols creada por error
DROP DATABASE rols;
--creada base de datos rols por error
CREATE DATABASE rols;
--elimina base de datos para el correcto funcionamiento del ejercicio
DROP DATABASE blog;
--crear base de datos blogs
CREATE DATABASE blog;
\c blog
DROP TABLE rol;
--creacion tabla usuario
CREATE TABLE usuario(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE    
);
--ingresar datos desde archivo usuario csv
\copy usuario FROM 'usuario1.csv' csv header;
SELECT * FROM usuario;
--creacion tabla post
CREATE TABLE post(
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id),
    titulo VARCHAR(100) NOT NULL UNIQUE,
    fecha DATE NOT NULL     
);
\copy post FROM 'post.csv' csv header;
SELECT * FROM post;
--creacion tabla comentario
CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL REFERENCES post(id),
    usuario_id INT NOT NULL REFERENCES usuario(id),
    texto VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL   
);
\copy comentario FROM 'comentarios.csv' csv header;
SELECT * FROM comentario;
--seleccion correo , id y  titulo 
SELECT usuario.email, post.id , post.titulo
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE usuario.id = 5 ;
--solicita el correo , el id y texto que no hayan sido realizados por el email usuario06@hotmail.com
SELECT usuario.email,comentario.id,comentario.texto
FROM usuario
JOIN comentario
ON comentario.usuario_id = usuario_id
WHERE usuario.email != 'usuario06@hotmail.com';
--listar los usuarios que no han comentado ningun post
SELECT *
FROM usuario
LEFT JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha IS NULL;
--listar todos los post incluyendo los sin comentarios
SELECT *
FROM post
FULL OUTER JOIN comentario
ON post.id = comentario.post_id
--listar todos los usuarios que hayan publicado un post en junio
SELECT usuario.id , usuario.email
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';
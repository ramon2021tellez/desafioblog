\c daniela
DROP DATABASE rols;
CREATE DATABASE rols;
DROP DATABASE blog;
CREATE DATABASE blog;
\c blog
DROP TABLE rol;
CREATE TABLE usuario(
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) NOT NULL UNIQUE    
);
\copy usuario FROM 'usuario1.csv' csv header;
SELECT * FROM usuario;

CREATE TABLE post(
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id),
    titulo VARCHAR(100) NOT NULL UNIQUE,
    fecha DATE NOT NULL     
);
\copy post FROM 'post.csv' csv header;
SELECT * FROM post;

CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL REFERENCES post(id),
    usuario_id INT NOT NULL REFERENCES usuario(id),
    texto VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL   
);
\copy comentario FROM 'comentarios.csv'csv header;
SELECT * FROM comentario;

SELECT usuario.email, post.id , post.titulo
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE usuario.id = 5 ;

SELECT usuario.email,comentario.id,comentario.texto
FROM usuario
JOIN comentario
ON comentario.usuario_id = usuario_id
WHERE usuario.email != 'usuario06@hotmail';

SELECT *
FROM usuario
LEFT JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha IS NULL;

SELECT *
FROM post
FULL OUTER JOIN comentario
ON post.id = comentario.post_id

SELECT usuario.*
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30';
CREATE DATABASE MoviesData

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY IDENTITY,
    title VARCHAR(255) NOT NULL,
    imdb_point FLOAT NOT NULL,
    duration INT NOT NULL,
    genre_id INT,
    director_id INT
);

CREATE TABLE Directors (
    director_id INT PRIMARY KEY IDENTITY,
    [Name] VARCHAR(255) NOT NULL
);


CREATE TABLE Actors (
    actor_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE Genres (
    genre_id INT PRIMARY KEY IDENTITY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE Movies_Actors (
    movie_id INT,
    actor_id INT,
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);


ALTER TABLE Movies ADD CONSTRAINT FK_Genre FOREIGN KEY (genre_id) REFERENCES Genres(genre_id);
ALTER TABLE Movies ADD CONSTRAINT FK_Director FOREIGN KEY (director_id) REFERENCES Directors(director_id);


INSERT INTO Genres (name) VALUES ('Action'), ('Comedy'), ('Drama');

INSERT INTO Directors (name) VALUES ('IslamAdisirinli'), ('Fuad Iskenderov'), ('Tuqay Haciyev');

INSERT INTO Actors (name) VALUES ('Leonardo DiCaprio'), ('Brad Pitt'), ('Morgan Freeman');


INSERT INTO Movies (title, imdb_point, duration, genre_id, director_id)
VALUES 
('Inception', 8.8, 148, 1, 2),
('Django Unchained', 8.4, 165, 3, 3),
('The Dark Knight', 9.0, 152, 1, 2);


INSERT INTO Movies_Actors (movie_id, actor_id) VALUES (1, 1), (2, 2), (3, 1), (3, 2);

SELECT 
    M.title AS movie_title, 
    M.imdb_point, 
    G.name AS genre_name, 
    D.name AS director_name, 
    A.name AS actor_name
FROM 
    Movies M
JOIN 
    Genres G ON M.genre_id = G.genre_id
JOIN 
    Directors D ON M.director_id = D.director_id
JOIN 
    Movies_Actors MA ON M.movie_id = MA.movie_id
JOIN 
    Actors A ON MA.actor_id = A.actor_id
WHERE 
    M.imdb_point > 6;


SELECT 
    M.title AS movie_title, 
    M.imdb_point, 
    G.name AS genre_name
FROM 
    Movies M
JOIN 
    Genres G ON M.genre_id = G.genre_id
WHERE 
    G.name LIKE '%a%';


SELECT 
    M.title AS movie_title, 
    M.imdb_point, 
    G.name AS genre_name, 
    D.name AS director_name, 
    A.name AS actor_name
FROM 
    Movies M
JOIN 
    Genres G ON M.genre_id = G.genre_id
JOIN 
    Directors D ON M.director_id = D.director_id
JOIN 
    Movies_Actors MA ON M.movie_id = MA.movie_id
JOIN 
    Actors A ON MA.actor_id = A.actor_id
WHERE 
    M.imdb_point > (SELECT AVG(imdb_point) FROM Movies)
ORDER BY 
    M.imdb_point DESC;


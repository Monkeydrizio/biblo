-----------------------------------------------------------------------
---------------------------- DROP DI TUTTO ----------------------------
-----------------------------------------------------------------------
DROP TABLE book_genre;
DROP TABLE book_author;
DROP TABLE Authors;
DROP TABLE Genres;
ALTER TABLE Borroweds DROP CONSTRAINT user_id_borrowed_fk;
DROP TABLE Users;
ALTER TABLE Borroweds DROP CONSTRAINT book_id_borrowed_fk;
DROP TABLE Borroweds;
DROP TABLE Books;
DROP SEQUENCE books_seq;
DROP SEQUENCE authors_seq;
DROP SEQUENCE genres_seq;
DROP SEQUENCE users_seq;
DROP SEQUENCE borroweds_seq;

-----------------------------------------------------------------------
--------------------- CREAZIONE TABELLE E SEQUENZE---------------------
-----------------------------------------------------------------------

CREATE SEQUENCE books_seq;

CREATE TABLE Books (
book_id INTEGER
   constraint book_pk primary key, -- E' sempre buona idea dare i nome alle constraints, aiuta molto in fase di debugging!!! <----- NOTA BENE
title VARCHAR2(60));

CREATE SEQUENCE authors_seq;

CREATE TABLE Authors (
author_id INTEGER
constraint author_pk primary key,
name VARCHAR2(15),
surname VARCHAR2(15),
nationality VARCHAR2(3), --- SIGLA DA TRE LETTERE ITA, GER, ENG etc..
CONSTRAINT author_name_and_surname_unique UNIQUE(name, surname)); 

CREATE SEQUENCE genres_seq;

CREATE TABLE Genres (
genre_id INTEGER
constraint genres_pk primary key,
name VARCHAR2(20));

CREATE SEQUENCE users_seq;

CREATE TABLE Users(
user_id INTEGER
constraint user_pk primary key,
name VARCHAR(15),
surname VARCHAR(15),
CONSTRAINT user_name_and_surname_unique UNIQUE(name, surname));

CREATE SEQUENCE borroweds_seq;

CREATE TABLE Borroweds(      --- STORICO PRESTITI
borrowed_id INTEGER
constraint borrow_pk primary key,
user_id INTEGER
CONSTRAINT user_id_borrowed_fk REFERENCES Users(user_id) on delete set null,
book_id INTEGER
CONSTRAINT book_id_borrowed_fk REFERENCES Books(book_id) on delete set null,
start_date DATE,
end_date DATE);

CREATE TABLE book_author (    --- RELAZIONE MANY TO MANY LIBRI AUTORI
book_id INTEGER
CONSTRAINT book_id_fk REFERENCES Books(book_id) on delete set null,
author_id INTEGER
CONSTRAINT author_id_fk REFERENCES Authors(author_id) on delete set null,
CONSTRAINT book_author_couple_unique UNIQUE(book_id, author_id));

CREATE TABLE book_genre(     --- RELAZIONE MANY TO MANY LIBRI GENERI
book_id INTEGER
CONSTRAINT book_id_fk2 REFERENCES Books(book_id) on delete set null,
genre_id INTEGER
CONSTRAINT genre_id_fk REFERENCES Genres(genre_id) on delete set null,
CONSTRAINT book_genre_couple_unique UNIQUE(book_id, genre_id ));

alter table Books add CONSTRAINT barrowed_id_books_fk 
borrowed_id REFERENCES Borroweds(borrowed_id) on delete cascade;


-----------------------------------------------------------------------
--------------------- POPOLO IL DATABASE DI PROVA ---------------------
-----------------------------------------------------------------------

---------- GENERI ----------
INSERT INTO Genres values(genres_seq.nextval, 'Sci-Fi');
INSERT INTO Genres values(genres_seq.nextval, 'History');
INSERT INTO Genres values(genres_seq.nextval, 'Horror');
INSERT INTO Genres values(genres_seq.nextval, 'Science');
INSERT INTO Genres values(genres_seq.nextval, 'Fantasy');
INSERT INTO Genres values(genres_seq.nextval, 'Thriller');
INSERT INTO Genres values(genres_seq.nextval, 'Comedy');
INSERT INTO Genres values(genres_seq.nextval, 'Drama');
INSERT INTO Genres values(genres_seq.nextval, 'Cooking');

---------- AUTORI ----------
INSERT INTO Authors values(authors_seq.nextval, 'Isaac', 'Asimov', 'RUS');
INSERT INTO Authors values(authors_seq.nextval, 'Joanne', 'Rowling', 'GB');
INSERT INTO Authors values(authors_seq.nextval, 'Luigi', 'Pirandello', 'ITA');
INSERT INTO Authors values(authors_seq.nextval, 'Alessandro', 'Manzoni', 'ITA');
INSERT INTO Authors values(authors_seq.nextval, 'Oscar', 'Wilde', 'GB');
INSERT INTO Authors values(authors_seq.nextval, 'Dan', 'Brown', 'USA');

---------- LIBRI ----------
INSERT INTO Books values(books_seq.nextval, 'Foundation', null);
INSERT INTO Books values(books_seq.nextval, 'Foundation and Empire', null);
INSERT INTO Books values(books_seq.nextval, 'Second Foundation', null);
INSERT INTO Books values(books_seq.nextval, 'Harry Potter and the Philosopher''s Stone', null);
INSERT INTO Books values(books_seq.nextval, 'Il fu Mattia Pascal', null);
INSERT INTO Books values(books_seq.nextval, 'Uno, nessuno e centomila', null);
INSERT INTO Books values(books_seq.nextval, 'The Picture of Dorian Gray', null);
INSERT INTO Books values(books_seq.nextval, 'The Da Vinci Code', null);
INSERT INTO Books values(books_seq.nextval, 'Inferno', null);
INSERT INTO Books values(books_seq.nextval, 'I Promessi Sposi', null);

----- RELAZIONI -----
INSERT INTO book_genre values(1,1);
INSERT INTO book_genre values(2,1);
INSERT INTO book_genre values(3,1);
INSERT INTO book_genre values(4,5);
INSERT INTO book_genre values(5,8);
INSERT INTO book_genre values(6,8);
INSERT INTO book_genre values(7,8);
INSERT INTO book_genre values(7,5);
INSERT INTO book_genre values(8,6);
INSERT INTO book_genre values(9,6);
INSERT INTO book_genre values(10,8);

INSERT INTO book_author values(1,1);
INSERT INTO book_author values(2,1);
INSERT INTO book_author values(3,1);
INSERT INTO book_author values(4,2);
INSERT INTO book_author values(5,3);
INSERT INTO book_author values(6,3);
INSERT INTO book_author values(7,5);
INSERT INTO book_author values(8,6);
INSERT INTO book_author values(9,6);
INSERT INTO book_author values(10,4);

----- USERS -----
INSERT INTO Users values(users_seq.nextval,'Maurizio','Pilato');
INSERT INTO Users values(users_seq.nextval,'Michele','Andreolli');
INSERT INTO Users values(users_seq.nextval,'Emanuele','Baldi');
INSERT INTO Users values(users_seq.nextval,'Silvia','Di Caro');
INSERT INTO Users values(users_seq.nextval,'Antonio','Pontrelli');


SELECT books.title, authors.name, authors.surname
FROM Books NATURAL JOIN book_author
NATURAL JOIN Authors;

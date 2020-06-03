CREATE TABLE raw_book(
	bookid SERIAL NOT NULL UNIQUE,
	title text NOT NULL,
	author text NOT NULL,
	author_id integer,
	author_bio text,
	authors text,
	title_slug text,
	author_slug text,
	isbn13 BIGINT,
	isbn10 text,
	price text,
	format text,
	publisher text,
	pubdate text,
	edition text,
	subjects text,
	lexile text,
	pages integer,
	dimensions text,
	overview text,
	excerpt text,
	synopsis text,
	toc text,
	editorial_reviews text,
	primary key (bookid)
);


COPY IBook(bookid,title,author,author_id,author_bio,authors,title_slug,author_slug,isbn13,isbn10,price,format,publisher,pubdate,edition,subjects,lexile,pages,dimensions,overview,excerpt,synopsis,toc,editorial_reviews)
FROM PROGRAM 'curl "https://www.usabledatabases.com/database/books-isbn-covers/sample/files/book.csv"' 
CSV HEADER DELIMITER ',';


CREATE TABLE authors (
	author_id SERIAL NOT NULL UNIQUE,
	author text NOT NULL,
	author_bio text,
	authors text,
	author_slug text,
	primary key (author_id)
);

INSERT INTO authors (author_id, author, author_bio, authors, author_slug)
SELECT DISTINCT ON (author_id) author_id, author, author_bio, authors, author_slug FROM raw_book;


CREATE TABLE book_to_subject(
	bookid SERIAL NOT NULL UNIQUE,
	subject_id integer,
	sub_subject_id integer,
	sub_sub_subject_id integer,
	FOREIGN KEY (bookid) REFERENCES raw_book (bookid)
);

INSERT INTO book_to_subject (bookid, subject_id, sub_subject_id, sub_sub_subject_id)
WITH  raw_subjects as (
SELECT split_part(subjects, ',', 1) AS subject
     , split_part(subjects, ',', 2) AS sub_subject
     , split_part(subjects, ',', 3) AS sub_sub_subject
	 , bookid
FROM (SELECT subjects, bookid FROM raw_book) ss),
subject_idx as (SELECT DISTINCT ON (subject) DENSE_RANK() OVER(ORDER BY subject) as subject_id, subject FROM raw_subjects),
sub_subject_idx as (SELECT DISTINCT ON (sub_subject) DENSE_RANK() OVER(ORDER BY sub_subject) as sub_subject_id, sub_subject FROM raw_subjects),
sub_sub_subject_idx as (SELECT DISTINCT ON (sub_sub_subject) DENSE_RANK() OVER(ORDER BY sub_sub_subject) as sub_sub_subject_id, sub_sub_subject FROM raw_subjects)

SELECT sub.bookid, subject_idx.subject_id, sub_subject_idx.sub_subject_id, sub_sub_subject_idx.sub_sub_subject_id
FROM raw_subjects AS sub
LEFT JOIN subject_idx ON sub.subject = subject_idx.subject
LEFT JOIN sub_subject_idx ON sub.sub_subject = sub_subject_idx.sub_subject
LEFT JOIN sub_sub_subject_idx ON sub.sub_sub_subject = sub_sub_subject_idx.sub_sub_subject;


CREATE TABLE subject(
	subject_id integer,
	subject text
);

CREATE TABLE sub_subject(
	subject_id integer,
	subject text
);

CREATE TABLE sub_sub_subject(
	subject_id integer,
	subject text
);

INSERT INTO subject (subject_id, subject)
SELECT DISTINCT ON (subject) DENSE_RANK() OVER(ORDER BY subject) as subject_id, subject 
FROM (SELECT split_part(subjects, ',', 1) AS subject
	  FROM (SELECT subjects, bookid FROM raw_book) ss) ss;

INSERT INTO sub_subject (subject_id, subject)
SELECT DISTINCT ON (subject) DENSE_RANK() OVER(ORDER BY subject) as subject_id, subject 
FROM (SELECT split_part(subjects, ',', 2) AS subject
	  FROM (SELECT subjects, bookid FROM raw_book) ss) ss;


INSERT INTO sub_sub_subject (subject_id, subject)
SELECT DISTINCT ON (subject) DENSE_RANK() OVER(ORDER BY subject) as subject_id, subject 
FROM (SELECT split_part(subjects, ',', 3) AS subject
	  FROM (SELECT subjects, bookid FROM raw_book) ss) ss;









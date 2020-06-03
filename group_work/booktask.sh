#!/bin/bash
psql -U easycar -h localhost << EOF

CREATE TABLE Book(BookID integer UNIQUE,Title text NOT NULL,Author text NOT NULL,AuthorID integer,AuthorBio text,Authors text,title_slug text,author_slug text,isbn13 BIGINT,isbn10 text,price text,format text,publisher text,pubdate text,edition text,subjects text,lexile text,pages integer,dimensions text,overview text,excerpt text,synopsis text,toc text,editorial_reviews text);

COPY book FROM PROGRAM 'curl "https://www.usabledatabases.com/database/books-isbn-covers/sample/files/book.csv"' HEADER CSV DELIMITER ',';

SELECT BookId FROM book;

EOF

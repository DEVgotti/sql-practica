create schema if not exists davidllamas;
set schema 'davidllamas';

create table if not exists customer(
	customer_id serial primary key,
	customer_name varchar(50) not null,
	customer_surname varchar(50) not null,
	customer_birthday date not null,
	customer_phone varchar(9) not null,
	customer_dni varchar(9) not null,
	residence_id smallint
);

create table if not exists residence(
	residence_id serial primary key,
	residence_postcode smallint not null,
	residence_street text not null,
	residence_exntesion varchar(50) not null
);

create table if not exists rental(
	rental_id serial primary key,
	customer_id smallint not null,
	movie_id smallint not null,
	rental_rented date not null,
	rental_returned date not null
);

create table if not exists movie(
	movie_id serial primary key,
	movie_title varchar(200) not null,
	movie_published date not null,
	movie_director varchar(100) not null,
	movie_synopsis text not null,
	movie_copies int not null
);

create table if not exists genre_movie(
	genre_movie_id serial primary key,
	movie_id smallint not null,
	genre_id smallint not null
);

create table if not exists genre(
	genre_id serial primary key,
	genre_name varchar(20) not null
);

alter table customer add constraint fk_residence_customer
foreign key (residence_id) references residence(residence_id);

alter table rental add constraint fk_customer_rental
foreign key (customer_id) references customer(customer_id);

alter table rental add constraint fk_movie_rental
foreign key (movie_id) references movie(movie_id);

alter table genre_movie add constraint fk_genre_movie_movie
foreign key (movie_id) references movie(movie_id);

alter table genre_movie add constraint fk_genre_movie_genre
foreign key (genre_id) references genre(genre_id);
create schema if not exists davidllamas;
set schema 'davidllamas';

create table if not exists customer(
	customer_id serial primary key,
	customer_name varchar(50) not null,
	customer_surname varchar(50) not null,
	customer_birthday date not null,
	customer_phone varchar(9) not null,
	customer_dni varchar(9) not null,
	residence_id int
);

create table if not exists residence(
	residence_id serial primary key,
	residence_postcode int not null,
	residence_street text not null,
	residence_number int not null,
	residence_floor int,
	residence_extension varchar(50)
);

create table if not exists rental(
	rental_id serial primary key,
	customer_id int not null,
	movie_id int not null,
	rental_rented date not null,
	rental_returned date not null
);

create table if not exists movie(
	movie_id serial primary key,
	movie_title varchar(200) not null,
	movie_published date not null,
	director_id int not null,
	movie_synopsis text not null,
	movie_copies int not null
);

create table if not exists genre_movie(
	genre_movie_id serial primary key,
	movie_id int not null,
	genre_id int not null
);

create table if not exists genre(
	genre_id serial primary key,
	genre_name varchar(20) not null
);

create table if not exists director(
	director_id serial primary key,
	director_name varchar(50) not null
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

alter table movie add constraint fk_director_movie
foreign key (director_id) references director(director_id);

insert into genre (genre_name) 
values 
('Acción'),
('Drama'),
('Suspense'),
('Bélico'),
('Aventura');

insert into director (director_name)
values
('Akira Kurosawa'),
('Eiichi Kudo'),
('Masaki Kobayashi'),
('John Huston'),
('George Marshall'),
('Sergio Leone');

/*
 * Desconozco el mes/día de publicación de las películas así que utilizo el 1 de enero como relleno para respetar el formato fecha.
 * Sería más lógico utilizar un 'int' con el año pero no se si utilizar el tipo 'date' aquí forma parte de la practica como tal.
 */
insert into movie (movie_title, movie_published, director_id, movie_synopsis, movie_copies)
values
('Yojimbo', '1961-01-01', 1, 'asd', 1),
('Shichinin no samurai', '1954-01-01', 1, 'A veteran samurai, who has fallen on hard times, answers a village''s request for protection from bandits. He gathers 6 other samurai to help him, and they teach the townspeople how to defend themselves, and they supply the samurai with three small meals a day. The film culminates in a giant battle when 40 bandits attack the village.', 2),
('Seppuku', '1962-01-01', 3, 'A samurai, Hanshiro Tsugumo, arrives at the house of the Iyi Clan with an unusual request. Due to his circumstances, he wishes to commit harakiri, ritual suicide, in the courtyard of the house. Turns out this is not such an unusual request: the clan has had such requests before, though the requestor''s intentions weren''t always honourable. The Clan elder tells Tsugumo the story of the last samurai who made the request and how that ended. Will he still go through with it?', 1),
('Jusan-nin no shikaku', '1963-01-01', 2, 'A sadistic Daimyo (feudal lord) rapes a woman and murders both her and her husband, but even when one of his own vassals commits suicide to bring attention to the crime, the matter is quickly hushed up. Not only will there be no punishment, but because the Daimyo is the Shogun''s younger brother, he will soon be appointed to a high political position from which he could wreak even more havoc. Convinced that the fate of the Shogunate hangs in the balance, a plot is hatched to assassinate the Daimyo. The two most brilliant strategic minds of their generation find themselves pitted against each other; one is tasked to defend a man he despises, and has a small army at his disposal. The other is given a suicide mission, and has 12 brave men. They are the 13 Assassins.', 4),
('The Unforgiven', '1960-01-01', 4, 'In post-Civil War Texas, the Zachary and Rawlins families are intrinsically tied together. Ben Zachary, the head of the family following the death of his father, Will Zachary, in Ben being the oldest son, and patriarch Zeb Rawlins are partners in a cattle ranching operation. Zeb''s unassuming son Charlie Rawlins would like to court Ben''s younger sister, adopted Rachel Zachary - something that doesn''t quite sit well with Ben in he believing Charlie not worthy of Rachel - while Zeb''s daughter Georgia Rawlins would be happy with any of the Zachary brothers, although she has her sights set on middle son Cash Zachary. Their world is upset with the arrival of an older man brandishing a saber. It is not the saber which is concerning, but rather the story that he is spreading: that Rachel is of Indian heritage, most specifically Kiowa. Regardless of the truth, which matriarch Mattilda Zachary knows, this story places a strain on the community who don''t want a "dirty Injun" in their midst, threatens all the relationships between the Zacharys and Rawlins, and causes a division within the Zachary family, as the Zacharys try to protect themselves and their property against those who don''t want Rachel there, including the Kiowa who want Rachel, one of their own, back.', 2),
('The Sheepman', '1958-01-01', 5, 'A stranger in a Western cattle-town behaves with remarkable self-assurance, establishing himself as a man to be reckoned with. The reason appears with his stock: a herd of sheep, which he intends to graze on the range. The horrified inhabitants decide to run him out at all costs.', 3),
('Per un pugno di dollari', '1964-01-01', 6, 'With nothing but profit on his mind, a taciturn American with a lightning-fast right hand rides into San Miguel, a sun-bleached border town where everyone is either rich or dead. As the amoral man with no name discovers that the sleepy town provides the perfect opportunity to make a quick buck, the mysterious stranger soon finds himself caught in the middle of a destructive, long-standing feud. After all, the corrupt Baxters and the murderous Rojos, two feuding families fighting for control, won''t let a nameless nobody get a slice of the cake. But the dusty, poncho-clad newcomer has already set his sights on the grand prize--the only way to get it is to play the gangs off against each other in a deadly battle of wits. Of course, no one has pulled such a reckless stunt and lived to tell the tale. How far is a man willing to go for a fistful of dollars?', 5);

insert into residence (residence_postcode, residence_street, residence_number, residence_floor, residence_extension)
values
(47007, 'Francisco Pizarro', 6, 4, '3D'),
(47007, 'Antonio Machado', 2, 3, '4A'),
(47007, 'Concepción Arenal', 11, 2, NULL);

insert into customer (customer_name, customer_surname, customer_birthday, customer_phone, customer_dni, residence_id)
values
('Ivan', 'Santana', '2005-02-15', 694804631, '1124603H', 1),
('Rodrigo', 'Rojas', '2006-10-23', 607425989, '7402615L', NULL),
('Carla', 'Lopez', '1992-06-26', 666238181, '6298662C', 2),
('Eduardo', 'Rubio', '1990-10-12', 684839436, '2237186E', NULL),
('Eva', 'Nuñez', '1998-03-09', 671280006, '6152776T', NULL),
('Jaime', 'Caballero', '2015-03-22', 616805343, '7402615L', 3),
('Adrian', 'Dominguez', '2010-11-03', 604696806, '3913881V', NULL);

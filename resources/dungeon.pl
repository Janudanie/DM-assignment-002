:- dynamic location/2.
location(key,hidden).
location(sword,hidden).

location(you,room1).

:- dynamic connect/2.
connect(room1,room2).
connect(room2,room1).
connect(room2,room3).
connect(room3,room2).
connect(room3,room4).




goto(X) :-
  location(you, L),
  connect(L, X),
  retract( location(you, L) ),
  assert( location(you, X) ),
  write(" You are in the "), write(X), nl;
  write(" You can't get there from here. "), nl.


take(X) :-
	location(you,L),
	location(X,L),
	retract(location(X,L)),
	assert(location(X,you)),nl.
	
	
inv :-
	location(key,you),location(sword,you),
	write("you have the key"),nl,
	write("you have the sword"),nl;
	
	location(key,you),
	write("you have the key"),nl;
	
	location(sword,you),
	write("you have the sword"),nl;
	write("you have nothing"),nl.

invt :-
	location(L,you),
	write(L),nl;
	write("you have nothing").

go :- done.
go :-
  write('>> '),
  read(X),
  call(X),
  go.

kill :- 
	location(you,room4),location(sword,you),write("you quickly kill the skeleton, and find a way further"),
	assert(connect(room4,room5)),
	assert(connect(room4,room3)),
	assert(connect(room5,room4)),
	nl.

use(X) :-
	location(key,you),location(you,room5), write("you unlock the chest, and take the pouch with gold"),assert(location(pouch,you)),nl.

done :-
  (location(you, room1),
  location(pouch,you),
  write(" You have the pouch and leave the dungeon to go buy ale "), nl;
  location(you,room4),
  location(sword,hidden),
  write("You enter the room, there is a skeleton here, it quickly attacks you, and you have no sword, you quickly die"),nl).
  
look :-
	(location(you,room1) ->
		write(" You are in the first room"),nl;
	location(you,room2) ->
		write(" You are in the second room"),nl;
	location(you,room3) ->
		write(" You are in the third room"),nl;
	location(you,room4) ->
		write(" You are in the fourth room, there is a skeleton here, it seems very afraid of your sword"),nl;
	location(you,room5) ->
		write(" You are in the fifth room, There is a big chest here"),nl).	
		
search :-
	(location(you,room3),location(key,hidden) ->
		write("you found a key, you pick it up."),
		retract(location(key,hidden)),
		assert(location(key,room3)),
		take(key),nl;
	location(you,room2),location(sword,hidden) ->
		write("you have found the sword, and pick it up"),
		retract(location(sword,hidden)),
		assert(location(sword,room2)),
		take(sword),nl;	
		write("you found nothing"),nl).

	
		
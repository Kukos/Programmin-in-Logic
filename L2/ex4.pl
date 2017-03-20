
have(michal, gryf).
have(bartek, ksiazka).
have(maciek, laptop).
have(maciek, ksiazka).
have(bartek, gryf).

give(3, bartek, gryf, karol).
give(4, karol, gryf, maciek).
give(4, bartek, ksiazka, michal).
give(5, maciek, ksiazka, michal).
give(5, maciek, gryf, bartek).
give(5, maciek, laptop, michal).

/*
 * Wygenereuj strukture czasu
 */
mytime(L) :-    findall(X, give(X, _, _, _), L).

maxtime(X) :-   mytime(L),
                max_list(L, Y),
                X is Y + 1.

/*
Jesli ktos chce spr co sie dzialo po ostatnim fakcie to spr wszystkie
fakty
*/
have(Time, Person, Item) :-   (
                                  mytime(L),
	                              \+ member(Time, L),
			                      maxtime(X),
			                      have2(X, Person, Item)
			                  );
			                  have2(Time, Person, Item).

/*
 * Jesli mial cos na stracie to licznik = 1 else 0
 */
have2(Time, Person, Item) :-    (
                                    have(Person, Item),
                                    have(Time, Person, Item, [], 1)
			                    );
			                    have(Time, Person, Item, [], 0).
/*
JEsli mial i nie oddal do jakiegos czasu to mial go przez ten caly czas
*/
have(Time, Person, Item, _, _) :-   have(Person, Item),
	                                maxtime(T),
			                        between(0, T, Time),
			                        \+ (
				                            give(Time2, Person, Item, _),
				                            Time2 =< Time
			                           ).

/*
Liczymy dla danego czasu ilosc danych i przyjetych rzeczy
dajemy komus -1
dostajemy +1
jesli na koniec > 1 to w danej chwili to mamy
*/

have(Time, Person, Item, List, Counter) :-  give(Time2, Person, Item, Person2),
				                            maxtime(T),
				                            between(0, T, Time),
				                            Time2 =< Time,
				                            \+ member([Time2, Person, Person2], List),
			                                append([[Time2, Person, Person2] | []], List, NewList),
			                                NewCounter is Counter - 1,
				                            have(Time, Person, Item, NewList, NewCounter).

have(Time, Person, Item, List, Counter) :-  give(Time2, Person2, Item, Person),
	                                        maxtime(T),
	                                        between(0, T, Time),
				                            Time2 =< Time,
				                            \+ member([Time2, Person2, Person], List),
			                                append([[Time2, Person2, Person] | []], List, NewList),
			                                NewCounter is Counter + 1,
			                                have(Time, Person, Item, NewList, NewCounter).


have(_, _, _, _, Counter) :- Counter > 0.

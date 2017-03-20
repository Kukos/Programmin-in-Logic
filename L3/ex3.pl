
/* Zauwazmy ze dzieki rekursji lista posorotwana bedzie wychodzic odwrotnie
 * tzn zawsze kolejny element bedzie obecnie najmniejszym elementem (
 * wczesniej sortujemy liste ) permutacji, wiemy ze inwersja to i < j
 * AND PI(i) > PI(j) skoro wiemy ze PI(k) w katym ruchu jest minimalne
 * TO:
 *
 * OBSERWACJA :
 *
 * 1. Wstawiajac minimalny element na parzyste miejsce ( nieparzyta
 * ilosc przed soba ) dodajemy nieparzysta liczbe inwersji
 *
 * 2. Wstawiajac minimalny element na nieparzyste miejsce ( parzysta
 * ilosc przed soba ) dodajemy parzysta liczbe inwersji
 *
 * TWORZENIE PARZYSTYCH
 *
 * 1. Majac permutacje parzystą wstawiając na nieparzyste miejsce
 * ( czyli mamy parzysta liczbe elementow wiekszych ode mnie )
 * zwiekszamy liczbe inwersji o liczbe parzysta zatem nadal nasza
 * permutacja jest parzysta
 *
 * 2. Mając permutacje nieparzystą wstawiając na parzyste miejsce
 * (czyli mam nieparzysta liczbe elementow wiekszych ode mnie )
 * zwiekszamy liczbe inwersji o nieparzysta ilosc wiec permutacja
 * jest parzysta
 *
 * TWORZENIE NIEPARZYSTYCH
 *
 * 1. Majac permutacje nieparzysta wstawiajac na nieparzyste miejsce
 *  dodajemy parzysta ilosc inwersji -> nadal nieparzysta
 *
 * 2. Majac parzysta wstawiajac na parzyste miejsce
 * dodajemy nieparzysta ilosc inwersji -> nieparzysta
 */

even_permutation(L, Perm) :- temp_even_permutation(L, Perm).

temp_even_permutation([], []).
temp_even_permutation([X | T], Perm) :- temp_even_permutation(T, NPerm),
				     					insert_odd(X, NPerm, Perm).

temp_even_permutation([X | T], Perm) :- temp_odd_permutation(T, Perm1),
				     					insert_even(X, Perm1, Perm).

odd_permutation(L, Perm) :- temp_odd_permutation(L, Perm).

temp_odd_permutation([X | T], Perm) :- 	temp_odd_permutation(T, NPerm),
				    					insert_odd(X, NPerm, Perm).

temp_odd_permutation([X |T ], Perm) :- 	temp_even_permutation(T, NPerm),
                                    	insert_even(X, NPerm, Perm).


insert_odd(X, List, [X | List]).
insert_odd(X, [Y, Z | List], [Y, Z | NList]) :- insert_odd(X, List, NList).

insert_even(X, [Y | List], [Y, X | List]).
insert_even(X, [Y, Z | List], [Y, Z | NList] ) :- insert_even(X, List, NList).

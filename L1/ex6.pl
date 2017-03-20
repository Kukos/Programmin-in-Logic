/* 1 nie jest pierwsza wiec odrazu koncz */
is_prime(1) :- !, fail.

/* 2 jest liczba pierwsza */
is_prime(2) :- !.

/* Odrzucamy wszystkie liczby parzyste*/
is_prime(X) :- X > 2,
              (
                X mod 2  =\= 0, !
              ),
/* Teraz bedziemy isc od i = 3 do sqrt(X)*/
              Sqrt is ceiling(sqrt(X)),
	          div_loop(X, 3, Sqrt).

/* jesli I > Max koncz petle z wartoscia true*/
div_loop(_, I, Max) :- I > Max, !.
/* w przeciwnym razie spr czy sie dzieli i idz do nast dzielnika*/
div_loop(X, I, Max) :-  X mod I =\= 0,
		                Next is I + 2,
		                div_loop(X, Next, Max).

prime(Lo, Hi, X) :- between(Lo, Hi, X), is_prime(X).

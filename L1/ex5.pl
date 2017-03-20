/*
r(a, a).
r(b, b).
r(c, c).
r(a, b).
r(b, c).
r(a, c).
r(d, d).
r(e, e).
r(f, f).
r(d, e).
r(e, f).
r(d, f).
*/

r(a, a).
r(b, b).
r(c, c).
r(d, d).
r(e, e).
r(f, f).

r(a, b).
r(a, e).
r(a, c).
r(a, f).
r(a, d).

r(b, e).
r(c, e).
r(c, f).
r(d, f).

/* istnienie elementu w naszej relacji*/
exist(X) :- r(X, _); r(_, X).

/* nie istnieje element nalezacy do relacji r ktory nie ma r(X,X) czyli zwrotnosc*/
reflexive :- \+ (
                    exist(X),
                    \+ r(X, X)
                ).

/* Albo nie ma 3 roznych wtedy jest to prawda
Albo sprawdzamy czy nie istniejsa takie 3 rozne X Y Z ze jesli r(X,Y) AND r(Y,Z) AND NOT r(X,Z),*/
transitive :-  \+ (
                    exist(X),
                    exist(Y),
                    exist(Z),
                    X \= Y,
                    Y \= Z,
                    X \= Z
                 );
		      \+
                 (
		            exist(X),
                    exist(Y),
                    exist(Z),
		            X \= Y,
                    Y \= Z,
                    X \= Z,
		            (
		                r(X,Y),
                        r(Y,Z),
		           \+  (r(X,Z))
		           )
	            ).

/* Albo nie ma dwoch elementow, albo nie istnieja takie 2 elemnty ze
 *  sa symetryczne i sa od siebie rozne
 */
w_antisymmetry :-  \+ (
                        exist(X),
                        exist(Y),
			            X \= Y
		              );
	               \+ (
                        exist(X),
                        exist(Y),
		                r(X,Y),
                        r(Y,X),
			            X \= Y
		              ).

po :- reflexive, transitive, w_antisymmetry.

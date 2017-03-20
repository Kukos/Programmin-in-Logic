male(filip).
male(piotr).
male(jan).
male(karol).
male(tadek).
female(ala).
female(ania).
female(kasia).

father(tadek, jan).
father(karol, ania).
father(jan, ala).
father(jan, piotr).
mother(ania, ala).
mother(kasia, filip).
mother(ania, piotr).


/* father(X,Y).  X jest ojcem Y*/
/* mother(X,Y).  X jest matka Y*/
/* man(X).  jest mezczyzna */
/* woman(X).  X jest kobieta*/
/* parent(X,Y).  X jest rodzicem Y*/

diff(X,Y) :- X \= Y.

parent(X,Y)	 :- mother(X, Y); father(X, Y).
is_mother(X) :- mother(X, _).
is_father(X) :- father(X, _).
is_son(X) 	 :- male(X), once(parent(_, X)).

/* Sa rodzenstwem jesli maja wspolnych rodzicow */
siblings(X, Y) :- 	mother(A, X),
	         		mother(A, Y),
		 			father(B, X),
		 			father(B, Y),
		 			diff(X, Y).

/* X jest siostra Y jesli X to kobieta i X sa rodzenstwem z Y */
sister(X,Y) :- 		female(X),
	       			siblings(X, Y),
	       			diff(X, Y).

/*X jest dziadkiem Y jesli X i Y to rozne osoby, X jest mezczyzna, i jest rodzicem matki lub ojca Y  */
grandfather(X, Y) :- 	male(X),
                    	(
			 				father(X, A),
			 				mother(A, Y)
		    			);
		    			(
							father(X, B),
							father(B, Y)
		    			),
		    			diff(X, Y).

/*

/* przykladowy czesciowy porzadek*/
/*                 c
 *                / \
 *               b   e
 *	            / \
 *	          a    d
 */

r(a, a).
r(a, b).
r(b, b).
r(b, c).
r(c, c).
r(d, d).
r(d, b).
r(e, e).
r(e, c).
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


/* jestem w relacji, i nieprawda ze jest cos pod X ktore jest rozne od X*/
min(X) :- 	r(X, X),
	  		\+ (
					r(Y, X),
					Y \= X
			   ).

/*podobnie do min tylko ze nic nie nad X */
max(X) :- 	r(X, X),
	  		\+ (
					r(X, Y),
					Y \= X
			   ).

/* najwiekszy to taki X ze jest wiekszy od wszystkich ( tzn mozna go porownac z kazdym
 * w zbiorach skonczonych el jest najwiekszy gdy jest jedynym maxymalnym
 * */
gt(X) :- 	max(X),
	 		\+ (
			  		r(Y, Y),
	       			Y \= X,
	       			max(Y)
	    	   ).

/* najmniejszy podonie do najwiekszego tylko ze jest jedynym minimalnym  */
lt(X) :- 	min(X),
	 		\+ (
	      			r(Y, Y),
	      			Y \= X,
	      			min(Y)
	     	   ).

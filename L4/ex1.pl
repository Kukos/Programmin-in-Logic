% Dzieli liste L na L1, L2 przy czym musza miec przynajmniej 1 element
split(L, L1, L2) :- append(L1, L2, L),
	          		L1 = [_ | _],
		  			L2 = [_ | _].

expresion(Numbers, R, X) :- expresion2(Numbers, R, X),
 							R is X.
% 0 elementow niepowodzenie bo nie mamy jak liczyc
expresion2([], _, _) :- !, fail.
% jesli 1 element to zwroc jego wartosc
expresion2([X], _, X).
%jesli zostalo wiecej niz 1 to kontynuj rekurencyjne dzielenie
expresion2(L, R, X) :- 	split(L, L1, L2),
		    			expresion2(L1, R, Y),
		    			expresion2(L2, R, Z),
		   				(
						 	X = Z + Y;
		     				X = Z - Y;
		     				X = Z * Y;
		    				(
								\+(
									( 0.0 is Y);
									( 0 is Y)
								   ) -> X = Z / Y
						    )
		   				).

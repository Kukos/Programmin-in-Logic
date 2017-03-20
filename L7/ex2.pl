merge(IN1,IN2,OUT) :- 	freeze(IN1,
			     			freeze(IN2,(
			     				IN1 = [H1 | T1],
			     				IN2 = [H2 | T2],
			     				(H1 =< H2 -> (OUT = [H1 | NOUT],
											  merge(T1,IN2,NOUT)
											  );
			          			(OUT = [H2|NOUT],merge(IN1,T2,NOUT)))
								);
				    			(
									IN1 = [H1 | T1],
							 		OUT = [H1 | NOUT],
							 		merge(T1, IN2, NOUT)
								);
				    			(
									IN2 = [H2 | T2],
							 		OUT = [H2 | NOUT],
									merge(IN1, T2, NOUT)
								)
				   			);
							OUT = []),!.


split([], [], []).
split([X], [X], []) :- freeze(X, true),!.
split([X, Y | IN], [X | OUT1], [Y | OUT2]) :- freeze(X, freeze(Y, (split(IN, OUT1, OUT2), !))).

mergesort([],[]).
mergesort([X], [X]) :- 	freeze(X, true).

mergesort(IN, OUT):- 	freeze(IN, (split(IN, Left, Right),
	            		mergesort(Left, Sorted1),
		    			mergesort(Right, Sorted2),
		    			merge(Sorted1, Sorted2, OUT))),!.

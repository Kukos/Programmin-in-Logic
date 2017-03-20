%Generowanie listy z liczb od 1 do N
generate(N, Start, List) :- do_list(N, Start, List).

do_list(0, L, L) :- !.
do_list(N, R, L) :- N > 0,
 					N1 is N-1,
					do_list(N1, [N | R], L).

is_good(L) :-	\+ (
                  		member(M, L),
	          			\+ (
	                 			append(L2, [M | _], L),
                         		append(L2, L3, L),
	                 			select(M, L3, L4),
	                 			append(X, [M | _], L4), !,
			 					length(X, D),
	                 			0 is D mod 2
	             		   )
		           ).

list(L, N) :-	do_list(N, [], Z),
	     		do_list(N, [], Y),
	     		append(Y, Z, T),
	     		permutation(T, L),
	     		is_good(L).

/*
 * Predykat pomocniczy zwraca MAX(A,B)
 */
max(A, B, B) :- B >= A, !.
max(A, _, A).

/*
 * Maksymalna suma podciagu
 */
max_sum(List, S) :- max_sum(List, S, 0, 0).

/*
 * Maksymalna suma podciagu z rekursja ogonowa
 */
max_sum([], S, _, S).
max_sum([H | T], S, SACC, MAXS) :-  (SACC >= 0 -> NSACC is H + SACC; NSACC is H),
                                    max(NSACC, MAXS, MAX),
	                                max_sum(T, S, NSACC, MAX).

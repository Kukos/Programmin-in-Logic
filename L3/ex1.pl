/*
 * Suma za pomoca rekursji ogonowej
 */
sum(L, X) :- sum(L, X, 0).
sum([], ACC, ACC).
sum([H | T], X, ACC) :- NACC is ACC + H,
						sum(T, X, NACC).

/*
 * Pomocniczy predykat liczacy naraz sume i dlugosc listy
 * za pomoca rekursji ogonowej
 */
sum_and_length(List, S ,L) :- sum_and_length(List, S, 0, L, 0).

sum_and_length([], S, S, L, L).
sum_and_length([H | T], S, SACC, L, LACC) :- 	NSACC is SACC + H,
			               						NLACC is LACC + 1,
				       							sum_and_length(T, S, NSACC, L, NLACC).

/*
 * Predykat pomocniczy liczacy srednia arytmetyczna listy
 */
average(List, X) :- sum_and_length(List, S, L),
                    X is S / L.

/*
 * Predykat liczacy warinacje listy ze wzoru
 * W = 1/n*SUM[( a_i - AVG)^2,{i,0,Length}]
 * za pomoca rekursji ogonowej
 */

variance([],_) :- !, fail.
variance(List, X) :- 	sum_and_length(List, S, L),
	            		AVG is S / L,
	            		variance(List, Temp, AVG),
		    			X is Temp / L.

variance(L, V, AVG) :- variance(L, V, 0, AVG).
variance([], V, V, _).
variance([H | T], V, VACC, AVG) :- 	Temp is H - AVG,
			      					NVACC is Temp * Temp + VACC,
			      					variance(T, V, NVACC, AVG).

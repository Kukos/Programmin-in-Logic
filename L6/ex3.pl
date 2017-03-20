% a^n b^n
f1 --> [].
f1 --> [a], f1, [b].

% a^n b^n c ^n
f2 --> a(N), b(N), c(N).

a(0) --> [].
a(N) --> [a], a(N1), {N is N1 + 1}.

b(0) --> [].
b(N) --> [b], b(N1), {N is N1 + 1}.

c(0) --> [].
c(N) --> [c], c(N1), {N is N1 + 1}.

%generowanie liczb fibonaciego
fib(0, 0).
fib(1, 1).
fib(N, X) :-    M is N - 1,
                fib(M, [1, 0], [X | _]).
fib(N, L, L) :- N =< 0, !.
fib(N, [F2, F1 | T], L) :-  N > 0,
                            F3 is F1 + F2,
                            N1 is N - 1,
                            fib(N1, [F3, F2, F1 | T], L).

%a^n b^fib(n)
f3 --> [].
f3 --> a(N), { fib(N, FIB) }, b(FIB).

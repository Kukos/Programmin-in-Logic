

program([]) --> [].
program([H | PROGRAM]) -->      instruction(H),
                                [sep(';')],
                                program(PROGRAM).

instruction(assign(ID, X)) -->  [id(ID), sep(':=')],
                                expression(X).

instruction(read(ID)) -->       [key(read), id(ID)].

instruction(write(X)) -->       [key(write)], expression(X).

instruction(if(C, P)) -->       [key(if)],
                                condition(C),
                                program(P),
                                [key(fi)].

instruction(if(C, P1, P2)) -->  [key(if)],
                                condition(C),
                                program(P1),
                                [key(else)],
                                program(P2),
                                [key(fi)].

instruction(while(C, P)) -->    [key(while)],
                                condition(C),
                                [key(do)],
                                program(P),
                                [key(od)].


expression(X + Y) -->           component(X),
                                [sep('+')],
                                expression(Y).

expression(X - Y) -->           component(X),
                                [sep('-')],
                                expression(Y).

expression(X) -->               component(X).


component(X * Y) -->            factor(X),
                                [sep('*')],
                                component(Y).

component(X / Y) -->            factor(X),
                                [sep('/')],
                                component(Y).

component((X mod Y)) -->        factor(X),
                                [key(mod)],
                                component(Y).

component(X) -->                factor(X).


factor(id(ID)) -->              [id(ID)].

factor(int(INT)) -->            [int(INT)].

factor((X)) -->                 [sep('(')],
                                expression(X),
                                [sep(')')].

condition((X ; Y)) -->          conjunction(X),
                                [key(or)],
                                condition(Y).

condition(X) -->                conjunction(X).

conjunction((X , Y)) -->        simpleCond(X),
                                [key(and)],
                                conjunction(Y).

conjunction(X) -->              simpleCond(X).

simpleCond(X =:= Y) -->         expression(X),
                                [sep('=')],
                                expression(Y).

simpleCond(X =\= Y) -->         expression(X),
                                [sep('/=')],
                                expression(Y).

simpleCond(X < Y) -->           expression(X),
                                [sep('<')],
                                expression(Y).

simpleCond(X > Y) -->           expression(X),
                                [sep('>')],
                                expression(Y).

simpleCond(X >= Y) -->          expression(X),
                                [sep('>=')],
                                expression(Y).

simpleCond(X =< Y) -->          expression(X),
                                [sep('=<')],
                                expression(Y).

simpleCond((X)) -->             [sep('(')],
                                expression(X),
                                [sep(')')].

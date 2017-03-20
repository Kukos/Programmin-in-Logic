keyWord(read).
keyWord(write).
keyWord(if).
keyWord(then).
keyWord(else).
keyWord(fi).
keyWord(while).
keyWord(do).
keyWord(od).
keyWord(and).
keyWord(or).
keyWord(mod).

separator(';').
separator('+').
separator('-').
separator('*').
separator('/').
separator('(').
separator(')').
separator('<').
separator('>').
separator('=<').
separator('>=').
separator(':=').
separator('=').
separator('/=').

% Sprawdza czy Lista znakow jest zmienna ( same duze litery )
variable(List) :- 	\+ (member(X, List),
  					\+ char_type(X, upper)).

%dodaje do listy L slowo klucz w formacie key(X)
addKeyWord(L, X, L2) :- 	Y = key(X),
	              			append(L, [Y], L2).

%dodaje do listy L separator w formacie sep(X)
addSeparator(L, X, L2) :- 	Y = sep(X),
							append(L, [Y], L2).

%dodaje do listy L inta w formacie  int(X)
addInteger(L, X, L2) :- 	Y = int(X),
		      				append(L, [Y], L2).

%dodaje do listy L zmienna w formacie id(X)
addVariable(L, X, L2) :- 	Y = id(X),
	                   		append(L, [Y], L2).

% sprawdza czy na koncu jest srednik jesli jest dodaje token + srednik,
% jesli nie dodaje tylko token
checkToken(L, end_of_file, L).
checkToken(L, X, L2) :- atom_chars(X, Chars),
	              		last(Chars, Y),
		      			Y = ';' -> (select(Y, Chars, NL), !,
						 			atom_chars(T, NL),
									addToken(L, T, L3),
									addSeparator(L3, Y, L2));
		      			addToken(L, X, L2).

%Dodaje token do listy L
addToken(L, end_of_file, L).
addToken(L, X, L2) :-  	(keyWord(X) -> addKeyWord(L, X, L2);
		        		(separator(X) -> addSeparator(L, X, L2);
			    		(
							(atom_number(X, N),integer(N), N >= 0) -> addInteger(L, N, L2);
			        		((atom_chars(X, Chars),variable(Chars)) -> addVariable(L, X, L2);
				     		L2 = L)
						))).

myRead(X) :- 	get_char(C),
	     		readNext(C, [], X).

readNext(end_of_file, L, L) :- !.
readNext(C1, X, X2) :- 	whiteChar(C1), !,
		      			get_char(C2),
	              		readNext(C2, X, X2).

readNext(C1, L, X) :- 	readWord(C1, C2, '', H), % czytaj wyraz
		    			checkToken(L, H, L2), % dodaj token
		    			readNext(C2, L2, X). %idz dalej


%Odczytaj pojedynczy wyraz odzielony bialym znakiem
readWord(end_of_file, end_of_file, N, N) :- !.
readWord(C, C, N, N) :- whiteChar(C),
	                !.
readWord(C1, C3, N1, N) :- 	atom_concat(N1, C1, N2),
	                   		get_char(C2),
	                   		readWord(C2, C3, N2, N).

whiteChar(' ').
whiteChar('\t').
whiteChar('\n').

scanner(FD,Tokens) :- 	current_input(Input),
	              		set_input(FD),
	              		myRead(Tokens),
		      			set_input(Input).

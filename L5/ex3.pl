
%Idz w dol
traverse(i, [H | T], Stack) :- 	H =.. [_ | [Son | _]],
	                   			append([Son], [H | T], NStack),
			   					Stack = NStack,!.
%Idz do brata na prawo
traverse(n, [H, Parent | T], Stack) :- 	Parent =.. X,
				  						append(_, [H, Brother | _], X),
				  						append([Brother], [Parent | T], NStack),
				  						Stack = NStack, !.
%Idz do brata na lewo
traverse(p, [H, Parent | T], Stack) :- 	Parent =.. X,
				  						append(_, [Brother, H | _], X),
				  						append([Brother], [Parent | T], NStack),
				  						Stack = NStack,!.

%Idz do ojca
traverse(o, [_, Parent | T], Stack) :- 	append([Parent], T, NStack),
	                          			Stack = NStack, !.


%Jesli blad to zostajemy w miejscu
traverse(_, X, X).

%Czytaj akcje od uzytkownika
readAction([]).
readAction([H | T]) :- 	writeq(H),
	             		write('\n'),
		     			write('Podaj komende  '),
		     			read(Command),
		     			traverse(Command, [H | T], Stack),
		     			readAction(Stack).

browse(Term) :- readAction([Term]).

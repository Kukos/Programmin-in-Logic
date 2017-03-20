printHorizontalLine(N) :- N =< 0, !.
printHorizontalLine(N) :- printHorizontalLine2(N), write('+\n').

printHorizontalLine2(N) :-	N =< 0,!.
printHorizontalLine2(N) :- 	write('+-----'),
			  				N1 is N - 1,
			  				printHorizontalLine2(N1).

printBlackBody :- 		write('|:::::').
printBlackBodyQueen :- 	write('|:###:').

printWhiteBody :- 		write('|     ').
printWhiteBodyQueen :- 	write('| ### ').

%Drukuje wiersz zaczynajac od czarnego pola
printRowBlack(N, _) :- N =< 0, !.
printRowBlack(N, QueenPos) :- 	printHorizontalLine(N),
	                     		NPos is N - QueenPos + 1,
		             			printRowBlack2(N,NPos).

printRowBlack2(N, QueenPos) :- 	printRowBlack3(N, QueenPos),
	                      		write('|\n'),
			      				printRowBlack3(N, QueenPos),
		              			write('|\n').

printRowBlack3(N, _) :- N =< 0, !.
printRowBlack3(N, QueenPos) :- 	N =:= 1,
	                     		(QueenPos =:= 1 -> printBlackBodyQueen; printBlackBody), !.

printRowBlack3(N, QueenPos) :- 	(QueenPos = N -> printBlackBodyQueen; printBlackBody),
	                      		(QueenPos is N - 1 -> printWhiteBodyQueen; printWhiteBody),
		              			N1 is N - 2,
		              			printRowBlack3(N1, QueenPos).

%Drukuje wiersz zaczynajac od bialego pola
printRowWhite(N, _) :- N =< 0, !.
printRowWhite(N, QueenPos) :- 	printHorizontalLine(N),
	                     		NPos is N - QueenPos + 1,
	                     		printRowWhite2(N, NPos).

printRowWhite2(N, QueenPos) :- 	printRowWhite3(N, QueenPos),
	                      		write('|\n'),
                              	printRowWhite3(N, QueenPos),
		              			write('|\n').

printRowWhite3(N, _) :- N =< 0, !.
printRowWhite3(N, QueenPos) :- 	N =:= 1,
			      				(QueenPos =:= 1 -> printWhiteBodyQueen;printWhiteBody),!.

printRowWhite3(N, QueenPos) :- 	(QueenPos = N -> printWhiteBodyQueen; printWhiteBody),
	                      		(QueenPos is N - 1 -> printBlackBodyQueen; printBlackBody),
		              			N1 is N - 2,
		              			printRowWhite3(N1, QueenPos).

%drukuje szachownice
board([]) :- !,fail.
board(L) :- length(L, N),
	    	reverse(L, NL),
	    	(0 is N mod 2 -> printBoard2(NL, N); printBoard(NL, N)),
	    	printHorizontalLine(N).

printBoard([],_) :- !.
printBoard([X], N) :- printRowBlack(N, X),!.

printBoard([X, Y | T], N) :-  	printRowBlack(N, X),
			  					printRowWhite(N, Y),
			  					printBoard(T, N).

printBoard2([], _) :- !.
printBoard2([X, Y | T], N) :-  	printRowWhite(N, X),
			   					printRowBlack(N, Y),
			   					printBoard2(T, N).

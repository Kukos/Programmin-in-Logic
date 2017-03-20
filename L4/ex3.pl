% RYSOWANIE NA EKRANIE ZAPALEK

%draw(13,_,_) :- write('KONIEC\n').

draw(X,Y,Zap3) :- % POZIOMA LINIA W ZALEZNOSCI OD ILOSCI ZAPALEK W LINII
	               write('+'),
	               (member(X,Zap3) -> write(' - - - ') ; write('\t')),
		       X2 is X+1,
		       write('+'),
		       (member(X2,Zap3) -> write(' - - - ') ; write('\t')),
	               X3 is X2+1,
	               write('+'),
		      (member(X3, Zap3) -> write(' - - - ') ; write('\t')),
	               write('+\n'),
		       %LINIA PIONOWA ( DRUKUJ JESLI JESTES WCZESNIEJ NIZ POCZATEK OST LINIJKI
	              ( Y<110 ->( % IF THEN
		      (member(Y,Zap3) -> write('|') ; write('   ')),
		      write('\t'),
		      Y2 is Y+1,
		      (member(Y2,Zap3) -> write('|') ; write('   ')),
		      Y3 is Y2+1,
		      write('\t'),
		      (member(Y3,Zap3) -> write('|') ; write('   ')),
		      write('\t'),
		      Y4 is Y3+1,
		      (member(Y4,Zap3) -> write('|') ; write('   ')),
		      write('\n'),
	              X4 is X3+1,
	              Y5 is Y4+1,
	              draw(X4, Y5, Zap3));
		      %ELSE
		      write('\n\n'),true
		      % ENDIF
		      ).

draw(X) :- draw(1,101,X).

% DEFINICJA KWADRATOW

%Mozemy stworzyc tylko 1 taki kwadrat wiec
bigSquare([1,2,3,10,11,12,101,104,105,108,109,112]).

% N - Numer wierzcholka w ktorym zaczynamy dostepne: 1 2,4,5
% Edges - Lista krawedzi tego kdawratu
mediumSquare(N,_) :-  \+ (N =:= 1; N =:= 2; N =:=4; N =:=5),!,fail.
mediumSquare(N,Edges) :-  E1 is N,
	                  E2 is N + 1,
	                  E3 is N + 6,
			  E4 is N + 7,
			  % Trzeba obliczyc przesuniecie krawedzi
			  % jest rowne floor(N / 3)
			  Offset is floor(N / 3),
			  E5 is 100 + N + Offset,
			  E6 is 102 + N + Offset,
			  E7 is 104 + N + Offset,
			  E8 is 106 + N + Offset,
			  Edges = [E1,E2,E3,E4,E5,E6,E7,E8].

% N numer wierzcholka w ktorym zaczynamy dostepne: 1 2 3 4 5 6 7 8 9
% Edges - Lista krawedzi tego kwadratu
smallSquare(N,_) :- (N < 1; N > 9),!,fail.
smallSquare(N,Edges) :- E1 is N,
			E2 is N + 3,
			%Trzeba obliczyc przesuniecie krawedzi
			%jest rowne floor((N - 1) / 3)
			Offset is floor((N - 1) / 3),
			E3 is N + 100 + Offset,
			E4 is N + 101 + Offset,
			Edges = [E1,E2,E3,E4].


%predykaty pomocnicze
mySubset([],[]).
mySubset([H|T],[H|NT]) :- mySubset(T,NT).
mySubset([_|T],NT) :- mySubset(T,NT).

% Sklada wszystkie mozliwe krawedzie tak aby powstaly srednie kwadraty o
% wierzcholkach ze zbioru V
generateMediumSquareEdges([],E,E).
generateMediumSquareEdges([H|T],E,NE) :-  mediumSquare(H,Edges),
	                                  union(E,Edges,NEdges),
					  generateMediumSquareEdges(T,NEdges,NE).

generateSmallSquareEdges([],E,E).
generateSmallSquareEdges([H|T],E,NE) :- smallSquare(H,Edges),
					union(E,Edges,NEdges),
					generateSmallSquareEdges(T,NEdges,NE).
% Generowanie kwadratow
% N - ilosc kwadratow, Edges dotychszasowy zbior krawedzi, NEdges nowy
% bedziemy uzywali union na zbiorach Edges i NEdges aby zapalki sie nie% powtarzaly
generateMediumSquares(N,Edges,NEdges) :- mySubset([1,2,4,5],V),
	                                 length(V,N),
					 generateMediumSquareEdges(V,[],E),
					 union(Edges,E,NEdges).

generateSmallSquares(N,Edges,NEdges) :- mySubset([1,2,3,4,5,6,7,8,9],V),
					length(V,N),
					generateSmallSquareEdges(V,[],E),
					union(Edges,E,NEdges).

%Jesli N == 1 to generuj, else zostaw zbior krawedzi bez zmian
generateBigSquare(N,E,NE):- N =:= 1->( bigSquare(Edges),
	                               union(E,Edges,NE));
				       NE = E.

%Predykaty sprawdzajace poprawnosc rozwiazanie
%moze sie zdarzyc tak ze np 4 male kwadraty zrobia mi kwadrat sredni
%takie rozwiazanie trzeba odsiac ze zbioru poprawnych rozwiazan


countSmallSquares(V,E,N) :- countSmallSquares(V,E,0,N).
countSmallSquares([],_,N,N).
countSmallSquares([H|T],E,ACC,N) :- smallSquare(H,Edges),
	                            (subset(Edges,E) -> C is ACC + 1; C = ACC),
				    countSmallSquares(T,E,C,N).

countMediumSquares(V,E,N) :- countMediumSquares(V,E,0,N).
countMediumSquares([],_,N,N).
countMediumSquares([H|T],E,ACC,N) :- mediumSquare(H,Edges),
	                             ( subset(Edges,E) -> C is ACC + 1; C = ACC	),
				      countMediumSquares(T,E,C,N).

countBigSquares(E,N) :- bigSquare(X),
			(subset(X,E) -> N = 1; N = 0).

% Wszystkie mozliwe kombinacje sprawdzen
checkSquares(S,M,B,Edges) :- countSmallSquares([1,2,3,4,5,6,7,8,9],Edges,CS),
			     CS =:= S,
			     countMediumSquares([1,2,4,5],Edges,CM),
			     CM =:= M,
			     countBigSquares(Edges,CB),
			     CB =:= B.

checkSquares2(S,M,Edges) :-  countSmallSquares([1,2,3,4,5,6,7,8,9],Edges,CS),
			     CS =:= S,
			     countMediumSquares([1,2,4,5],Edges,CM),
			     CM =:= M.

checkSquares3(S,B,Edges) :-  countSmallSquares([1,2,3,4,5,6,7,8,9],Edges,CS),
			     CS =:= S,
			     countBigSquares(Edges,CB),
			     CB =:= B.

checkSquares4(M,B,Edges) :-   countMediumSquares([1,2,4,5],Edges,CM),
			     CM =:= M,
			     countBigSquares(Edges,CB),
			     CB =:= B.


%Sprawdza czy uzylismy dobra ilosc zapalek
% czyli od wszystkich odejmujemy te ktore uzylissmy, i mamy te ktore
% powinnismy zabrac
checkMatches(N,Matches) :- AllMatches = [1,2,3,4,5,6,7,8,9,10,11,12,
					 101,102,103,104,105,106,107,108,109,110,111,112],
                           subtract(AllMatches,Matches,NMatches),
			   length(NMatches,N).


%Wszystkie mozliwe kombinacje termu kwadraty
matches(N,(big(B),medium(M),small(S))) :- generateBigSquare(B,[],E),
				          generateMediumSquares(M,E,NE),
					  generateSmallSquares(S,NE,NNE),
					  checkMatches(N,NNE),
					  checkSquares(S,M,B,NNE),
					  draw(NNE).


matches(N,(medium(M),small(S))) :-        generateMediumSquares(M,[],E),
					  generateSmallSquares(S,E,NNE),
					  checkMatches(N,NNE),
					  checkSquares2(S,M,NNE),
					  draw(NNE).


matches(N,(big(B),small(S))) :-           generateBigSquare(B,[],NE),
					  generateSmallSquares(S,NE,NNE),
					  checkMatches(N,NNE),
					  checkSquares3(S,B,NNE),
					  draw(NNE).

matches(N,(big(B),medium(M))) :-          generateBigSquare(B,[],E),
				          generateMediumSquares(M,E,NNE),
					  checkMatches(N,NNE),
					  checkSquares4(M,B,NNE),
				          draw(NNE).

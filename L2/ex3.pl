e(a, b).
e(b, a).
e(b, c).
e(c, d).

% Predykat pomocniczy z dodatkowym parametrem Listy ktora zapamietuje
% droge
is_path(X, Y) :- path(X, Y, []).

%Istnieje droga z X do X
path(X, X, _).
% Istnieje droga z X do Y jesli mamy taka krawedz ( Lista jest nie wazna
% )
path(X, Y, _) :- e(X, Y).
%Proste wywolanie rekurencyjne z sprawdzaniem czy nie weszlismy	2 razy w
%ten sam wierzcholem ( dzieki temu nie mamy cykli )
path(X,Y,Path) :- 	e(X, Z),
		  			\+ member(Z, Path),
		  			path(Z, Y, [X | Path]).

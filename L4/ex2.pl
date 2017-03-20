%Lista Domow kazdy dom to lista zawierajaca informacje o nim
%Kolor,Kto mieszka,Co hoduje,Co sie pije,Co sie pali

left(X, Y, List) :- append(_, [X, Y | _], List).
neighbour(X, Y, List) :-    left(X, Y, List);
                            left(Y, X, List).

solve(X) :-
	       length(Houses, 5),
	       Houses = [[_, norweg, _, _, _] | _], % norweg mieszka w 1 ( liczy sie pozycja)
	       member([czerwony, anglik, _, _, _], Houses), % anglik mieszka w czerwonym
           left([zielony, _, _, _, _], [bialy, _, _, _, _], Houses), %zielony jest po po lewej od bialego
	       member([_, dunczyk, _, herbata, _], Houses), % dunczyk pije herbate
	       neighbour([_, _, _, _, light], [_, _, koty, _, _], Houses), % palacz light ma sasiada hodowce kotow
	       member([zolty, _, _, _, cygara], Houses), % w zoltym pali sie cygara
	       member([_, niemiec, _, _, fajka], Houses), % niemiec pali fajke
	       Houses = [_, _, [_, _, _, mleko, _], _, _], % w srodkowym pije sie mleko ( liczy sie pozycja )
	       neighbour([_, _, _, _, light], [_, _, _, woda, _], Houses), % palacz light ma sasiada pijacego wode
	       member([_, _, ptaki, _, bezFiltra], Houses), %palacz papierosow bez filtra hoduje ptaki
	       member([_, szwed, psy, _, _], Houses), % szwed hoduje psy
	       neighbour([_, norweg, _, _, _], [niebieski, _, _, _, _], Houses), % norweg mieszka obok niebieskiego
	       neighbour([_, _, konie, _, _], [zolty, _, _, _, _], Houses), % hodowca koni mieszka obok zoltego
	       member([_, _, _, mentolowe, piwo], Houses), %palacz mentolowych pije piwo
	       member([zielony, _, _, kawa, _], Houses), % w zielonym pije sie kawe
	       member([_, X, rybki, _, _], Houses). %ktos hoduje rybki

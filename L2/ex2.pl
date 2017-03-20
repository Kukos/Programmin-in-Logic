/*
 * Wyjmuje 1 element z listy, wiec TempList = List \ {X}
 * Wiec X byl tylko raz jesli nie znajde go w TempLiscie
 */
once(List,X) :- select(X, List, TempList),
	        	\+ member(X, TempList).

/*
  Wyjmuje 1 element z listy wiec TempList = List \ {X}
  Teraz chce aby X nalezal do TempList ( oznacza ze jest conajmniej 2razy)
  Wiec dokladam warunek ze kolejny raz ten sam predykat juz sie nie
  spelni, dzieki temu wiemy ze X jest DOKLADNIE 2 razy
*/
twice(List,X) :- 	select(X, List, TempList),
		 			member(X, TempList),
		 			once(TempList, X).


/*
 Obcinamy pierwszy i ostatni element, reszte listy zapisujemy w
 TempList, jesli zostanie 1 element zwroci go, jesli zostanie 0 to
 zwroci false
*/
middle([X], X).
middle(List, X) :-  append([_ | TempList], [_], List),
                    middle(TempList, X).

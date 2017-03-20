on(bicycle, pencil).
on(camera, butterfly).
left(pencil, hourglass).
left(hourglass, butterfly).
left(butterfly, fish).
/*left(bicycyle, camera).*/

left_of(X, Y) :- left(X, Y).

left_of(X, Y) :- left(X, Z),
	        	 left_of(Z, Y).

above(X, Y) :- on(X, Y).

above(X, Y) :- on(X, Z),
	      	   above(Z, Y).

right_of(X, Y) :- left_of(Y, X).

below(X, Y) :- above(Y, X).

/* X wyzej Y jesli X jest nad Y lub X jest obok Z i Z jest nad Y lub to Y jest obok W ze W jest pod X*/
higher(X, Y) :- 	above(X, Y);
                	(
		    			(
		      				left_of(X, Z);
		      				right_of(X, Z)
	             		),
		     			above(Z, Y)
	       			);
	       			(
		   				(
		      				left_of(Y, W);
		      				right_of(Y, W)
	            		),
		    			below(W, X)
	       			).

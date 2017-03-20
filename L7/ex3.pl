writing(ID, STRING) :- 	mutex_lock(mwriting),
	              		writeID(ID),
	              		write(STRING),
		      			mutex_unlock(mwriting),
		      			sleep(1).

writeID(ID) :- 			write('['),
	       				write(ID),
	       				write(']').

thinking(ID) :- 		writing(ID, 'Mysli\n'),
						sleep(2).


eating(ID) :- 			writing(ID, 'Je\n'),
	      				sleep(1).

pickUpFork(ID, Fork, S) :- 	atom_concat('fork', Fork, M),
	                 		mutex_lock(M),
			 				(S =:= 1 -> writing(ID, 'Podniosl prawy widelec\n'); writing(ID, 'Podniosl lewy widelec\n')).

putFork(ID,Fork,S) :- 		atom_concat('fork', Fork, M),
	              			mutex_unlock(M),
							(S =:= 1 -> writing(ID, 'Odlozyl prawy widelec\n'); writing(ID,'Odlozyl lewy widelec\n')).



life(ID) :- 	thinking(ID),
	    		(ID < 5 ->
	            	(
						First is ID,
		     			Second is ID + 1,
		     			writing(ID, 'Chce prawy widelec\n'),
		     			pickUpFork(ID, First, 1),
		     			writing(ID, 'Chce lewy widelec\n'),
				    	pickUpFork(ID, Second, 0),
		     			eating(ID),
		     			putFork(ID, Second, 0),
		     			putFork(ID,First,1)
					);
	                (
						First = 1,
			 			Second = 5,
			 			writing(ID, 'Chce lewy widelec\n'),
			 			pickUpFork(ID, First, 0),
			 			writing(ID, 'Chce prawy widelec\n'),
			 			pickUpFork(ID, Second, 1),
			 			eating(ID),
			 			putFork(ID, Second, 1),
			 			putFork(ID, First, 0)
					)
				),
	    		life(ID).

philosophers :-	thread_create(life(1), ID1, []),
		 		thread_create(life(2), ID2, []),
		 		thread_create(life(3), ID3, []),
		 		thread_create(life(4), ID4, []),
		 		thread_create(life(5), ID5, []),
                thread_join(ID1, _),
		 		thread_join(ID2, _),
		 		thread_join(ID3, _),
		 		thread_join(ID4, _),
		 		thread_join(ID5, _).

block(b1).
block(b2).
block(b3).
block(b4).

on(b1, b2).
on(b2, b3).
on(b3, b4).

above(Block1, Block2) :- on(Block1, Block2).
above(Block1, Block2) :- on(Block1, Block3),
	                	 above(Block3, Block2).

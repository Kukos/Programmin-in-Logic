:- consult('scanner.pl').
:- consult('parser.pl').
:- consult('interpreter.pl').

execute(X) :- 	open(X, read, FD),
	      		scanner(FD, Tokens),
	      		close(FD),
	      		phrase(program(Instructions), Tokens),
	      		interpreter(Instructions).

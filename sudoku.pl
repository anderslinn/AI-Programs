/* 
 *	Authors: Anders Linn and Thaer Khawaja
 * 
 *	A sudoku puzzle solver. Takes a 9x9 list of lists
 *	with missing elements and fills them in to form a 
 *	legal sudoku board, if such a solution exists.
 */

%%%
% Tests 
%%% 
 
/* 	This runs a battery of simple tests. If it 
 *	works correctly, you should see three identical 
 *	and completed sudoku tables, and finally the 
 *	word false (as test0d will fail). 
 */
test :-
	test0, nl,
	test0a, nl,
	test0b, nl,
	test0c, nl,
	test0d.

/* This is a completly solved solution. */
test0 :-
	L = [
             [9,6,3,1,7,4,2,5,8],
             [1,7,8,3,2,5,6,4,9],
             [2,5,4,6,8,9,7,3,1],
             [8,2,1,4,3,7,5,9,6],
             [4,9,6,8,5,2,3,1,7],
             [7,3,5,9,6,1,8,2,4],
             [5,8,9,7,1,3,4,6,2],
             [3,1,7,2,4,6,9,8,5],
             [6,4,2,5,9,8,1,7,3]],
        sudoku(L),
        printsudoku(L).

/* This has a solution (the one in test0).*/
test0a :-
	L = [
             [9,_,3,1,7,4,2,5,8],
             [_,7,_,3,2,5,6,4,9],
             [2,5,4,6,8,9,7,3,1],
             [8,2,1,4,3,7,5,_,6],
						 [4,9,6,8,5,2,3,1,7],
             [7,3,_,9,6,1,8,2,4],
             [5,8,9,7,1,3,4,6,2],
             [3,1,7,2,4,6,9,8,5],
             [6,4,2,5,9,8,1,7,3]],
        sudoku(L),
        printsudoku(L).

/* Slightly more challenging. */
test0b :-
	L = [
             [9,_,3,1,7,4,2,5,_],
             [_,7,_,3,2,5,6,4,9],
             [2,5,4,6,_,9,_,3,1],
             [_,2,1,4,3,_,5,_,6],
             [4,9,_,8,_,2,3,1,_],
             [_,3,_,9,6,_,8,2,_],
             [5,8,9,7,1,3,4,6,2],
             [_,1,7,2,_,6,_,8,5],
             [6,4,2,5,9,8,1,7,3]],
        sudoku(L),
        printsudoku(L).

/* Slightly more challenging. */
test0c :-
	L = [
             [9,_,3,1,_,4,2,5,_],
             [_,7,_,3,2,5,6,4,9],
             [2,5,4,6,_,9,_,3,1],
             [_,2,1,4,3,_,5,_,6],
             [4,9,_,8,_,2,3,1,_],
             [_,3,_,9,6,_,8,2,_],
             [5,8,9,7,1,3,4,6,2],
             [_,1,7,2,_,6,_,8,5],
             [6,4,2,5,_,8,1,7,3]],
        sudoku(L),
        printsudoku(L).				
				
/* 	This one obviously has no solution (column 2 has 
 *	two nines in it).
 */
test0d :-
	L = [
             [_,9,3,1,7,4,2,5,8],
             [_,7,_,3,2,5,6,4,9],
             [2,5,4,6,8,9,7,3,1],
             [8,2,1,4,3,7,5,_,6],
						 [4,9,6,8,5,2,3,1,7],
             [7,3,_,9,6,1,8,2,4],
             [5,8,9,7,1,3,4,6,2],
             [3,1,7,2,4,6,9,8,5],
             [6,4,2,5,9,8,1,7,3]],
        sudoku(L),
        printsudoku(L).




/* 	The next 3 tests are supposed to be progressively 
 *	harder to solve. 
 */
test1 :-
	L = [
             [_,6,_,1,_,4,_,5,_],
             [_,_,8,3,_,5,6,_,_],
             [2,_,_,_,_,_,_,_,1],
             [8,_,_,4,_,7,_,_,6],
						 [_,_,6,_,_,_,3,_,_],
             [7,_,_,9,_,1,_,_,4],
             [5,_,_,_,_,_,_,_,2],
             [_,_,7,2,_,6,9,_,_],
             [_,4,_,5,_,8,_,7,_]],
        sudoku(L),
        printsudoku(L).

test2 :-
	L = [
             [_,_,4,_,_,3,_,7,_],
             [_,8,_,_,7,_,_,_,_],
             [_,7,_,_,_,8,2,_,5],
             [4,_,_,_,_,_,3,1,_],
						 [9,_,_,_,_,_,_,_,8],
             [_,1,5,_,_,_,_,_,4],
             [1,_,6,9,_,_,_,3,_],
             [_,_,_,_,2,_,_,6,_],
             [_,2,_,4,_,_,5,_,_]],
        sudoku(L),
        printsudoku(L).

test3 :-
	L = [
             [_,4,3,_,8,_,2,5,_],
						 [6,_,_,_,_,_,_,_,_],
             [_,_,_,_,_,1,_,9,4],
             [9,_,_,_,_,4,_,7,_],
             [_,_,_,6,_,8,_,_,_],
             [_,1,_,2,_,_,_,_,3],
             [8,2,_,5,_,_,_,_,_],
             [_,_,_,_,_,_,_,_,5],
             [_,3,4,_,9,_,7,1,_]],
        sudoku(L),
        printsudoku(L).

/* A helper method to print the table. */
printsudoku([]).
printsudoku([H|T]) :- write(H),nl,printsudoku(T).


/*	sudoku(Puzzle)
 * 	A simple wrapper for the search algorithm. Expects a list of lists 9x9 grid.
 */
sudoku(L) :- heuristic_search(L).

%%%
% SEARCH
%%%

/*	heuristic_search(Puzzle)
 * 	Solves a puzzle by domain restriction if it can. If not, it chooses a two-value domain, picks a value for it,
 * 	and tries recursivily to solve the puzzle with the new value. If no solution can be found, it eventually backtracks
 * 	to the decision point and picks the other value. If no solution can be found for that choice either, it backs up
 * 	another level and tries again. If no solution is found for either choice at the top level, no solution exists.
 */ 
heuristic_search(L):- restrict_domains(L),
											find_pair_dom(X,D),
											smart_search(L,X,D,[]),!.
heuristic_search(L):- restrict_domains(L),
											not(find_pair_dom(_,_)),
											brute_force(L),!.

/*	brute_force(Puzzle)
 * 	Solves a puzzle through brute-force DFS, if possible. 
 */
brute_force(L):- domain(X),
								 are_valid_rows(L,X),
								 are_valid_columns(L,X),
								 are_valid_squares(L,X).

/*	smart_search(Puzzle,GridLocation,DomainValues,PreviousMoves)
 * 	Performs the probing and backtracking function of the heuristic search. 
 */
% case 1: All domains legally reduced to singletons. Puzzle is solved!
smart_search(L,_,_,_):- domain(X),
												is_solved(X),!,
												brute_force(L).

% case 2: D1 was the correct value for Y
smart_search(L,Y,[D1,_],Z):- find_pair_dom(A,B),
														 retractall(dom(Y,_)),
														 assert(dom(Y,[D1])),
														 domain(X),
														 restrict_dom(X),
														 smart_search(L,A,B,[[Y,D1]|Z]),!.	
	
% case 3: D2 was the correct value for Y 						
smart_search(L,Y,[_,D2],Z):- restrict_domains(L),
														 reverse(Z,RZ),
														 assert_all(RZ),
														 find_pair_dom(A,B),
														 retractall(dom(Y,_)),
														 assert(dom(Y,[D2])),
														 domain(X),
														 restrict_dom(X),
														 smart_search(L,A,B,[[Y,D2]|Z]),!.	

% case 4: No pairs left, D1 was the correct value for Y														
smart_search(L,Y,[D1,_],_):- not(find_pair_dom(_,_)),
														 retractall(dom(Y,_)),
														 assert(dom(Y,[D1])),
														 domain(X),
														 restrict_dom(X),
														 brute_force(L),!.

% case 5: No pairs left, D2 was the correct value for Y
smart_search(L,Y,[_,D2],Z):- restrict_domains(L),
														 reverse(Z,RZ),
														 assert_all(RZ),
														 not(find_pair_dom(_,_)),
														 retractall(dom(Y,_)),
														 assert(dom(Y,[D2])),
														 domain(X),
														 restrict_dom(X),
														 brute_force(L),!.

%%%
% DOMAIN
%%%

/*	Represents the known domain of a grid location. Usage is dom(GridLocation,ListOfPossibleValues).
 *	Entries of the form dom(GridLocation,[]) represent illegal solutions (solutions that violate
 *	constraints).
 */
:- dynamic dom/2.

/*
 * Represents each grid location uniquely. To retrieve this matrix, call domain(X), where X is an
 * unbound variable. X will be bound to this board afterwards, which can be traversed as if it were
 * a normal sudoku board.
 */
domain([[aa,ab,ac,ad,ae,af,ag,ah,ai],
		   [ba,bb,bc,bd,be,bf,bg,bh,bi],
	 	   [ca,cb,cc,cd,ce,cf,cg,ch,ci],
		   [da,db,dc,dd,de,df,dg,dh,di],
		   [ea,eb,ec,ed,ee,ef,eg,eh,ei],
		   [fa,fb,fc,fd,fe,ff,fg,fh,fi],
		   [ga,gb,gc,gd,ge,gf,gg,gh,gi],
		   [ha,hb,hc,hd,he,hf,hg,hh,hi],
		   [ia,ib,ic,id,ie,if,ig,ih,ii]]).

/* 	in_dom(GridLocation,Value)
 *	True if variable Y is in the domain of grid location X.
 */
in_dom(X,Y) :- dom(X,Z),member(Y,Z).

/* are_in_dom(GridLocations,Values)
 * True if all of the variables in List2 are in the domain of their corresponding 
 * grid location in List1.
 */
are_in_dom([],[]).
are_in_dom([X|Xs],[Y|Ys]) :- in_dom(Y,X),are_in_dom(Xs,Ys).

%%%
% DOMAIN INITIALIZATION
%%%

/* start(Domain,Puzzle)
 * Populates the domains of the grid locations.
 */
start([],[]).
start([X|Xs],[Y|Ys]) :- init_dom(X,Y),start(Xs,Ys).

/* init_dom(DomainRow,PuzzleRow)
 * Assigns domains to a row of grid locations. If the corresponding cell in the puzzle
 * to be solved has a value, the domain is set to the singleton list holding that value.
 * Otherwise, the domain is initialized to numbers 1-9, which are all of the legal values
 * grid locations can take.
 */
init_dom([],[]).
init_dom([X|Xs],[Y|Ys]) :- nonvar(Y),
													 assert(dom(X,[Y])),
													 init_dom(Xs,Ys).
init_dom([X|Xs],[Y|Ys]) :- var(Y),
													 assert(dom(X,[1,2,3,4,5,6,7,8,9])),
													 init_dom(Xs,Ys).

%%%
% DOMAIN RESTRICTTION
%%%

/* restrict_domains(Puzzle)
 * Resets the domains of a puzzle and performs several iterations of domain restriction afterwards. This is enough
 * to solve easy to medium difficulty puzzles outright. For hard puzzles, this function is used recursivily to 
 * backtrack along the decision path.
 */
restrict_domains(L):-restart(L),
										 domain(X),
										 restrict_dom(X),!,
										 restrict_dom(X),!,
										 restrict_dom(X),!,
										 restrict_dom(X),!,
										 restrict_dom(X).

/* restrict_dom(Domain)
 * Restricts all of the grid location domains according to the constraints.
 */
restrict_dom(X) :- restrict_all_rows(X),restrict_all_cols(X),restrict_all_sqrs(X).

/* restrict_all_rows(Domain)
 * Separates the domain into rows.
 */
restrict_all_rows([]).
restrict_all_rows([X|Xs]) :- restrict(X),restrict_all_rows(Xs).

/* restrict_all_cols(Domain)
 * Separates the domain into columns.
 */
restrict_all_cols(X) :- invert(X,Y),restrict_all_rows(Y).

/* restrict_all_sqrs(Domain)
 * Separates the domain into 3x9 layers
 */
restrict_all_sqrs(X) :- get_layers(X,Top,Mid,Bot),
												restrict_layers(Top),
												restrict_layers(Mid),
												restrict_layers(Bot).

/* restrict_layers(DomainLayer)
 * Separates a layer of the domain into 3x3 squares
 */
restrict_layers(X) :- get_squares(X,L,M,R),
											restrict(L),
											restrict(M),
											restrict(R).

/* restrict(DomainRow)
 * Applies restriction heuristics. 
 */
restrict(R) :- restrict_rows(R,R),
							 restrict_overlapping_dom(R,R),
							 restrict_shared_dom(R,R).

/* restrict_rows(DomainRow,DomainRow)
 * Applies basic heuristic to the domains of a row of grid locations.
 * RESTRICTION HEURISTIC: no values in the same row can have the same value. 
 */
restrict_rows([],_).
restrict_rows([H|T],R) :- restrict_row(H,R),
													restrict_rows(T,R).

/* restric_row(GridLocation,DomainRow)
 * Removes all known singletons from the domain of a grid location, since it obviously
 * cannot take those values.
 */
restrict_row(_,[]).
restrict_row(X,[X|Xs]) :- restrict_row(X,Xs).
restrict_row(X,[Y|Ys]) :- not(X = Y),
													dom(Y,[Z]),
													remove_from_dom(X,Z),
													restrict_row(X,Ys).
restrict_row(X,[Y|Ys]) :- not(X = Y),
													dom(Y,Z),
													length(Z,N),
													N > 1,
													restrict_row(X,Ys).

/* remove_from_dom(GridLocation,Value)
 * Removes a value from the domain of a grid location.
 */
remove_from_dom(X,Z) :- not(in_dom(X,Z)).
remove_from_dom(X,Z) :- in_dom(X,Z),
												dom(X,D1),
												delete(D1,Z,D2),
												assert(dom(X,D2)),
												retract(dom(X,D1)).

/* restart(Puzzle)
 * Resets the domains of all grid locations to those specified by the given puzzle.
 * Used for initializing the program, as well as used iteratively by the hueristic search to backtrack.
 */
restart(B):- retractall(dom(_,_)),
						 domain(A),
						 start(A,B).

%%%
% INFERENCE
%%%

/* restrict_shared_dom(DomainRow,DomainRow)
 * Applies basic inference heuristic to the domains of a row of grid locations.
 * RESTRICTION HEURISTIC: Any grid location whose domain contains a value which isn't contained in 
 * the domain of any other grid location in the row can have all of its other values removed.
 */
restrict_shared_dom([],_).
restrict_shared_dom([X|Xs],R) :- dom(X,Y),
																 check_shared_dom(X,Y,R),
																 restrict_shared_dom(Xs,R).

/* check_shared_dom(GridLocation,DomainValues,DomainRow)
 * Checks all of the domain values of a grid location to determine if any of them are
 * not contained in any other domain in the row.
 */
check_shared_dom(_,[],_).
check_shared_dom(X,[Y|_],R) :- check_not_in_dom(X,Y,R),
															 retract(dom(X,_)),
															 assert(dom(X,[Y])).
check_shared_dom(X,[Y|Ys],R) :- not(check_not_in_dom(X,Y,R)),
																check_shared_dom(X,Ys,R).

/* check_not_in_dom(GridLocation,DomainValue,DomainRow)
 * Checks the domains of all of the grid locations in a row to determine if any of them contain the
 * given value.
 */
check_not_in_dom(_,_,[]).
check_not_in_dom(X,Y,[Z|Zs]) :- not(X = Z),
																not(in_dom(Z,Y)),
																check_not_in_dom(X,Y,Zs).
check_not_in_dom(X,Y,[Z|Zs]) :- X = Z,
																check_not_in_dom(X,Y,Zs).

/* restrict_overlapping_dom(DomainRow,DomainRow)
 * Applies advanced inference heuristic to the domains of a row of grid locations.
 * RESTRICTION HEURISTIC: Any two grid locations in a given row that have the same two values in their respective domains guarantee those
 * values can be removed from the domains of all other grid locations in the row.
 */
restrict_overlapping_dom([],_).
restrict_overlapping_dom([X|Xs],R) :- dom(X,Y),
																			length(Y,N),
																			N =:= 2,
																			check_pairs(Xs,Y,R),
																			restrict_overlapping_dom(Xs,R).
restrict_overlapping_dom([X|Xs],R) :- dom(X,Y),
																			length(Y,N),
																			N \= 2,
																			restrict_overlapping_dom(Xs,R).

/* check_pairs(DomainRow,DomainValues,DomainRow)
 * Checks a row to see whether any grid location has the given domain.
 */
check_pairs([],_,_).
check_pairs([X|_],[Y1,Y2],R) :- dom(X,[Z1,Z2]),
																Y1 =:= Z1,
																Y2 =:= Z2,
																remove_pair([Y1,Y2],R).
check_pairs([X|Xs],[Y1,Y2],R) :- dom(X,[Z1,Z2]),
																 Y1 \= Z1,
																 Y2 =:= Z2,
																 check_pairs(Xs,[Y1,Y2],R).
check_pairs([X|Xs],[Y1,Y2],R) :- dom(X,[Z1,Z2]),
																 Y1 =:= Z1,
																 Y2 \= Z2,
																 check_pairs(Xs,[Y1,Y2],R).
check_pairs([X|Xs],[Y1,Y2],R) :- dom(X,[Z1,Z2]),
																 Y1 \= Z1,
																 Y2 \= Z2,
																 check_pairs(Xs,[Y1,Y2],R).
check_pairs([X|Xs],Y,R) :- dom(X,Z),
													 length(Z,N),
													 N \= 2,
													 check_pairs(Xs,Y,R).

/* remove_pair(DomainValues,DomainRow)
 * Removes a pair of values from the domains of a row of grid locations.
 */
remove_pair(_,[]).
remove_pair([X1,X2],[Y|Ys]) :- dom(Y,[Z1,Z2]),
															 Z1 =:= X1,
															 Z2 =:= X2,
															 remove_pair([X1,X2],Ys).
remove_pair([X1,X2],[Y|Ys]) :- dom(Y,[Z1,Z2]),
															 Z1 \= X1,
															 Z2 \= X2,
															 remove_pair([X1,X2],Ys).
remove_pair([X1,X2],[Y|Ys]) :- dom(Y,[Z1,Z2]),
															 Z1 \= X1,
															 Z2 =:= X2,
															 remove_from_dom(Y,X2),
															 remove_pair([X1,X2],Ys).
remove_pair([X1,X2],[Y|Ys]) :- dom(Y,[Z1,Z2]),
															 Z1 =:= X1,
															 Z2 \= X2,
															 remove_from_dom(Y,X1),
															 remove_pair([X1,X2],Ys).
remove_pair([X1,X2],[Y|Ys]) :- dom(Y,Z),
															 length(Z,N),
															 N \= 2,
															 remove_from_dom(Y,X1),
															 remove_from_dom(Y,X2),
															 remove_pair([X1,X2],Ys).			

%%%
% VALIDITY
%%%

/* is_valid_row(DomainRow,PuzzleRow)
 * Checks a row of puzzle locations to ensure that thier values are in their corresponding domains,
 * and that the row contains one of every number.
 */
is_valid_row(X,Y):- are_in_dom(X,Y),
										member(1,X),
										member(2,X),
										member(3,X),
										member(4,X),
										member(5,X),
										member(6,X),
										member(7,X),
										member(8,X),
										member(9,X).

/* are_valid_rows(Domain,Puzzle)
 * Checks a puzzle's rows for validity.
 */
are_valid_rows([],[]).
are_valid_rows([X|Xs],[Y|Ys]):- is_valid_row(X,Y),
																are_valid_rows(Xs,Ys).

/* is_valid_layer(PuzzleLayer,DomainLayer)
 * Checks a layer of a puzzle for validity.
 */
is_valid_layer(X,Y):- get_squares(X,XLeft,XMid,XRight),
											get_squares(Y,YLeft,YMid,YRight),
											is_valid_row(XLeft,YLeft),
											is_valid_row(XMid,YMid),
											is_valid_row(XRight,YRight).

/* are_valid_squares(Puzzle,Domain)
 * Checks a puzzle's 3x3 squares for validity.
 */
are_valid_squares(X,Y):- get_layers(X,XTop,XMid,XBottom),
												 get_layers(Y,YTop,YMid,YBottom),
												 is_valid_layer(XTop,YTop),
												 is_valid_layer(XMid,YMid),
												 is_valid_layer(XBottom,YBottom).

/* are_valid_columns(Puzzle,Domain)
 * Checks a puzzle's columns for validity.
 */
are_valid_columns(X,Y):- invert(X,IX),
												 invert(Y,IY),
												 are_valid_rows(IX,IY).

%%%												 
% UTILITIES
%%%

/* get_layers(SudokuBoard,TopLayer,MiddleLayer,BottomLayer)
 * Breaks a sudoku board into 3x9 layers. Works for both domains and puzzles.
 */
get_layers(Board, Top, Mid, Bottom) :- get_layer(Board, Top, MidLayer),
																			 get_layer(MidLayer, Mid, BottomLayer),
																			 get_layer(BottomLayer,Bottom,[]).

/* get_layer(SudokuBoard,Layer,SudokuBoardRemainder)
 * Separates a layer of a sudoku board.
 */
get_layer([H1,H2,H3|T1], [H1,H2,H3], T1).

/* get_squares(SudokuBoardLayer,LeftLayer,MiddleLayer,RightLayer)
 * Separates a layer of a sudoku board into 3x3 squares.
 */
get_squares(Layer, Left, Mid, Right) :- get_square(Layer, Left, MidLayer),
																				get_square(MidLayer, Mid, RightLayer),
																				get_square(RightLayer,Right,_).

/* get_square(SudokuBoardLayer,SudokuBoardSquare,SudokuBoardLayerRemainder)
 * Separates a square of a sudoku board.
 */
get_square([[X1,X2,X3|Xs],[Y1,Y2,Y3|Ys],[Z1,Z2,Z3|Zs]],[X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3],[Xs,Ys,Zs]).

/* invert(SudokuBoard,InvertedSudokuBoard)
 * Converts a sudoku board to its transpose.
 */ 
invert([H1,H2,H3,H4,H5,H6,H7,H8,H9], X) :- invert_helper(H1,H2,H3,H4,H5,H6,H7,H8,H9,X).
invert_helper([],[],[],[],[],[],[],[],[],[]).
invert_helper([H1|T1],[H2|T2],[H3|T3],[H4|T4],[H5|T5],[H6|T6],[H7|T7],[H8|T8],[H9|T9],[[H1,H2,H3,H4,H5,H6,H7,H8,H9]|T10]) :- invert_helper(T1,T2,T3,T4,T5,T6,T7,T8,T9,T10).

/* assert_all(ListOfDomainsAndValues)
 * Wrapper for assert. Used to apply a list of moves after restarting a puzzle.
 */
assert_all([]).
assert_all([[X,Y]|T]) :- assert(dom(X,[Y])),
												 domain(B),
												 restrict_dom(B),
												 assert_all(T).

/* is_solved(Puzzle)
 * True if the domain of every grid location has only one value.
 */
is_solved([]).
is_solved([H|T]):- is_row_solved(H),
									 is_solved(T).

/* is_row_solved
 * True if the domain of each grid location in a row has only one value.
 */
is_row_solved([]).
is_row_solved([H|T]):- dom(H,[_]),
											 is_row_solved(T).

/* find_pair_dom(GridLocation,DomainValues)
 * Finds a single grid location with a two-value domain, if it exists.
 */
find_pair_dom(Y,[D1,D2]) :- domain(X),
														find_all_pair_doms(X,[Y|_]),
														dom(Y,[D1,D2]),!.

/* find_all_pair_doms(Puzzle,PairDomainGridLocations)
 * Finds all the grid locations with two-value domains.
 */
find_all_pair_doms([],[]).
find_all_pair_doms([X|Xs],Z) :- find_row_pair_doms(X,Y),
																append(Y,Ys,Z),
																find_all_pair_doms(Xs,Ys).

/* find_row_pair_doms(PuzzleRow,PairDomainGridLocations)
 * Finds all the grid locations with two-value domains in the given row.
 */
find_row_pair_doms([],[]).
find_row_pair_doms([X|Xs],[X|Ys]) :- dom(X,[_,_]),
																		 find_row_pair_doms(Xs,Ys).
find_row_pair_doms([X|Xs],Y) :- dom(X,Z),
																length(Z,N),
																N \= 2,
																find_row_pair_doms(Xs,Y).

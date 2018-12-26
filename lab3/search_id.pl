% Вдоль доски расположено 7 лунок, в которых лежат 3 черных и 3 белых шара.
% Передвинуть черные шары на место белых, а белые на место черных.
% Шар можно передвинуть в соседнюю с ним пустую лунку, либо в пустую лунку,
% находящуюся непосредственно за ближайшим шаром.
% Пустая лунка изначально находится посередине

move([B1,B2,B3,B4,B5,B6,B7],List):-
	(B1=null,List=[B2,null,B3,B4,B5,B6,B7]);
	(B1=null,List=[B3,B2,null,B4,B5,B6,B7]);

	(B2=null,List=[B1,B3,null,B4,B5,B6,B7]);
	(B2=null,List=[B1,B4,B3,null,B5,B6,B7]);
	(B2=null,List=[null,B1,B3,B4,B5,B6,B7]);
	
	(B3=null,List=[B1,B2,B4,null,B5,B6,B7]);
	(B3=null,List=[B1,null,B2,B4,B5,B6,B7]);
	(B3=null,List=[B1,B2,B5,B4,null,B6,B7]);
	(B3=null,List=[null,B2,B1,B4,B5,B6,B7]);
	
	(B4=null,List=[B1,B2,B3,B5,null,B6,B7]);
	(B4=null,List=[B1,B2,null,B3,B5,B6,B7]);
	(B4=null,List=[B1,null,B3,B2,B5,B6,B7]);
	(B4=null,List=[B1,B2,B3,B6,B5,null,B7]);

	(B5=null,List=[B1,B2,null,B4,B3,B6,B7]);
	(B5=null,List=[B1,B2,B3,null,B4,B6,B7]);
	(B5=null,List=[B1,B2,B3,B4,B6,null,B7]);
	(B5=null,List=[B1,B2,B3,B4,B6,B7,null]);
	
	(B6=null,List=[B1,B2,B3,B4,null,B5,B7]);
	(B6=null,List=[B1,B2,B3,null,B5,B4,B7]);
	(B6=null,List=[B1,B2,B3,B4,B5,B7,null]);
	
	(B7=null,List=[B1,B2,B3,B4,null,B6,B5]);
	(B7=null,List=[B1,B2,B3,B4,B5,null,B6]).
	
prolong([L|List],[Y,L|List]):-
	move(L,Y),
	\+member(Y,List).
	
print_Path([]).
print_Path([L|List]):-
	write(L),nl,
	print_Path(List).
	
natural(1).
natural(X):-
    natural(Y),
    X is Y + 1.

search_id(Beg,End):-
	natural(Depth),
	id([Beg],End,Path,Depth),
	reverse(Path,P),
	print_Path(P),!.

id([B|List],B,[B|List],_).
id([L|List],B,Path,Depth):-
	prolong([L|List],Res),
	length(Res,Len),
	Len<Depth,
	id(Res,B,Path,Depth).
	
	
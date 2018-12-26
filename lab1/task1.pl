% length 
leng([],0):-!.
leng([_|Xs],N):-leng(Xs,M),N is M+1.

% append
app([],Zs,Zs):-!.
app([X|Xs],Ys,[X|Zs]):-
	app(Xs,Ys,Zs).
	
% sublist
prefx([X|Xs],[Y|Ys]):-
	X=Y,
	prefx(Xs,Ys).	
prefx([],_):-!.
sufx(Xs,[_|Ys]):-
	sufx(Xs,Ys).	
sufx(Xs,Xs):-!.
sublst(Xs,Ys):-
	prefx(Ps,Ys),sufx(Xs,Ps),!.
	
% member
memb([X|Xs],X):-!.
memb([_|Xs],X):-
	memb(Xs,X).
	
% remove
remove([],X,[]):-!.
remove([X|Xs],X,Zs):-
	remove(Xs,X,Zs).
remove([X|Xs],Z,[X|Zs]):-
	X\=Z,
	remove(Xs,Z,Zs).	
	
% permute
selct(X,[X|Xs],Xs).
selct(X,[Y|Xs],[Y|Zs]):-selct(X,Xs,Zs).

perm(L,[X|P]):-selct(X,L,L1),perm(L1,P).
perm([],[]).

% сравнение списков
lstcmp([],[]):-!.
lstcmp([L|List1],[L|List2]):-
	lstcmp(List1,List2).
	
lstcmp2(List1,List2):-
	append([],List1,List2).

% удаление первых N элементов
deleteN(List,List,0):-!. % число N = 0 , то мы уже удалили первые символы , поэтому полчаем ответ 
deleteN([_|List],Res,N):-
	N1 is N - 1,
	deleteN(List,Res,N1).
	
deleteN2(List,ResList,N):-
	append(Lis,ResList,List), % ищем Lis - длина которого равна N 
	length(Lis,N),!.
	
% удаляем первые N символов , если списки совпали , иначе выводим сообщение . 
example(List1,List2,List3,N):- 
	(lstcmp(List1,List2),
	deleteN(List1,List3,N),!);
	(write('lists not equal or N is more than length of List1'),nl,!).
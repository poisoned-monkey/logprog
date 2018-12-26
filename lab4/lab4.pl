particle(that).
particle(those).

verb(lives).
verb(loves).

article(a).
article(the).

object(man).
object(woman).
object(sister).
object(brother).

adverb(every).

listOfChar_1(X):-
	member(X,['X','Y']).
	
listOfChar_2(X):-
	member(X,['Z','W']).

getObjects([],[],_,_):-!.	
getObjects([L|List],[Lt|Before],Usedch,What_List):-
	object(L),
	(What_List=1,listOfChar_1(X);
	What_List=2,listOfChar_2(X)),
	\+member(X,Usedch),
	Lt=..[L,X],
	getObjects(List,Before,[X|Usedch],What_List).
	
getObjects([_|List],Before,U,Wl):-
	getObjects(List,Before,U,Wl).		
	
getChars([],[]):-!.	
getChars([L|List],[R|Res]):-
	L=..[_,R],
	getChars(List,Res).
	
ask(Ask):-
	particle(Par),
	verb(Ver1),
	member(Ver1,List),
	verb(Ver2),
	Ver2\=Ver1,
	member(Ver2,List),
	article(Art),
	member(Art,List),
	
	append(Before,_,Ask),
	append(Before,[Par],Tmp),
	append(Tmp,After,Ask),
	getObjects(Before,BeforeObjects,[],1), 
	getObjects(After,AfterObjects,[],2),
	getChars(BeforeObjects,BeforeChars), 
	getChars(AfterObjects,AfterChars),
	adverb(Adv),
	member(Adv,List),

	V1=..[Ver1,BeforeChars],
	V2=..[Ver2,BeforeChars,AfterChars],
	SubAll=..[exist,AfterChars,AfterObjects,V2],
	All=..[Adv,BeforeChars,BeforeObjects,'&',V1,'=>',SubAll],
	write(All),!.
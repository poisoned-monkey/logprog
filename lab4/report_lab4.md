## Отчет по лабораторной работе №4
## по курсу "Логическое программирование"

## Обработка естественного языка

### студент: Захаров И.С.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Язык логического программирования пролог идеально подходит для обработки естественного языка , если мы знаем структуру предложений . Так как с помощью этого мы можем написать алгоритм парсинга предложений . 
Задача грамматического разбора и анализа естественных и искусственных языков является одной из самых распространенных задач, решаемых языками логического программирования. Это связано с простотой и естественностью реализации процесса переборов с возвратами, а также с удобством манипулирования символьной информацией.
На прологе , думаю , можно легко написать генератор каких-то документов или написать текстовый редактор . 

## Задание

Реализовать грамматический разбор фраз на ограниченном естественном языке и преобразовать данные фразы в язык исчисления предикатов первого порядка типа : 
```
test([every,man,that,lives,loves,a,woman],Res).
Res=all(X,man(X),lives(X) => exist(Y,woman(Y),loves(X,Y)))
```

## Принцип решения

Алгорит состоит в следующем :
Сначала проверяем правильную структуру предложения , путем обращения к предикатам , которые задают грамматику . Потом ищем разделительное слово , например - 'that' .
Потом в левой и правой части ищем все объекты . После - получем все значки для этих объектов для записи предложения в виде набора предикатов первого порядка . 

После этого всего группируем данные и получаем ответ .

Листинг программы :
```
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
	getObjects(List,Res).
	
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
```
Тестирование программы :
```
| ?- ask([every,man,and,woman,that,lives,loves,a,brother,and,sister]).
every([X,Y],[man(X),woman(Y)],&,lives([X,Y]),=>,exist([Z,W],[brother(Z),sister(W)],loves([X,Y],[Z,W])))

yes
| ?- ask([every,man,that,lives,loves,a,woman]).
every([X],[man(X)],&,lives([X]),=>,exist([Z],[woman(Z)],loves([X],[Z])))

yes
```

## Выводы

Было трудно написать данную программу . Так как я пытался ее сделать по типу парсера арифметического выражения . Но потом я понял , что данную задачу довольно сложно решить таким способом и я выбрал прямолинейный алгоритм . 

Написание работы еще упростилось тем , что структура предложения довольно проста , я лишь добавил возможность задания нескольких объектов через 'and' , что хоть как-то усложнило программу .

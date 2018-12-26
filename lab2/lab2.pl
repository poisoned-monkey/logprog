% Левин, Митерев и Набатов работают в банке в качестве бухгалтера, 
% кассира и счетовода. Если Набатов кассир, то Митерев счетовод. 
% Если Набатов счетовод, то Митерев бухгалтер. Если Митерев не кассир, 
% то Левин не счетовод. Если Левин бухгалтер, то Набатов счетовод. 
% Кто какую должность занимает?

name('levin').
name('miterev').
name('nabatov').

job('accountant').
job('cashier').
job('bookkeeper').



check('nabatov',X,'miterev',Y,'levin',Z):- % здесь отсечение играет роль предиката 'если , то '
	(X='cashier',!,Y='bookkeeper');
	(X='bookkeeper',!,Y='accountant');
	(Y\='cashier',!,Z\='bookkeeper');
	(Z='accountant',!,X='bookkeeper').
	
main(Result):-
	Result=[[Name1,Job1],[Name2,Job2],[Name3,Job3]],
	name(Name1),
	name(Name2),
	name(Name3),
	
	Name1\=Name2,Name2\=Name3,Name1\=Name3,
	
	job(Job1),
	job(Job2),
	job(Job3),
	
	Job1\=Job2,Job2\=Job3,Job1\=Job3,
	
	check(Name1,Job1,Name2,Job1,Name3,Job3),!.
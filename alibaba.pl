:-dynamic(seenNumbers/1).

%alibaba(+Size)
alibaba(Size):-
	creation(Size,List),
	permutation(List,List2),
	retractall(seenNumbers(_)),
	verifyHead(List2),
	verifyPermutation(List2,1,Size,1,0),
	write(List2).
	
% Check that the head of the list is 1
verifyHead([T|_]):-
	T=1.

% If we have the robbers leader as actual value, we have to check that at least half of the other robbers are free
robbersLeader(Size,ActualNumber,Counter):-
	(ActualNumber =:= 2 ->
	N is Size /2,
	(Counter >= N ->true;fail);true).

% Calculate the next index regarding actual index and the number of the prisonner who sit at this index
nextIndex([T|_],1,T):-!.
nextIndex([_|List],NextIndex,NextNumber):-
	PI is NextIndex-1,
	nextIndex(List,PI,NextNumber).
	
% Check if the permutation leads to a solution or not
verifyPermutation(List,CurrentIndex,Size,ActualNumber,Counter):-
	robbersLeader(Size,ActualNumber,Counter),
	(seenNumbers(ActualNumber)->(Counter=:=Size->true;fail);
	asserta(seenNumbers(ActualNumber)),
	Counter2 is Counter + 1,
	X is ActualNumber + CurrentIndex,
	Y is CurrentIndex - (Size - ActualNumber),
	(X =< Size ->
	nextIndex(List,X,NextNumber),verifyPermutation(List,X,Size,NextNumber,Counter2) ;
	nextIndex(List,Y,NextNumber),verifyPermutation(List,Y,Size,NextNumber,Counter2))).
	
% Create a list with a given length
creation(0,[]).
creation(N,L):-
	N>0,
	M is N-1,
	creation(M,LL),
	L=[N|LL].

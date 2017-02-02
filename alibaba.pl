:-dynamic(nombresRencontres/1).

%alibaba(+Taille)
alibaba(Taille):-
	creation(Taille,Liste),
	permutation(Liste,Liste2),
	retractall(nombresRencontres(_)),
	verifierTete(Liste2),
	verifierPermutation(Liste2,1,Taille,1,0),
	write(Liste2).
	
% Vérifie que la tête de la liste soit bien 1
verifierTete([T|_]):-
	T=1.

% Si on a le chef des voleurs comme valeur actuelle, il faut vérifier qu'au moins la moitié des autres voleurs ont été délivrés
chefVoleurs(Taille,NombreActuel,Compteur):-
	(NombreActuel =:= 2 ->
	N is Taille /2,
	(Compteur >= N ->true;fail);true).
	
% Calcule le prochain indice en fonction de l'indice actuelle et du numéro du prisonnier assis à cet indice
prochainIndice([T|_],1,T):-!.
prochainIndice([_|Liste],ProchainIndice,ProchainNombre):-
	PI is ProchainIndice-1,
	prochainIndice(Liste,PI,ProchainNombre).
	
% Regarde si la permutation effectuée amène à une solution ou non.
verifierPermutation(Liste,IndiceCourant,Taille,NombreActuel,Compteur):-
	chefVoleurs(Taille,NombreActuel,Compteur),
	(nombresRencontres(NombreActuel)->(Compteur=:=Taille->true;fail);
	asserta(nombresRencontres(NombreActuel)),
	Compteur2 is Compteur + 1,
	X is NombreActuel + IndiceCourant,
	Y is IndiceCourant - (Taille - NombreActuel),
	(X =< Taille ->
	prochainIndice(Liste,X,ProchainNombre),verifierPermutation(Liste,X,Taille,ProchainNombre,Compteur2) ;
	prochainIndice(Liste,Y,ProchainNombre),verifierPermutation(Liste,Y,Taille,ProchainNombre,Compteur2))).
	
% Crée une liste à partir de la taille donnée
creation(0,[]).
creation(N,L):-
	N>0,
	M is N-1,
	creation(M,LL),
	L=[N|LL].

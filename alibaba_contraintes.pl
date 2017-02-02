verifierTete([T|LV]):-
	T #= 1.

test([T|LV]):-
	

alibaba(Taille):-
	length(LV,Taille),
	fd_domain(LV,1,Taille),
	fd_all_different(LV),
	verifierTete(LV),
	

progenitor(mona, homero).
progenitor(jaqueline, marge).
progenitor(marge, maggie).
progenitor(marge, bart).
progenitor(marge, lisa).
progenitor(abraham, herbert).
progenitor(abraham, homero).
progenitor(clancy, jaqueline).
progenitor(homero, maggie).
progenitor(homero, bart).
progenitor(homero, lisa).

ancestro(Ancestro, Descendiente):- progenitor(Ancestro, Descendiente).
ancestro(Ancestro,Descendiente):- progenitor(Progenitor, Descendiente),
ancestro(Ancestro, Progenitor).

ultimo([E],E).
ultimo([_|Cola],Ultimo):- ultimo(Cola,Ultimo).

sumatoria([], 0).
sumatoria([Cabeza|Cola], S):- sumatoria(Cola,SCola), S is SCola + Cabeza.

esta(X, [X|_]). 
esta(X, [_|Z]):-esta(X, Z).


encolar(Elem, [], [Elem]).
encolar(Elem, [Cab|Cola], [Cab|Lista]):- encolar(Elem, Cola, Lista).

maximo(Lista, Max):- member(Max, Lista), 
    forall(member(Elem, Lista), Max >= Elem).


maximoRec([Max], Max).
maximoRec([Elem, Otro| Cola], Max):- Elem >= Otro, maximoRec([Elem | Cola], Max).
maximoRec([Elem, Otro | Cola], Max):- Otro > Elem, maximoRec([Otro | Cola], Max).

unirSinRepeticiones([], Lista, Lista).
unirSinRepeticiones([Elem|Cola], OtraLista, Lista):- member(Elem, OtraLista), 
    unirSinRepeticiones(Cola, OtraLista, Lista).
unirSinRepeticiones([Elem|Cola], OtraLista, [Elem|RestoLista]):- not(member(Elem, OtraLista)), 
    unirSinRepeticiones(Cola, OtraLista, RestoLista).




interseccion(Lista1, Lista2, ListaInter):- findall(Elem, estaEn(Elem, Lista1, Lista2), ListaInter).

estaEn(Elem, UnaLista, OtraLista):- member(Elem, UnaLista), member(Elem, OtraLista).

esCreciente([]).
esCreciente([_]).
esCreciente([Cab, OtraCab|Cola]):- Cab < OtraCab, esCreciente([OtraCab|Cola]).

sublistaMayoresA([], _, []).
sublistaMayoresA([Cab|Cola], Elem, [Cab|Lista]):- Cab > Elem,
    	sublistaMayoresA(Cola, Elem, Lista).
sublistaMayoresA([_|Cola], Elem, Lista):-
    	sublistaMayoresA(Cola, Elem, Lista).

reversa([], []).
reversa([Cab|Cola], Reversa):- reversa(Cola, ReversaCola),
    			encolar(Cab, ReversaCola, Reversa).


entretenimiento(cine).
entretenimiento(teatro).
entretenimiento(pool).
entretenimiento(parqueTematico).
costo(cine, 30).
costo(teatro, 40).
costo(pool, 15).
costo(parqueTematico, 50).

entretenimientos(Dinero, Sublista):-conjuntoEntretenimiento(ConjEntretenimientos), 
    sublista(ConjEntretenimientos, Dinero, Sublista).

conjuntoEntretenimiento(Lista):- findall(Entre, entretenimiento(Entre), Lista).

sublista([], _, []).
sublista([Entre|Cola], Dinero, [Entre|Resto]):-costo(Entre, Monto), Monto =< Dinero, 
    DineroRestante is Dinero - Monto, sublista(Cola, DineroRestante, Resto).
sublista([_|Cola], Dinero, Lista):- sublista(Cola, Dinero, Lista).

tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).

%Afirmativo%
Las ubicaciones que existen son las siguientes:
ubicacion(puebloDeLosAngeles).
ubicacion(avellaneda).
ubicacion(barracas).
ubicacion(marDelPlata).
ubicacion(laBoca).
ubicacion(uqbar).

% Punto 1 %
frecuenta(Agente, Ubicacion):- tarea(Agente, _, Ubicacion).
frecuenta(Agente, buenosAires):- agente(Agente).
frecuenta(vega, quilmes).
frecuenta(Agente, marDelPlata):- tarea(Agente, vigilar(Negocios), _), 
    	member(negocioAlfajores, Negocios).

agente(Agente):- tarea(Agente, _, _).

% Punto 2%
inaccesible(Ubicacion):- ubicacion(Ubicacion), 
    not(frecuenta(_, Ubicacion)).

%Punto 3%
afincado(Agente):- tarea(Agente, _, Ubicacion), 
    forall(tarea(Agente, _, OtraUbicacion), esIgual(Ubicacion, OtraUbicacion)).

esIgual(Ubicacion, Ubicacion).
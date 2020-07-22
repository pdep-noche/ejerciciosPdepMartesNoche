tarea(vigilanteDelBarrio, ingerir(pizza, 1.5, 2),laBoca).
tarea(vigilanteDelBarrio, vigilar([pizzeria, heladeria]), barracas).
tarea(canaBoton, asuntosInternos(vigilanteDelBarrio), barracas).
tarea(sargentoGarcia, vigilar([pulperia, haciendaDeLaVega, plaza]),puebloDeLosAngeles).
tarea(sargentoGarcia, ingerir(vino, 0.5, 5),puebloDeLosAngeles).
tarea(sargentoGarcia, apresar(elzorro, 100), puebloDeLosAngeles). 
tarea(vega, apresar(neneCarrizo,50),avellaneda).
tarea(jefeSupremo, vigilar([congreso,casaRosada,tribunales]),laBoca).


%Afirmativo%
%Las ubicaciones que existen son las siguientes:
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

%jefe(jefe, subordinado)
jefe(jefeSupremo,vega ).
jefe(vega, vigilanteDelBarrio).
jefe(vega, canaBoton).
jefe(jefeSupremo,sargentoGarcia).


agente(Agente):- tarea(Agente, _, _).

% Punto 2%
inaccesible(Ubicacion):- ubicacion(Ubicacion), 
    not(frecuenta(_, Ubicacion)).

%Punto 3%
afincado(Agente):- tarea(Agente, _, Ubicacion), 
    forall(tarea(Agente, _, OtraUbicacion), esIgual(Ubicacion, OtraUbicacion)).

esIgual(Ubicacion, Ubicacion).

%Punto 4%
cadenaDeMando([_]).
cadenaDeMando([Jefe, Subor| Resto]):- jefe(Jefe, Subor), cadenaDeMando([Subor|Resto]).

%cadenaDeMando([jefeSupremo, vega, vigilanteDelBarrio]).
%true

%cadenaDeMando([jefeSupremo, vega, sargentoGarcia]).
%false

%Punto 5
agentePremiado(Agente):- totalPuntos(Agente, Puntos), 
    forall(totalPuntos(_, OtrosPuntos), Puntos >= OtrosPuntos).


totalPuntos(Agente, Puntos):- agente(Agente), 
    findall(UnPunto, puntosPorTarea(Agente, UnPunto), ListaPuntos), sumlist(ListaPuntos, Puntos).

puntosPorTarea(Agente, Puntos):-tarea(Agente, Tarea, _), puntos(Tarea, Puntos).

puntos(vigilar(Negocios), Puntos):- length(Negocios, Cantidad), Puntos is Cantidad * 5.
puntos(ingerir(_, Tamanio, Cantidad), Puntos):- unidadesIngeridas(Tamanio, Cantidad, Unidades), Puntos is Unidades * (-10).
puntos(apresar(_, Recompensa), Puntos):- Puntos is Recompensa / 2.
puntos(asuntosInternos(AgenteInvestigado), Puntos):- totalPuntos(AgenteInvestigado, PuntosAgente), Puntos is PuntosAgente * 2.

unidadesIngeridas(Tamanio, Cantidad, Unidades):- Unidades is Tamanio * Cantidad.

%agentePremiado(Agente).
%Agente = sargentoGarcia












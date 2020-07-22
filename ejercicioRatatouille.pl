%viveEn(rata, lugar)
viveEn(remy, gusteaus).
viveEn(emile, chezMilleBar).
viveEn(django, pizzeriaJeSuis).

%sabeCocinar(persona, comida, experiencia)
sabeCocinar(linguini, ratatouille, 3).
sabeCocinar(linguini, sopa, 5).
sabeCocinar(colette, salmonAsado, 9).
sabeCocinar(horst, ensaladaRusa, 8).

%trabajaEn(persona, restaurante)
trabajaEn(linguini, gusteaus).
trabajaEn(colette, gusteaus).
trabajaEn(horst, gusteaus).
trabajaEn(skinner, gusteaus).
trabajaEn(amelie, cafeDes2Moulins).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).
plato(ensadaComun, entrada([zanahoria, huevo])).

%Punto 1
estaEnElMenu(Plato, Restaurante):-sabeCocinar(Cocinero, Plato, _), 
    	trabajaEn(Cocinero, Restaurante).


%Punto 2
cocinaBien(Cocinero, Plato):- sabeCocinar(Cocinero, Plato, Experiencia), Experiencia > 7.
cocinaBien(Cocinero, Plato):- sabeCocinar(Cocinero, Plato, _), tieneTutor(Cocinero, Tutor), 
    						cocinaBien(Tutor, Plato).
cocinaBien(remy, Plato):- platoQueCocina(Plato).

%tieneTutor(cocinero, tutor)
tieneTutor(linguini,Rata):- viveEn(Rata, Lugar), trabajaEn(linguini, Lugar).
tieneTutor(skinner, amelie).

platoQueCocina(Plato):- sabeCocinar(_, Plato, _).

%Punto3
chef(Alguien, Restaurante):- trabajaEn(Alguien, Restaurante), cumpleCondiciones(Alguien, Restaurante).
cumpleCondiciones(Alguien, Restaurante):- forall(estaEnElMenu(Plato, Restaurante), cocinaBien(Alguien, Plato)).
cumpleCondiciones(Alguien, _):- totalExperiencia(Alguien, Total), Total > 20.


totalExperiencia(Alguien, Total):- findall(Experiencia, sabeCocinar(Alguien, _, Experiencia), ListaExperiencias), 
    sumlist(ListaExperiencias, Total).

%Punto4
encargada(Persona, Plato, Restaurante):- experienciaCocinandoPersona(Persona, Plato, Restaurante, Experiencia),
    forall(experienciaCocinandoPersona(_, Plato, Restaurante, OtraExperiencia), Experiencia >= OtraExperiencia).
    
experienciaCocinandoPersona(Persona, Plato, Restaurante, Experiencia):-sabeCocinar(Persona, Plato, Experiencia), 
    trabajaEn(Persona, Restaurante).
    
%Punto 5
esSaludable(Plato):- plato(Plato, TipoPlato), totalCalorias(TipoPlato, Calorias), Calorias < 75.

totalCalorias(entrada(Ingredientes), Calorias):- length(Ingredientes, Cantidad), Calorias is Cantidad * 15.
totalCalorias(principal(Guarnicion, Minutos), Calorias):- calorias(Guarnicion, CaloriasGuarnicion), 
    Calorias is Minutos * 5 + CaloriasGuarnicion.
totalCalorias(postre(Calorias), Calorias).

calorias(papasFritas, 50).
calorias(pure, 20).

realizoReseniaPositiva(Critico, Restaurante):- restaurante(Restaurante), not(viveEn(_, Restaurante)), 
    	criterioCritico(Critico, Restaurante).

criterioCritico(antonEgo , Restaurante):- forall(trabajaEn(Cocinero, Restaurante), cocinaBien(Cocinero, ratatouille)).
criterioCritico(cormillot, Restaurante):- forall(experienciaCocinandoPersona(_, Plato, Restaurante, _), 
                                                 esSaludable(Plato)).
criterioCritico(martiniano, Restaurante):- trabajaEn(Cocinero, Restaurante), 
    not((trabajaEn(OtroCocinero, Restaurante), Cocinero \= OtroCocinero)).

restaurante(Restaurante):- trabajaEn(_, Restaurante).

















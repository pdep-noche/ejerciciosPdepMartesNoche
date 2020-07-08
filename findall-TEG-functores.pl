genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).

gusta(belen,titanic).
gusta(belen,gilbertGrape).
gusta(belen,elProfesional).
gusta(juan, ironMan).
gusta(pedro, atrapameSiPuedes).
gusta(pedro, rapidoYFurioso).

soleLeGustaPeliculaDeGenero(Persona, Genero):- persona(Persona), generoPelicula(Genero), 
    forall(gusta(Persona, Pelicula), genero(Pelicula, Genero)).

persona(Persona):- gusta(Persona, _).
generoPelicula(Genero):- genero(_, Genero).


peliculasQueLeGustaPorGenero(Persona, Genero, Peliculas):- persona(Persona), generoPelicula(Genero), 
    findall(Pelicula, gustaPersonaPeliculaDeGenero(Persona, Genero, Pelicula), Peliculas).

gustaPersonaPeliculaDeGenero(Persona, Genero, Pelicula):- gusta(Persona, Pelicula), 
    genero(Pelicula, Genero).



continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

jugador(amarillo).
jugador(magenta).
jugador(negro).
jugador(blanco).

aliados(X,Y):- alianza(X,Y).
aliados(X,Y):- alianza(Y,X).
alianza(amarillo,magenta).

%el numero son los ejercitos
ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

% Usar este para saber si son limitrofes ya que es una relacion simetrica
sonLimitrofes(X, Y) :- limitrofes(X, Y).
sonLimitrofes(X, Y) :- limitrofes(Y, X).

limitrofes(argentina,brasil).
limitrofes(argentina,chile).
limitrofes(argentina,uruguay).
limitrofes(uruguay,brasil).
limitrofes(alaska,kamtchatka).
limitrofes(alaska,yukon).
limitrofes(canada,yukon).
limitrofes(alaska,oregon).
limitrofes(canada,oregon).
limitrofes(siberia,kamtchatka).
limitrofes(siberia,china).
limitrofes(china,kamtchatka).
limitrofes(japon,china).
limitrofes(japon,kamtchatka).
limitrofes(australia,sumatra).
limitrofes(australia,java).
limitrofes(australia,borneo).
limitrofes(australia,chile).

objetivo(amarillo, ocuparContinente(asia)).
objetivo(amarillo,ocuparPaises(2, americaDelSur)). 
objetivo(blanco, destruirJugador(negro)). 
objetivo(magenta, destruirJugador(blanco)). 
objetivo(negro, ocuparContinente(oceania)).
objetivo(negro,ocuparContinente(americaDelSur)). 

% Relaciona jugador, continente y cantidad de paises.
/* Este predicado NO DEBERIA estar hecho con hechos, deberia deducirse de los anteriores. Pero para hacerlo correctamente todavía no tenemos los conceptos (mas adelante se veran), asi que por ahora los dejamos asi */
cuantosPaisesOcupaEn(amarillo, americaDelSur, 1).
cuantosPaisesOcupaEn(amarillo, americaDelNorte, 4).
cuantosPaisesOcupaEn(amarillo, asia, 3).
cuantosPaisesOcupaEn(amarillo, oceania, 0).
cuantosPaisesOcupaEn(magenta, americaDelSur, 2).
cuantosPaisesOcupaEn(magenta, americaDelNorte, 0).
cuantosPaisesOcupaEn(magenta, asia, 0).
cuantosPaisesOcupaEn(magenta, oceania, 0).
cuantosPaisesOcupaEn(negro, americaDelSur, 1).
cuantosPaisesOcupaEn(negro, americaDelNorte, 0).
cuantosPaisesOcupaEn(negro, asia, 1).
cuantosPaisesOcupaEn(negro, oceania, 4).

loLiquidaron(Jugador):- jugador(Jugador), not(ocupa(_, Jugador, _)).

ocupaContinente(Jugador, Continente):- jugador(Jugador), continente(Continente), 
    forall(estaEn(Continente, Pais), ocupa(Pais, Jugador ,_)).


seAtrinchero(Jugador):- ocupa(_, Jugador, _), continente(Continente), 
   not((ocupa(Pais, Jugador, _), not(estaEn(Continente, Pais)))).

seAtrincheroForall(Jugador):- ocupa(_,Jugador, _), continente(Continente),
	forall(ocupa(Pais, Jugador, _), estaEn(Continente, Pais)).  


cumpleObjetivos(Jugador):- jugador(Jugador),
    forall(objetivo(Jugador, Objetivo), puedeCumplirlo(Jugador, Objetivo)).

puedeCumplirlo(Jugador, ocuparContinente(Continente)):- ocupaContinente(Jugador, Continente).
puedeCumplirlo(Jugador, ocuparPaises(Cantidad, Continente)):- cuantosPaisesOcupaEn(Jugador, Continente, CantidadPaises),
    CantidadPaises >= Cantidad.
puedeCumplirlo(_, destruirJugador(OtroJugador)):- loLiquidaron(OtroJugador).

% equipoGrande/1 -> qué equipo es grande
equipoGrande(deportivoPlanificador).
equipoGrande(defensoresDelFileSystem).
equipoGrande(procesosUnidos).

% jugo/2 -> relaciona un jugador con un equipo
jugo(molina, deportivoPlanificador).
jugo(molina, defensoresDelFileSystem).
jugo(molina, procesosUnidos).
jugo(bertolini, deportivoPlanificador).
jugo(frasoldatti, chacarita).
jugo(frasoldatti, procesosUnidos).
jugo(frasoldatti, flandria).

consagrade(Jugador):- jugo(Jugador, _), 
    forall(jugo(Jugador, Equipo), equipoGrande(Equipo)).

consagradeNot(Jugador):- jugo(Jugador, _), 
    not((jugo(Jugador, Equipo), not(equipoGrande(Equipo)))).
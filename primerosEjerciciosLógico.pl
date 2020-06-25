mortal(Persona):- humano(Persona).
humano(socrates).
humano(platon).

hablaIdioma(juan, español).
hablaIdioma(juan, ingles). 
hablaIdioma(juan, italiano). 
hablaIdioma(marcela, español). 
hablaIdioma(hernan, aleman). 

seComunican(Persona,OtraPersona):-hablaIdioma(Persona,Idioma), hablaIdioma(OtraPersona,Idioma), Persona \= OtraPersona.

viveEn(nora, almagro).
viveEn(luis, caballito).
viveEn(ana, lugano). 
estaEn(lugano, campus). 
estaEn(almagro, medrano). 
viajaEnAuto(nora). 
viajaEnAuto(matias).
viajaEnAuto(ana).
llegaRapido(Persona,Lugar):-viveEn(Persona, Barrio),estaEn(Barrio, Lugar).
llegaRapido(Persona, Lugar):- viajaEnAuto(Persona),estaEn(_, Lugar).

curso(julia, fisicaI).
curso(emilio, inglesII).
curso(elizabeth, quimica).
curso(pedro, economia).
aprobo(emilio, inglesII).
aprobo(elizabeth, quimica).

desaprobo(Persona, Materia):- curso(Persona, Materia), not(aprobo(Persona, Materia)).

contador(roque).
joven(roque).
tieneExperiencia(Persona):- trabajoEn(Persona, _).
profesional(Persona):-contador(Persona).
profesional(Persona):-abogado(Persona).
profesional(Persona):-ingeniero(Persona).

habla(roque,frances).
habla(ana,ingles).
habla(ana,frances).
habla(lucia,frances).
habla(lucia,ingles).
habla(cecilia,frances).
honesto(roque).
ingeniero(ana).
ingeniero(alicia).
trabajoEn(ana,omni).
trabajoEn(roque,acme).
trabajoEn(lucia,omni).
trabajoEn(alicia, ford).
trabajoEn(julio, acme).


abogado(cecilia).
ambicioso(cecilia).
ambicioso(julio).
ambicioso(Persona):- contador(Persona), joven(Persona).

puedeAndar(Persona, comercioExterior):-ambicioso(Persona).
puedeAndar(Persona, contaduria):- contador(Persona), honesto(Persona).
puedeAndar(Persona, ventas):- ambicioso(Persona), tieneExperiencia(Persona).
puedeAndar(lucia, ventas).
puedeAndar(Persona, proyectos):- ingeniero(Persona), tieneExperiencia(Persona).
puedeAndar(Persona, proyectos):- abogado(Persona), joven(Persona).
puedeAndar(Persona, logistica):- profesional(Persona), cumpleCondiciones(Persona).

cumpleCondiciones(Persona):- joven(Persona).
cumpleCondiciones(Persona):- trabajoEn(Persona, omni).

madre(mona, homero).
madre(jaqueline, marge).
madre(marge, maggie).
madre(marge, bart).
madre(marge, lisa).
padre(abraham, herbert).
padre(abraham, homero).
padre(clancy, jaqueline).
padre(homero, maggie).
padre(homero, bart).
padre(homero, lisa).

hermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona), mismoPadre(Persona, OtraPersona).

mismaMadre(Persona, OtraPersona):-madre(Madre, Persona), madre(Madre, OtraPersona), Persona \= OtraPersona.

mismoPadre(Persona, OtraPersona):- padre(Padre, Persona), padre(Padre, OtraPersona), Persona \= OtraPersona.

medioHermano(Persona, OtraPersona):- mismaMadre(Persona, OtraPersona), not(hermano(Persona, OtraPersona)).
medioHermano(Persona, OtraPersona):- mismoPadre(Persona, OtraPersona), not(hermano(Persona, OtraPersona)).

hijoUnico(Persona):- hijo(Persona, _), not(hermano(Persona, _)).

hijo(Persona, Progenitor):- madre(Progenitor, Persona).
hijo(Persona, Progenitor):- padre(Progenitor, Persona).

tio(Tio, Sobrino):-padre(Padre, Sobrino), hermano(Padre, Tio).
tio(Tio, Sobrino):- madre(Madre, Sobrino), hermano(Madre, Tio).
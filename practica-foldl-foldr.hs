{- Ejercicios de https://docs.google.com/document/d/1XfKwQxAEbXVnlPKCF9d7yysMT1ACaLqL6Y-Jz59Zo7A/edit?usp=sharing -}

-- Ejercicio 1
cantidadDeElementos lista = foldl contar 0 lista

contar sem _ = sem + 1

cantidadDeElementos' l = foldl (\sem _ -> sem + 1) 0 l

cantidadDeElementos'' l = foldr (\_ sem -> sem + 1) 0 l


-- Ejercicio 2
masGastador (cab:cola) = foldl masGasta cab cola

masGasta sem elemento  | snd sem > snd elemento = sem
                    | otherwise = elemento

masGastadorFoldl1 lista = foldl1 masGasta lista

masGastadorFoldr (cab:cola) = foldr (flip masGasta) cab cola

-- Ejercicio 3

monto lista = foldl (\sem (_, gasto) -> sem + gasto) 0 lista

monto' lista = foldr (\(_,gasto) sem -> sem + gasto) 0 lista

{- Ejercicio 4

foldl (\sem f -> f sem)  2 [(3+), (*2), (5+)]
15

foldr (\f sem -> f sem)  2 [(3+), (*2), (5+)]
17

foldr ($)  2 [(3+), (*2), (5+)]
15

foldl (flip ($)) 2 [(3+), (*2), (5+)]
17

-}

-- Ejercicio 5
type Nombre  = String
type InversionInicial = Int
type Profesionales = [String]

data  Proyecto = Proy {nombre:: Nombre, inversionInicial::  InversionInicial, profesionales:: Profesionales} deriving Show

proyectos :: [Proyecto]
proyectos = [(Proy "red social de arte" 20000 ["ing. en sistemas", "contador"]), (Proy "restaurante" 5000 ["cocinero", "adm. de empresas", "contador"]), (Proy "ventaChurros" 1000 ["cocinero"]) ]

maximoSegun f (cab:cola) = foldl (maximo  f) cab  cola

maximo f proyecto otroProyecto | f proyecto > f otroProyecto = proyecto
                                | otherwise = otroProyecto


maximoSegunFoldr f (cab:cola) = foldr (maximo f) cab cola

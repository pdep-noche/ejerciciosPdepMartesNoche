import Text.Show.Functions

doble :: Integer -> Integer
doble nro = nro * 2

--Aprovechando Pattern Matching
signo :: Integer -> Integer 
signo 0 = 0
signo nro | nro > 0 = 1
          | otherwise = -1

f nro = (doble.signo) nro

maximo :: Integer -> Integer -> Integer
maximo nro otroNum | nro > otroNum = nro
                    | otherwise = otroNum


sayHello x = "Hello " ++ x ++ "!"

-- Aprovechando Pattern Matching
esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal  _ = False

{- Ejercicio 1 -}
calcular :: (Integer, Integer) -> (Integer, Integer)
calcular (x,y) | even x && odd y = (doble x, siguiente y)
               | even x = (doble x, y)
               | odd y = (x, siguiente y)
               | otherwise = (x,y)    

siguiente :: Integer -> Integer
siguiente nro = nro + 1

{-Ejercicio 2 - 
   Con Pattern Matching -}
and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _  = False

{-Ejercicio 2 - 
     Con Ecuaciones con guardas -}
and'' :: Bool -> Bool -> Bool
and'' exp otraExp | exp = otraExp
                  | otherwise = False

{-Ejercicio 2 - 
    Con Pattern Matching -}
or' :: Bool -> Bool -> Bool
or' True _ = True
or' False expre = expre

--Ejercicio 3
type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)

notaMaxima :: Alumno -> Nota
notaMaxima (_, nota1, nota2, nota3) =  (max nota1 . max nota2) nota3

notaMaxima' :: Alumno -> Nota
notaMaxima' (_, nota1, nota2, nota3) = (nota1 `max` nota2) `max` nota3

-- Ejercicio 4
cuadruple :: Integer -> Integer
cuadruple nro = (doble.doble) nro

-- Ejercicio 5
esMayorA :: Integer -> Bool
esMayorA nro = ((>10).doble. siguiente. (+2)) nro



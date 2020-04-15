import Text.Show.Functions

doble :: Integer -> Integer
doble nro = nro * 2

signo :: Integer -> Integer 
signo 0 = 0
signo nro | nro > 0 = 1
          | otherwise = -1

f nro = (doble.signo) nro
maximo :: Integer -> Integer -> Integer
maximo nro otroNum | nro > otroNum = nro
                    | otherwise = otroNum


sayHello x = "Hello " ++ x ++ "!"

esVocal :: Char -> Bool
esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal  _ = False

calcular :: (Integer, Integer) -> (Integer, Integer)
calcular (x,y) | even x && odd y = (doble x, siguiente y)
               | even x = (doble x, y)
               | odd y = (x, siguiente y)
               | otherwise = (x,y)    

siguiente :: Integer -> Integer
siguiente nro = nro + 1

and' :: Bool -> Bool -> Bool
and' True True = True
and' _ _  = False

and'' :: Bool -> Bool -> Bool
and'' exp otraExp | exp = otraExp
                  | otherwise = False


or' :: Bool -> Bool -> Bool
or' True _ = True
or' False expre = expre

type Nota = Integer
type Alumno = (String, Nota, Nota, Nota)

notaMaxima :: Alumno -> Nota
notaMaxima (_, nota1, nota2, nota3) =  (max nota1 . max nota2) nota3

notaMaxima' :: Alumno -> Nota
notaMaxima' (_, nota1, nota2, nota3) = (nota1 `max` nota2) `max` nota3

cuadruple :: Integer -> Integer
cuadruple nro = (doble.doble) nro

esMayorA :: Integer -> Bool
esMayorA nro = ((>10).doble. siguiente. (+2)) nro



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
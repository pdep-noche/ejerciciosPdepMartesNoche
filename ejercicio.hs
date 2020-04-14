import Text.Show.Functions

doble :: Integer -> Integer
doble nro = nro * 2

signo :: Integer -> Integer 
signo nro | nro > 0 = 1
          | nro < 0 = -1
          | otherwise = 0

f nro = (doble.signo) nro
maximo :: Integer -> Integer -> Integer
maximo nro otroNum | nro > otroNum = nro
                    | otherwise = otroNum


sayHello x = "Hello " ++ x ++ "!"
type Bien = (String,Float)
data Ciudadano = UnCiudadano {profesion :: String, sueldo :: Float, 
cantidadDeHijos :: Float, bienes :: [Bien] } deriving Show

homero = UnCiudadano "SeguridadNuclear" 9000 3 [("casa",50000), ("deuda",-70000)]
frink = UnCiudadano "Profesor" 12000 1 []
krabappel = UnCiudadano "Profesor" 12000 0 [("casa",35000)]
burns = UnCiudadano "Empresario" 300000 1 [("empresa",1000000),("empresa",500000),("auto",200000)]

type Ciudad =  [Ciudadano]
springfield :: Ciudad
springfield = [homero, burns, frink, krabappel] 

------- punto 1
diferenciaDePatrimonio :: Ciudad -> Float
diferenciaDePatrimonio unaCiudad = (patrimonio.ciudadanoSegun maximo) unaCiudad - (patrimonio.ciudadanoSegun minimo) unaCiudad

patrimonio :: Ciudadano -> Float
patrimonio unCiudadano = sueldo unCiudadano + totalBienes unCiudadano

totalBienes:: Ciudadano -> Float
totalBienes unCiudadano = foldl (\sem (_, monto) -> sem + monto) 0 (bienes unCiudadano)

ciudadanoSegun :: (Ciudadano -> Ciudadano -> Ciudadano) -> Ciudad -> Ciudadano
ciudadanoSegun f (unCiudadano:ciudadanos) = foldl  f  unCiudadano ciudadanos

maximo :: Ciudadano -> Ciudadano -> Ciudadano
maximo unCiudadano otroCiudadano | patrimonio unCiudadano >= patrimonio otroCiudadano = unCiudadano
                                  | otherwise = otroCiudadano


minimo :: Ciudadano -> Ciudadano -> Ciudadano
minimo unCiudadano otroCiudadano | patrimonio unCiudadano < patrimonio otroCiudadano = unCiudadano
                                  | otherwise = otroCiudadano


----- Punto 2

tieneAutoAltaGama :: Ciudadano -> Bool
tieneAutoAltaGama unCiudadano = (any (\unBien -> altaGama unBien).bienes) unCiudadano

altaGama:: Bien -> Bool
altaGama ("auto", monto) = monto > 100000
altaGama _ = False

---- Punto 3
-- a
type Medida = Ciudadano -> Ciudadano
auh :: Medida
auh unCiudadano = aplicarMedidaGobierno (patrimonio unCiudadano < 0) (unCiudadano { sueldo = sueldo unCiudadano + (incremento.cantidadDeHijos) unCiudadano }) unCiudadano

aplicarMedidaGobierno :: Bool -> Ciudadano -> Ciudadano -> Ciudadano
aplicarMedidaGobierno cond unCiudadano otroCiudadano | cond = unCiudadano
                                              | otherwise = otroCiudadano

incremento cantidad = cantidad * 1000

-- b
impuestoGanancias :: Float -> Medida
impuestoGanancias minimo unCiudadano = aplicarMedidaGobierno (sueldo unCiudadano > minimo) (unCiudadano { sueldo = sueldo unCiudadano - diferencia (sueldo unCiudadano) minimo })  unCiudadano

diferencia sueldo cantidad = (sueldo - cantidad) * 0.3
--- c
impuestoAltaGama :: Medida
impuestoAltaGama unCiudadano = aplicarMedidaGobierno (tieneAutoAltaGama unCiudadano) (unCiudadano { sueldo = sueldo unCiudadano - (montoAuto.bienes) unCiudadano * 0.1 }) unCiudadano

montoAuto bienes = snd.head.filter altaGama $ bienes

-- d
negociarSueldoProfesion :: String -> Float -> Medida
negociarSueldoProfesion profesion porcentaje unCiudadano = aplicarMedidaGobierno  (esDeProfesion profesion unCiudadano) (unCiudadano {sueldo = (sueldo unCiudadano) +  incrementoSueldo (sueldo unCiudadano) porcentaje }) unCiudadano
  
incrementoSueldo sueldo unPorcentaje = (sueldo * unPorcentaje)/100
esDeProfesion unaProfesion unCiudadano = profesion unCiudadano == unaProfesion

--- 4

data Gobierno = UnGobierno { anios :: [Int], medidas :: [ Medida ] }

gobiernoA :: Gobierno
gobiernoA = UnGobierno [1999..2003] [impuestoGanancias 30.000, negociarSueldoProfesion "Profesor" 10,  negociarSueldoProfesion "Empresario" 40, impuestoAltaGama, auh]


gobiernoB :: Gobierno
gobiernoB = UnGobierno [2004..2008] [impuestoGanancias 40.000, negociarSueldoProfesion "Profesor" 30, negociarSueldoProfesion "Camionero" 40]

gobernarUnAnio :: Gobierno -> Ciudad -> Ciudad
gobernarUnAnio unGobierno unaCiudad = map (aplicarMedidas unGobierno) unaCiudad

aplicarMedidas :: Gobierno -> Ciudadano -> Ciudadano
aplicarMedidas unGobierno unCiudadano = foldl (flip ($))  unCiudadano  (medidas unGobierno)

gobernarPeriodoCompleto :: Gobierno -> Ciudad -> Ciudad
gobernarPeriodoCompleto unGobierno unaCiudad = foldl (flip ($))  unaCiudad (replicate (length.anios $ unGobierno) (gobernarUnAnio unGobierno))

gobernarPeriodoCompleto' unGobierno unaCiudad = foldl (\ciudad f -> f unGobierno ciudad)  unaCiudad (replicate (length.anios $ unGobierno) gobernarUnAnio)
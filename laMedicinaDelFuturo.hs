data Animal= Raton {nombre :: String, edad :: Float, peso :: Float, enfermedades :: [String]} deriving Show
-- Ejemplo de raton
cerebro :: Animal
cerebro = Raton "Cerebro" 9.0 0.2 ["brucelosis", "sarampión", "tuberculosis"]
-- Estos son las enfermedades infecciosas
enfermedadesInfecciosas = [ "brucelosis", "tuberculosis"]

-- Punto 1
modificarNombre f unRaton = unRaton {nombre = f.nombre $ unRaton }

modificarEdad f unRaton = unRaton { edad = f.edad $ unRaton}

modificarPeso f unRaton = unRaton { peso =  f.peso $ unRaton }

modificarEnfermedad f unRaton = unRaton { enfermedades =  f.enfermedades $ unRaton }

-- Punto 2

hierbaBuena unRaton = modificarEdad sqrt unRaton

hierbaVerde unaEnfermedad unRaton = modificarEnfermedad (filter (/= unaEnfermedad)) unRaton

alcachofa unRaton = modificarPeso  nuevoPeso  unRaton

nuevoPeso unPeso | unPeso > 2  = unPeso * 0.9
                 | otherwise = unPeso * 0.95

hierbaMagica =  modificarEdad (const 0).modificarEnfermedad (const [])

-- Punto 3 Medicamento
-- a
medicamento hierbas raton = foldl (\unRaton unaHierba -> unaHierba unRaton) raton hierbas
-- b
medicamento' hierbas raton = foldl (flip ($)) raton hierbas
-- c
antiAge = medicamento (replicate 3 hierbaBuena ++ [alcachofa]) 
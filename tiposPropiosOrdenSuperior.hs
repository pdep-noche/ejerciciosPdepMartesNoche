data Empleado = Comun {nombre:: String, sueldoBasico:: Double} |
    Jefe {nombre:: String, sueldoBasico ::Double, cantACargo:: Double}

sueldo :: Empleado -> Double
sueldo (Comun _ suel) = suel
sueldo (Jefe _ suel cantidad) = suel + plus cantidad

plus cantidad = 500 * cantidad
 {-Ejercicio 2 -}

data Bebida = Cafe {nombreBebida :: String, azucar :: Integer} |
            Gaseosa {sabor ::String , azucar :: Integer}

esEnergizante :: Bebida -> Bool
esEnergizante (Cafe "capuchino" _) = True
esEnergizante (Gaseosa "pomelo" cantidadAzucar) = cantidadAzucar > 10
esEnergizante _  = False

type Nombre = String
type Edad = Int
data Persona = Estudiante {nom :: Nombre, edad:: Edad}

julia :: Persona
julia = Estudiante "julia" 20
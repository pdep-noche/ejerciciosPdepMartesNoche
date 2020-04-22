data Empleado = Comun {nombre:: String, sueldoBasico:: Double} |
    Jefe {nombre:: String, sueldoBasico ::Double, cantACargo:: Double}

sueldo :: Empleado -> Double
sueldo (Comun _ suel) = suel
sueldo (Jefe _ suel cantidad) = suel + plus cantidad

plus cantidad = 500 * cantidad

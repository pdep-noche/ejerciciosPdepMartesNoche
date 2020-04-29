type Nombre = String
type Notas = [Int]
data Persona = Alumno {nombre :: Nombre, notas :: Notas}


promediosAlumnos:: [Persona] -> [(Nombre, Int)]
promediosAlumnos  = map (\unAlumno -> (nombre unAlumno, (promedio.notas)unAlumno)) 

promedio notas = (sum notas) `div` (length notas)

promediosSinAplazos :: [Notas] -> [Int]
promediosSinAplazos  = map (promedio.filter (>=6)) 

aprobo :: Persona -> Bool
aprobo  = all (>=6).notas

aprobaron :: [Persona] -> [Nombre]
aprobaron alumnos = (map nombre . filter aprobo) alumnos

productos  = zip 

productos'  = zipWith (\nom precio ->(nom, precio)) 
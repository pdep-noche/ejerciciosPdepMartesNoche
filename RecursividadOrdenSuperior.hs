type Nombre = String
type Notas = [Int]
data Persona = Alumno {nombre :: Nombre, notas :: Notas}


promediosAlumnos:: [Persona] -> [(Nombre, Int)]
promediosAlumnos  = map (\unAlumno -> (nombre unAlumno, (promedio.notas)unAlumno)) 

promedio notas = (sum notas) `div` (length notas)
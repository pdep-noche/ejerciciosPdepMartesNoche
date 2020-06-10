import Text.Show.Functions

psicosis :: UnaPelicula
psicosis = Pelicula "Psicosis" "Terror" 109 "Estados Unidos"
perfumeDeMujer :: UnaPelicula
perfumeDeMujer= Pelicula "Perfume de Mujer" "Drama" 150  "Estados Unidos" 

elSaborDeLasCervezas :: UnaPelicula
elSaborDeLasCervezas = Pelicula "El sabor de las cervezas"  "Drama" 95 "Iran" 

lasTortugasTambienVuelan :: UnaPelicula
lasTortugasTambienVuelan = Pelicula "Las tortugas también vuelan" "Drama" 103 "Iran" 

juan :: UnUsuario
juan = Usuario "juan" "estandar" 23  "Argentina" [perfumeDeMujer] 60

julia = Usuario "julia" "basico" 25 "Argentina" (replicate 22 elSaborDeLasCervezas) 70

-- 1
data UnaPelicula = Pelicula { nombre:: String, genero :: String, duracion :: Int , origen :: String } deriving (Show, Eq)

data UnUsuario = Usuario {nombreU:: String, categoria :: String,  edad :: Int, paisDeOrigen :: String, peliculas :: [UnaPelicula], estadoDeSalud :: Int } deriving Show


peliculasDeEmpresa :: [UnaPelicula]
peliculasDeEmpresa = [psicosis, perfumeDeMujer, elSaborDeLasCervezas, lasTortugasTambienVuelan]
-- 2
ver :: UnaPelicula -> UnUsuario -> UnUsuario
ver unaPelicula unUsuario = unUsuario { peliculas = peliculas unUsuario ++ [unaPelicula] } 

-- 3
premiarUsuariosFieles :: [UnUsuario] -> [UnUsuario]
premiarUsuariosFieles usuarios = map premiarUsuario usuarios

premiarUsuario:: UnUsuario -> UnUsuario
premiarUsuario unUsuario | esUsuarioFiel unUsuario = subirCategoria unUsuario
                         | otherwise = unUsuario

esUsuarioFiel :: UnUsuario -> Bool
esUsuarioFiel unUsuario =  ((>20).length.filter (("Estados Unidos" /=).origen).peliculas) unUsuario

subirCategoria :: UnUsuario -> UnUsuario
subirCategoria unUsuario = unUsuario {categoria = siguienteCategoria.categoria $ unUsuario}


siguienteCategoria :: String -> String
siguienteCategoria "basica" = "estandar"
siguienteCategoria _ = "premium"

-- 4
type Criterio = UnaPelicula -> Bool
teQuedasteCorto :: Criterio
teQuedasteCorto unaPelicula = (<35).duracion $ unaPelicula

cuestionDeGenero :: [String] -> Criterio
cuestionDeGenero generos unaPelicula = elem (genero unaPelicula) generos

cuestionDeGenero' generos unaPelicula = any (\gen -> (gen ==).genero $ unaPelicula) generos

deDondeSaliste :: String -> Criterio
deDondeSaliste paisOrigen unaPelicula = (paisOrigen ==). origen $ unaPelicula

vaPorEseLado :: (Eq a) => UnaPelicula -> (UnaPelicula -> a) -> Criterio
vaPorEseLado unaPelicula f otraPelicula = (f unaPelicula) == (f otraPelicula) 

-- 5
sugerirPeliculas :: UnUsuario -> [Criterio] -> [UnaPelicula]
sugerirPeliculas unUsuario criterios = (take 3 .filter (cumpleCondiciones unUsuario criterios)) peliculasDeEmpresa

cumpleCondiciones:: UnUsuario -> [Criterio] -> UnaPelicula -> Bool
cumpleCondiciones usuario criterios pelicula = (not.vioPelicula usuario) pelicula && cumpleCriterios criterios pelicula

vioPelicula :: UnUsuario -> UnaPelicula -> Bool
vioPelicula usuario pelicula = elem pelicula (peliculas usuario)

cumpleCriterios :: [Criterio] -> UnaPelicula -> Bool
cumpleCriterios criterios unaPelicula = all (\f -> f unaPelicula) criterios

-- Segunda Parte
-- 1
data UnCapitulo = CapituloSerie { nombreC :: String, generoS :: String, duracionC :: Int, origenS :: String, afectaUsuario :: (UnUsuario -> UnUsuario) } deriving Show

-- 2
consumeSerie :: UnUsuario -> UnCapitulo -> UnUsuario
consumeSerie usuario capitulo = (afectaUsuario capitulo) usuario

losSimuladoresI = CapituloSerie "Los Simuladores convierten a un hombre en el ideal para que recupere a su mujer" "Comedia" 39 "Argentina" (\usuario -> usuario {estadoDeSalud = (estadoDeSalud usuario) `div` 2})

losSimuladoresII = CapituloSerie "El grupo ayuda a un comerciante a deshacerse de un prestamista mafioso" "Comedia" 43 "Argentina" (\usuario -> usuario {estadoDeSalud = (estadoDeSalud usuario) `div` 2})

mejoraUsuario :: UnUsuario -> UnUsuario
mejoraUsuario unUsuario = unUsuario {estadoDeSalud = estadoDeSalud unUsuario + 50}

--  4
maraton :: UnUsuario -> [UnCapitulo] -> UnUsuario
maraton usuario serie = foldl consumeSerie usuario serie

-- 5
--   maraton juan ((take 3. cycle)  [losSimuladoresI, losSimuladoresII])
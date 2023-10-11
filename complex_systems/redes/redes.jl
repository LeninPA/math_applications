v = [] # vértices
s = 0 # susceptibilidad
f = 0 # fortaleza

mutable struct Red
	nodos::list
end

mutable struct Nodo
	v :: list
	s :: double
	f :: double
end

function Contains(i::Nodo)
	return true
end

function AddVecino(i::Nodo, j::Nodo)
	if v.Contains(j)
		return false
	else
		append!(v,[i])
		return true
end

function getNumVecinos(i::Nodo)
	return length(i.v)
end

function getVecino(n::Nodo, i::int)
	return n.v[i]
end

function setEstado!(n::Nodo, estado)
	n.s = estado
end

function crearRed(k::int)
	r # número aleatorio
	for l in 1:k
		# crear nodo con listas vacías
		# y estado inicial s_i
		# añadir vecinos de manera simétrica
		# conforme va creciendo la red
		# se puede validar que cada conexión no
		# se repita y sea única
	end
end

function crearEnlace!(n1::Nodo,n2::Nodo, simétrico::Bool)
	n1.addVecino(n2)
	if simétrico
		n2.addVecino(n1)
	end
end

function verRed(R::Red)
	# TODO: Aprender a usar Networks en julia
end

function guardarRed(R::Red, formato::str)
	# TODO: Aprender a usar archivos en julia
end



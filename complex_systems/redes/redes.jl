v = [] # vértices
s = 0 # susceptibilidad
f = 0

mutable struct Nodo
	v :: list
	s :: double
	f :: double
end

function AddVecino(i::Nodo)
	if v.Contains(i)
		return false
	else
		append!(v,[i])
		return true
end

function getNumVecinos(i::Nodo)
	return
end



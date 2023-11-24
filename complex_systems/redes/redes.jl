# using PlotlyJS, LightGraphs
# import GraphPlot  # for spring_layout
using Random
Random.seed!(1234)
using Graphs
using StatsBase
mutable struct Nodo
	# index
	idx :: Int
	# neighbors
	v :: Vector{Int}
	# state
	s :: Int
	# susceptibility
	f :: Float64
end


"""
	Red

	Crea una red de nodos de una gráfica, por defecto dirigida
"""
mutable struct Red
    nodos::Vector{Nodo}
	ejes::Vector{Int}
end

function addNode(R::Red, i::Nodo)::Bool
    push!(R.nodos,i)
end

function isNeighborOf(x::Nodo,y::Nodo)::Bool
	# x es vecino de y
	return x.idx in y.v	
end


function addNeighbor(i::Nodo, j::Nodo)::Bool
	if !(isNeighborOf(i,j))
		push!(j.v, i.idx)
		return true
	end
	return false
end


function getNumNeighbors(i::Nodo)::Int
	return length(i.v)
end


function getVecino(n::Nodo, i::Int)::Nodo
	return n.v[i]
end


function setState!(n::Nodo, state::Int)::Nothing
    n.s = state
	return Nothing
end

function normalizationFactor(R::Red, alpha::Float64=1)::Float64
	c = 0
	for v in R.nodos
		c += getNumNeighbors(v) ^ alpha
	end
	return c
end

function probKRL(normalizer::Float64,k::Nodo,alpha::Float64=1)::Float64
	# Probabilidad de Kravipsky, Redner, Leyvraz
    return normalizer * (getNumNeighbors(k) ^ alpha)
end

function selectNode(R::Red, alpha::Float64=1)::Nodo
    normalizer = normalizationFactor(R,alpha)
    weights = [probKRL(normalizer, vertex, alpha) for vertex in R.nodos]
    return sample(R.nodos, Weights(weights))
end

function createLink(R::Red, n1::Nodo, n2::Nodo, simetrico::Bool=true)
    addNeighbor(n1, n2)
    if simetrico
        addNeighbor(n2, n1)
		append!(R.ejes,[n1.idx,n2.idx])
    end
end

function createRed(n::Int,alpha::Float64=1; guardar::Bool=true)
	# Crea los primeros dos nodos
	n1 = Nodo(0,[1],1,1)
	n2 = Nodo(1,[0],1,1)
	R = Red([n1,n2], [0,1])
	time = 1
	for i in 1:n
		time += 1
		old_node = selectNode(R,alpha)
		new_node = Nodo(time, [old_node.idx],1,1)
		push!(R.nodos,new_node)
		createLink(R,old_node,new_node)
	end
	if guardar
        dirpath = "/Users/Lenin/Documents/Programacion/Fciencias/math_applications/complex_systems/redes/"
		nombre="data_a$(alpha)_n$n"
		guardarRed(R,dirpath,nombre)
	end
	return R
end

function guardarRed(R::Red, ruta::String="./", nombre::String="data", formato::String=".csv")
	n = length(R.nodos)
    m = length(R.ejes)

    G = Graph()
    add_vertices!(G, n)
	for i in 1:2:m
        # Se le añade un uno para que no cuente desde cero
        add_edge!(G, R.ejes[i]+1, R.ejes[i+1]+1)
	end
	filename=nombre*formato
	# println(filename)
	# println(ruta)
    export_csv(G;filename=filename, dirpath=ruta)
end

function export_cosmograph(G::Graph;filename::String="data.txt",dirpath::String="./")
	# Prepara el contenido para su exportación
	content="export const nodes = [\n"
    for v in vertices(G)
        content *= "{ id: '$v', color: [227,17,108,1] },\n"
    end
	content *= "]\n\nexport const links = ["
    for e in edges(G)
        content *= "{ source: '$(src(e))', target: '$(dst(e))' },\n"
    end
	content *= "]"
	file_path=joinpath(dirpath,filename)
	open(file_path,"w") do file
        write(file, content)
	end
    # println(pwd())
end
function export_csv(G; filename="data.csv", dirpath="./")
    # Prepara el contenido para su exportación
    content = "source,target\n"
    for e in edges(G)
        content *= "$(src(e)),$(dst(e))\n"
    end
    file_path = joinpath(dirpath, filename)
    open(file_path, "w") do file
        write(file, content)
    end
    # println(pwd())
end

n=100000
for alpha in [0.5,1.5]
	createRed(n,alpha)
end

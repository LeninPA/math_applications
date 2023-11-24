# using PlotlyJS, LightGraphs
# import GraphPlot  # for spring_layout
using SGtSNEpi, Random
using Graphs
using GLMakie
GLMakie.activate!()

v = [] # vértices
s = 0 # susceptibilidad
f = 0 # fortaleza

"""
	Red

	Crea una red de nodos de una gráfica, por defecto dirigida
"""
mutable struct Red
	nodos :: Vector{Int}
end

mutable struct Nodo
	# neighboring vertices
	v :: Vector{Int}
	# state
	s :: Int
	# susceptibility
	f :: Float64
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
end

function getNumVecinos(i::Nodo)
	return length(i.v)
end

function getVecino(n::Nodo, i::Int)
	return n.v[i]
end

function setEstado!(n::Nodo, estado)
	n.s = estado
end

function crearRed(k::Int)
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

function guardarRed(R::Red, formato::String)
	# TODO: Aprender a usar archivos en julia
end

# println("uwu")

# """
# No olvidar citar 
# @inproceedings{pitsianis2019sgtsnepi,
#     author = {Pitsianis, Nikos and Iliopoulos, Alexandros-Stavros and Floros, Dimitris and Sun, Xiaobai},
#     doi = {10.1109/HPEC.2019.8916505},
#     booktitle = {IEEE High Performance Extreme Computing Conference},
#     month = {11},
#     title = {{Spaceland Embedding of Sparse Stochastic Graphs}},
#     year = {2019}
# }
# y 
# @article{bezanson2017julia,
#   title={Julia: A fresh approach to numerical computing},
#   author={Bezanson, Jeff and Edelman, Alan and Karpinski, Stefan and Shah, Viral B},
#   journal={SIAM review},
#   volume={59},
#   number={1},
#   pages={65--98},
#   year={2017},
#   publisher={SIAM},
#   url={https://doi.org/10.1137/141000671}
# }
# """
println("uwu")
# Generate a random layout

n=100
# G = circular_ladder_graph(500)
G=Graph()
add_vertices!(G,n)
m=n-1
for i in 1:m
	add_edge!(G,i,i+1)
end
# is_directed(G)
# for v in vertices(G)
# 	println(v)
# end
# for v in edges(G)
# 	print(src(v))
# 	print(",")
# 	print(dst(v))
# 	print("\n")
# end
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
    println(pwd())
end
function export_csv(G::Graph; filename::String="data.csv", dirpath::String="./")
    # Prepara el contenido para su exportación
    content = "source,target"
    for e in edges(G)
        content *= "$(src(e)), $(dst(e))\n"
    end
    content *= "]"
    file_path = joinpath(dirpath, filename)
    open(file_path, "w") do file
        write(file, content)
    end
    println(pwd())
end
dirpath = "/Users/Lenin/Documents/Programacion/Fciencias/math_applications/complex_systems/redes/"
export_csv(G; dirpath=dirpath)
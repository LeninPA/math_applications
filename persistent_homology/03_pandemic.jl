using Karnak, Luxor, Graphs, NetworkLayout, Colors
using DataFrames, CSV

# positions are in LatLong

tubedata = CSV.File("./persistent_homology/tubedata-modified.csv") |> DataFrame

amatrix = Matrix(tubedata[:, 4:270])

extrema_lat = extrema(tubedata.Latitude)
extrema_long = extrema(tubedata.Longitude)

# scale LatLong and flip in y to fit into current Luxor drawing

positions = @. Point(
    rescale(tubedata.Longitude, extrema_long..., -280, 280),
    rescale(tubedata.Latitude, extrema_lat..., 280, -280))

stations = tubedata[!, :Station]

find(str) = findfirst(isequal(str), stations)
find(x::Int64) = stations[x]

g = Graph(amatrix)
# @drawsvg begin
#     background("black")
#     sethue("gold")
#     bc = betweenness_centrality(g)
#     drawgraph(g, layout=positions,
#         vertexshapesizes=1 .+ 12bc,
#         vertexlabels=[(degree(g, n) > 3) ? degree(g, n) : "" for n in vertices(g)],
#         vertexlabeltextcolors=colorant"black"
#     )
# end
function frame(scene, framenumber, diffresult)
    background("black")
    sethue("gold")
    Luxor.text(string(framenumber), boxbottomleft() + (10, -10))
    drawgraph(g, layout=positions, vertexshapesizes=3)
    for k in 1:framenumber
        i = diffresult[k]
        drawgraph(
            g,
            layout=positions,
            edgelines=0,
            vertexfunction=(v, c) -> begin
                if !isempty(i)
                    if v ∈ i
                        sethue("red")
                        circle(positions[v], 5, :fill)
                    end
                end
                if degree(g, v) > 3
                    sethue("blue")
                    circle(positions[v], 5, :fill)
                end
            end,
        )
    end
end

function main()
    amovie = Movie(600, 600, "diff")
    diffresult = diffusion(g, 0.2, 43, initial_infections=[find("Heathrow Terminal 5")])
    Luxor.animate(amovie,
        Scene(amovie, (s, f) -> frame(s, f, diffresult), 1:length(diffresult)),
        framerate=10,
        creategif=true,
        pathname="./tmp/diff.gif")
end
main()

# # Ahora obtenemos los vértices con grado mayor a 3 (son 29)
# l = [n for n in vertices(g) if degree(g, n) > 3]

using Karnak
using Graphs
using NetworkLayout
using Plots

g = barabasi_albert(51, 1, seed=1234)
@draw begin
    background("grey10")
    sethue("violet")
    bc = betweenness_centrality(g)
    drawgraph(g,
        layout=stress,
        vertexlabels=1:nv(g),
        vertexshapesizes=15 .+ 30bc,
        vertexfillcolors=HSB.(rescale.(bc, 0, maximum(bc), 150, 360), 0.7, 0.8)
    )
end 800 600
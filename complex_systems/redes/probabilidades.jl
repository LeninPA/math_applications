using DataFrames
using CSV
using StatsPlots
using LaTeXStrings

function probabilityFromCSV(path::String)
    df1 = DataFrame(CSV.File(path))
    df2 = rename(df1, [:source,:target])
    df2[!, 1], df2[!, 2] = df2[!, 2], df2[!, 1]
    df = vcat(df1,df2)
    grouped1 = combine(groupby(df, :source), nrow => :count)
    grouped1[!, 1], grouped1[!, 2] = grouped1[!, 2], grouped1[!, 1]
    rename!(grouped1, [:k,:proba])
    grouped2 = subset(combine(groupby(grouped1, :k), nrow => :count), :count => c -> c .> 0)
    grouped2.normal = grouped2.count ./ sum(grouped2.count)
    return grouped2
end

path = "./"
archivos = ["data_a0.5_n100000.csv", "data_a1.0_n100000.csv", "data_a1.5_n100000.csv", "fb-pages-politician.csv"]
filenames = path .* archivos
lista = probabilityFromCSV.(filenames)
p1 = @df lista[1] plot(
    :k,
    :normal,
    yaxis=:log10,
    xaxis=:log10,
    label=L"$\alpha=0.5$"
)
p2 = @df lista[2] plot(
    :k,
    :normal,
    yaxis=:log10,
    xaxis=:log10,
    label=L"$\alpha=1$"
)
p3 = @df lista[3] plot(
    :k,
    :normal,
    yaxis=:log10,
    xaxis=:log10,
    label=L"$\alpha=1.5$"
)
p4 = @df lista[4] plot(
    :k,
    :normal,
    yaxis=:log10,
    xaxis=:log10,
    label="Datos reales"
)

layout = @layout [a b; c d]
plot(p2,p4,p1,p3, 
    xlabel=["" "" L"k" L"k"],
    ylabel = [L"P(k)" "" L"P(k)" ""],
layout=layout)
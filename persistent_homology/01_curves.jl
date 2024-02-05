using Ripserer
using CSV # Importación de datos
using DataFrames # Procesamiento de datos
using StatsPlots

# -------
# Generación de la gráfica de parámetros de orden
# -------
println("Iniciando graficación")
df1 = DataFrame(CSV.File("./complex_systems/time_series/Serie_temporal_1.dat", delim="\t\t", header=false, select=[2]))
rename!(df1, :Column2 => :Parámetro1)
# n = nrow(df1) - 1
# @df df1 plot(
#     0:n,
#     :Parámetro1,
#     label="Serie 1",
#     plot_title="Parámetros de orden"
# )

df2 = DataFrame(CSV.File("./complex_systems/time_series/Serie_temporal_2.dat", delim="\t\t", header=false, select=[2]))
rename!(df2, :Column2 => :Parámetro2)
# n = nrow(df2) - 1
# @df df2 plot!(
#     0:n,
#     :Parámetro2,
#     label="Serie 2"
# )

df3 = DataFrame(CSV.File("./complex_systems/time_series/Serie_temporal_3.dat", delim="\t\t", header=false, select=[2]))
rename!(df3, :Column2 => :Parámetro3)
# n = nrow(df3) - 1
# @df df3 plot!(
#     0:n,
#     :Parámetro3,
#     label="Serie 3"
# )

# -----
# Clasificación con base en H_0
# -----

resultado1, _ = ripserer(Cubical(df1.Parámetro1); reps=true)
min_indices = [only(birth_simplex(int)) for int in resultado1]
min_x = eachindex(df1.Parámetro1)[min_indices]

infinite_interval = only(filter(!isfinite, resultado1))
plt = plot(
    representative(infinite_interval),
    df1.Parámetro1;
    legend=false,
    title="Representantes",
    seriestype=:path,
)

for interval in filter(isfinite, resultado1)
    plot!(plt, interval, df1.Parámetro1; seriestype=:path)
end

scatter!(plt, min_x, df1.Parámetro1[min_x]; color=1:6, markershape=:star)
display(plot(plt, plot(resultado1; markercolor=1:6, markeralpha=1)))
# display(barcode(resultado1,
#     title="Serie 1",
#     plot_title="Código de barras"
# ))
# display(plot(
#     resultado1,
#     title="Serie 1",
#     plot_title="Diagrama de persistencia",
#     xlabel="Nacimiento",
#     ylabel="Muerte"
# ))

resultado2, _ = ripserer(Cubical(df2.Parámetro2))
# display(barcode(resultado2,
#     title="Serie 2",
#     plot_title="Código de barras",
#     color=[:orange]
# ))
# display(plot(
#     resultado2,
#     title="Serie 2",
#     plot_title="Diagrama de persistencia",
#     xlabel="Nacimiento",
#     ylabel="Muerte",
#     color=[:orange]
# ))

resultado3, _ = ripserer(Cubical(df3.Parámetro3))
# display(barcode(resultado3,
#     title="Serie 3",
#     plot_title="Código de barras",
#     color=[:green]
# ))
# display(plot(
#     resultado3,
#     title="Serie 3",
#     plot_title="Diagrama de persistencia",
#     xlabel="Nacimiento",
#     ylabel="Muerte",
#     color=[:green]
# ))
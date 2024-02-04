using Ripserer
using CSV # Importación de datos
using DataFrames # Procesamiento de datos
using StatsPlots

# -------
# Generación de la gráfica de parámetros de orden
# -------

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

resultado1, _ = ripserer(Cubical(df1.Parámetro1))
display(plot(
    resultado1,
    title="Serie 1",
    plot_title="Diagrama de persistencia",
    xlabel="Nacimiento",
    ylabel="Muerte"
))

resultado2, _ = ripserer(Cubical(df2.Parámetro2))
display(plot(
    resultado2,
    title="Serie 2",
    plot_title="Diagrama de persistencia",
    xlabel="Nacimiento",
    ylabel="Muerte",
    color=[:orange]
))

resultado3, _ = ripserer(Cubical(df3.Parámetro3))
display(plot(
    resultado3,
    title="Serie 3",
    plot_title="Diagrama de persistencia",
    xlabel="Nacimiento",
    ylabel="Muerte",
    color=[:green]
))
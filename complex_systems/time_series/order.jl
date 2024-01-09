using Statistics # Estadística
using CSV # Importación de datos
using DataFrames # Procesamiento de datos
using StatsPlots
using StatsBase
using SignalAnalysis
using FFTW

df1 = DataFrame(CSV.File("./time_series/Serie_temporal_1.dat", delim="\t\t", header=false, select=[2]))
rename!(df1, :Column2 => :Parámetro1)
n = nrow(df1) - 1
@df df1 plot(
    0:n,
    :Parámetro1,
    label="Serie 1",
    plot_title="Parámetros de orden"
)

df2 = DataFrame(CSV.File("./time_series/Serie_temporal_2.dat", delim="\t\t", header=false, select=[2]))
rename!(df2, :Column2 => :Parámetro2)
n = nrow(df2) - 1
@df df2 plot!(
    0:n,
    :Parámetro2,
    label="Serie 2"
)

df3 = DataFrame(CSV.File("./time_series/Serie_temporal_3.dat", delim="\t\t", header=false, select=[2]))
rename!(df3, :Column2 => :Parámetro3)
n = nrow(df3) - 1
@df df3 plot!(
    0:n,
    :Parámetro3,
    label="Serie 3"
)
auto1 = autocor(df1.Parámetro1)
auto2 = autocor(df2.Parámetro2)
auto3 = autocor(df3.Parámetro3)

plot(
    1:length(auto1),
    auto1,
    label="Serie 1",
    plot_title="Autocorrelación"
)
plot!(
    1:length(auto2),
    auto2,
    label="Serie 2"
)
plot!(
    1:length(auto3),
    auto3,
    label="Serie 3"
)

f1 = abs2.(fft(df1.Parámetro1) ./ sqrt(length(df1.Parámetro1)))
f2 = abs2.(fft(df2.Parámetro2) ./ sqrt(length(df2.Parámetro2)))
f3 = abs2.(fft(df3.Parámetro3) ./ sqrt(length(df3.Parámetro3)))
plot(
    1:length(f1),
    f1,
    label="Serie 1",
    plot_title="Espectro de potencias"
)
plot(
    1:length(f2),
    f2,
    label="Serie 2",
    plot_title="Espectro de potencias",
    color=:orange
)
plot(
    1:length(f3),
    f3,
    label="Serie 3",
    plot_title="Espectro de potencias",
    color=:green
)
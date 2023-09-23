# Paquetes necesarios
using CSV # Importación de datos
using DataFrames # Procesamiento de datos
using ShiftedArrays # Ídem
using Statistics # Ídem
using Plots # Visualización de datos
using Distributions
using Random
Random.seed!(12459641728)
# Importación de los datos
# TODO: Que reconozca los datos en Windows
df = DataFrame(CSV.File("./casos_diarios_2.dat", delim="\t\t", header = false,select=[2]))
rename!(df,:Column2 => :Casos)

scatter(
    1:195,
    df.Casos,
    label="Casos septiempre",
    markercolor=:pink,
    xlabel="Días",
    ylabel="Casos registrados"
)

function log_normal(x, average=0.0, deviation=1.0, normalization=1.0)
    return (normalization/x)*exp(-((log(x)-average)/deviation)^2) 
end

#a = Distributions.LogNormal(1000,0.5)
r = 1:195
n_ini = 999999
a_ini = 5.2
s_ini = 0.7
plot!(
    r,
    [log_normal(x,a_ini,s_ini,n_ini) for x in r],  
    label = "Inicial"
)
    
function distancia(x_1,x_2)
    return (x_1-x_2)^2
end

function alg_gen(epsilon, datos, func, avg, dev, r, norm, k=1000000)
    n = length(datos)
    for i in 1:k
        prediccion = [func(x,avg,dev,norm) for x in r]
        delta_2 = randn()
        avg_2 = avg + randn()
        dev_2 = dev + delta_2 > 0 ? dev+delta_2 : dev
        norm_2 = norm + randn()
        prediccion_nueva = [func(x, avg_2, dev_2, norm_2) for x in r]
        d1 = sum(distancia.(prediccion, datos))/n
        # println(d1)
        d2 = sum(distancia.(prediccion_nueva, datos))/n
        # println(d2)
        # println(d2)
        # println(d1)
        # println(d2 < d1)
        d = d2 < d1 ? d2 : d1
        avg = d2 < d1 ? avg_2 : avg
        dev = d2 < d1 ? dev_2 : dev
        norm = d2 < d1 ? norm_2 : norm
    end
    return (norm,avg, dev)
end

(n, a, s) = alg_gen(0.0001, df.Casos, log_normal, a_ini, s_ini, r, n_ini)
print("$n $a $s")

plot!(
    r,
    [log_normal(x,a,s,n) for x in r],
    label="Ajuste"
)
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
df = DataFrame(CSV.File("./casos_diarios_2.dat", delim="\t\t", header = false,select=[2]))
rename!(df,:Column2 => :Casos)
# Obtención de casos totales
df[!,"Totales"] .= df[!,"Casos"]
for (i, row) in enumerate(eachrow(df[2:end,:]))
    df[i+1,"Totales"] += df[i,"Totales"]
end
# Graficación
df[!,"Normal"] .= 3*df.Casos ./ maximum(df.Casos)
scatter(
    1:195,
    df.Normal,
    label = "Casos septiempre",
    markercolor=:pink,
    xlabel = "Días",
    ylabel = "Casos registrados"
)
scatter(
    1:195,
    df.Casos,
    label="Casos septiempre",
    markercolor=:pink,
    xlabel="Días",
    ylabel="Casos registrados"
)
# Log-normal = (A/x)exp(-(log(x)-mu)/(sigma^2))
# Primera aproximación
# average   = mean(df.Casos)
# deviation = std(df.Casos)
# function log_normal(x, average = 0.0, deviation = 1.0, normalization = 1.0)
#    return (normalization*exp( -(log(x)-average)^2 /deviation^2 ))/x
# end
# function ayuda(x::Vector, average=0.0, deviation=1.0, normalization=1.0)
#     return (normalization .* exp.(.-(log.(x) .- average).^2 ./ deviation.^2)) ./ x
# end
# # function log_normal(x::Array, average::float=0.0, deviation::float=1.0, normalization::float=1.0)
# #     x = (normalization ./ x).*exp.(.-(log.(x) .- average) ./ (deviation.^2))
# # end
# for elem in [1,50,100,150,200]
#     println("$elem ", log_normal(elem, 0, 0.5, 10000000))
# end
# plot!(
#     0:195,
#     ayuda([0:195...],150.0, 150.0,8000.0),
#     label="Casos septiempre"
# )

# function log_normal(x, average = 0.0, deviation = 1.0, normalization = 1.0)
#    return normalization*(1/x)*(exp(-(log(x)-average)^2 / (deviation^2)))
# end
# #println(map(log_normal(average = 0, deviation = 0.6, normalization = 100), [1,2,3]))
# # for elem in [1:50]:

# function log_normal(x, average=0.0, deviation=1.0, normalization=1.0)
#     a = Distributions.LogNormal(average, deviation)
#     return normalization * Distributions.pdf(a,x)
# end

function log_normal(x, average=0.0, deviation=1.0, normalization=1.0)
    return (normalization/x)*exp(-((log(x)-average)/deviation)^2) 
end

#a = Distributions.LogNormal(1000,0.5)
r = 1:195
n_ini = 6000
a_ini = 1000
s_ini = 200
plot!(
    r,
    [log_normal(x,a_ini,s_ini,n_ini) for x in r],  
    label = "Inicial"
)
    
function distancia(x_1,x_2)
    return (x_1-x_2)^2
end

function alg_gen(epsilon, datos, func, avg, dev, r, norm, k=50000)
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

(n,a,s) = alg_gen(0.0001,df.Casos,log_normal,150, 1.6664133995196326,r,6000)
print("$n $a $s")
# plot!(
#     r,
#     [n*Distributions.pdf(LogNormal(a, s), x) for x in r],  
#     label = "Final"
# )
# plot!(
#     r,
#     [3185 * n * Distributions.pdf(LogNormal(a, s), x) for x in r],
#     label="Final 2"
# )
# plot!(
#     r,
#     [n * Distributions.pdf(LogNormal(a, s), x) for x in r],
#     label="Final"
# )
plot!(
    r,
    [log_normal(x,a,s,n) for x in r],
    label="Final 2"
)
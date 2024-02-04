function logistic_regression(x0, R, n)
    results = [x0]
    for i in 1:n
        l = last(results)
        append!(results, R * l * (1 - l))
    end
    return results
end

println(logistic_regression(0.5, 2.5, 3))
println(logistic_regression(0.2, 2.6, 10))
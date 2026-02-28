obs <- c(12, 8, 7, 7, 13)
esp <- c(1/5, 1/5, 1/5, 1/5, 1/5)
est <- c(0.4, 0.4, 0, 0.9, 0.9)

res <- chisq.test(obs,p = esp)
res

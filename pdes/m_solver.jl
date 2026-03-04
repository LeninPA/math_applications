function random_matrix(n)
  M = rand(n, n)
  b = rand(n, 1)
  M \ b
end

function disc_random_matrix(n)
  m = 5
  M = rand(1:m, n, n)
  b = rand(n, 1)
  M \ b
end

function main()
  n = 1000000
  total = 10
  solved = 0
  for i=1:total
    try
      disc_random_matrix(n)
      solved += 1
    catch
      println("Matriz singular encontrada")
      solved += 0
    end
  end
  prob = solved / total
  println("La probabilidad de encontrar una sol. es $prob")
end

main()

function main()
  n = 5
  m = [ x == y ? 1 : 0 for x in 1:n, y in 1:n ]
  println(m)
end

main()

using RecursiveArrayTools, Base.Test

A = (rand(5),rand(5))
p = ArrayPartition(A)
@test (p.x[1][1],p.x[2][1]) == (p[1],p[6])

p2 = similar(p)
p2[1] = 1
@test p2.x[1] != p.x[1]

C = rand(10)
p3 = similar(p,indices(p))
@test length(p3.x[1]) == length(p3.x[2]) == 5
@test length(p.x) == length(p2.x) == length(p3.x) == 2

A = (rand(5),rand(5))
p = ArrayPartition(A)
B = (rand(5),rand(5))
p2 = ArrayPartition(B)
a = 5

p .= (*).(p,5)
p .= (*).(p,a)
p .= (*).(p,p2)
K = (*).(p,p2)

x = ArrayPartition([1, 2], [3.0, 4.0])
@inferred(similar(x))
@inferred(similar(x, (2, 2)))
@test_broken @inferred(similar(x, Int, (2, 2)))
@test_broken @inferred(similar(x, (Int, Float64), (2, 2)))

_scalar_op(y) = y + 1
# Can't do `@inferred(_scalar_op.(x))` so we wrap that in a function:
_broadcast_wrapper(y) = _scalar_op.(y)
# Issue #8
@inferred(_broadcast_wrapper(x))

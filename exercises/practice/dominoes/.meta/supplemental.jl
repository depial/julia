#=
There are two suggestions for testing in the problem specifications. The more rigorous choice, of testing
a returned chain for validity, was used in runtests.jl
Below is the other implementation of the algorithm which simply returns true/false if a chain is possible.
The accompanying test set is below that.

The change to the algorithm below is very minor, but this change may still be easier for some students.
Due to this change being for less experienced students I have explicitly tested as @test dominoes(input) == true/false
for clarity, instead of using the return value directly (i.e. @test dominoes(input)/!dominoes(input))
This points at another potential benefit which is that no helper function is needed for testing the validity of the chain.
=#

function dominoes(stones)
    function dfs(stones, chain, indices)
        length(indices) == length(stones) && first(first(chain)) == last(last(chain)) && return true
        for (i, stone) in enumerate(stones)
            if i ∉ indices && last(last(chain)) ∈ stone
                check = dfs(stones, push!(chain, last(last(chain)) == first(stone) ? stone : reverse(stone)), push!(indices, i))
                check && return true
                delete!(indices, i)
                pop!(chain)
            end
        end
        false
    end
    isempty(stones) || dfs(stones, [first(stones)], Set(1))
end

@testset "empty input = empty output" begin
    @test dominoes([]) == true
end

@testset "singleton input = singleton output" begin
    @test dominoes([1, 1]) == true
end

@testset "singleton that can't be chained" begin
    @test dominoes([1, 2]) == false
end

@testset "three elements" begin
    @test dominoes([[1, 2], [3, 1], [2, 3]]) == true
end

@testset "can reverse dominoes" begin 
    @test dominoes([[1, 2], [1, 3], [2, 3]]) == true
end

@testset "can't be chained" begin
    @test dominoes([[1, 2], [4, 1], [2, 3]]) == false
end

@testset "disconnected - simple" begin
    @test dominoes([[1, 1], [2, 2]]) == false
end

@testset "disconnected - double loop" begin
    @test dominoes([[1, 2], [2, 1], [3, 4], [4, 3]]) == false
end

@testset "disconnected - single isolated" begin
    @test dominoes([[1, 2], [2, 3], [3, 1], [4, 4]]) == false
end

@testset "need backtrack" begin
    @test dominoes([[1, 2], [2, 3], [3, 1], [2, 4], [2, 4]]) == true
end

@testset "separate loops" begin
    @test dominoes([[1, 2], [2, 3], [3, 1], [1, 1], [2, 2], [3, 3]]) == true
end

@testset "nine elements" begin
    @test dominoes([[1, 2], [5, 3], [3, 1], [1, 2], [2, 4], [1, 6], [2, 3], [3, 4], [5, 6]]) == true
end

@testset "separate three-domino loops" begin
    @test dominoes([[1, 2], [2, 3], [3, 1], [4, 5], [5, 6], [6, 4]]) == false
end

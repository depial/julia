#= 
The following algorithm and testset are if an O(n^2) (where n = high - low) solution is acceptable.
With the whole range being searched, and with the inefficiency of the algorithm (testset runs ~25x slower than with the string based algo), 
this setup encourages both the largest and smallest palindrome to be found simultaneously.
The instructions would likely have to be updated to emphasize this point, since the tests may timeout if done individually.
=#

function palindromeproducts(low::Int, high::Int)
    high < low && throw(ArgumentError("low is greater than high: $low > $high"))
    ispalindrome(n) = "$n"[1:ndigits(n)÷2] == reverse("$n")[1:ndigits(n)÷2]
    lowpalprod, highpalprod = Dict(Inf => []), Dict(-Inf => [])
    for i in low:high, j in i:high
        check = i * j
        if ispalindrome(check)
            haskey(lowpalprod, check) && push!(lowpalprod[check], [i, j])
            haskey(highpalprod, check) && push!(highpalprod[check], [i, j])
            (isempty(lowpalprod) || only(keys(lowpalprod)) > check) && (lowpalprod = Dict(check => [[i, j]]))
            (isempty(highpalprod) || only(keys(highpalprod)) < check) && (highpalprod = Dict(check => [[i, j]]))
        end
    end
    (only(keys(lowpalprod)), only(values(lowpalprod))), (only(keys(highpalprod)), only(values(highpalprod)))
end

# Slug
function palindromeproducts(low::Int, high::Int)
    # Your code here
    (smallestpal, smallestfactors), (largestpal, largestfactors)
end

# Testset for O(n^2) algos. The main difference from the other testset is that tests for smallest and largest palindromes 
# are done with a single call to palindromeproducts because of the inefficiency of an O(n^2) algorithm.

using Test

include("palindrome-products.jl")

@testset verbose = true "tests" begin
    smallest, largest = palindromeproducts(1, 9)
    @testset "find the smallest palindrome from single digit factors" begin
        @test first(smallest) == 1
        @test last(smallest) == [[1, 1]]
    end
    
    @testset "find the largest palindrome from single digit factors" begin
        @test first(largest) == 9
        @test sort(last(largest)) == [[1, 9], [3, 3]]
    end
    
    smallest, largest = palindromeproducts(10, 99)
    @testset "find the smallest palindrome from double digit factors" begin
        @test first(smallest) == 121
        @test last(smallest) == [[11, 11]]
    end

    @testset "find the largest palindrome from double digit factors" begin
        @test first(largest) == 9009
        @test last(largest) == [[91, 99]]
    end
    
    smallest, largest = palindromeproducts(100, 999)
    @testset "find the smallest palindrome from triple digit factors" begin
        @test first(smallest) == 10201
        @test last(smallest) == [[101, 101]]
    end
    
    @testset "find the largest palindrome from triple digit factors" begin
        @test first(largest) == 906609
        @test last(largest) == [[913, 993]]
    end
    
    smallest, largest = palindromeproducts(1000, 9999)
    @testset "find the smallest palindrome from four digit factors" begin
        @test first(smallest) == 1002001
        @test last(smallest) == [[1001, 1001]]
    end
    
    @testset "find the largest palindrome from four digit factors" begin
        @test first(largest) == 99000099
        @test last(largest) == [[9901, 9999]]
    end
    
    @testset "empty result for smallest if no palindrome in the range" begin
        smallest, largest = palindromeproducts(1002, 1003)
        @test isempty(last(smallest))
    end
    
    @testset "empty result for largest if no palindrome in the range" begin
        smallest, largest = palindromeproducts(15, 15)
        @test isempty(last(largest))
    end
    
    @testset "error result for smallest if min is more than max" begin
        @test_throws ArgumentError palindromeproducts(10000, 1)
    end
    
    @testset "error result for largest if min is more than max" begin
        @test_throws ArgumentError palindromeproducts(10000, 1)
    end
    
    @testset "smallest product does not use the smallest factor" begin
        smallest, largest = palindromeproducts(3215, 4000)
        @test first(smallest) == 10988901
        @test last(smallest) == [[3297, 3333]]
    end
end

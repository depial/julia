#=
Below is a basic version of the testset from the specs in canonical-data.json which doesn't explicitly test insertion 
or membership (only instatiation and sorting are explicitly tested), and it doesn't go beyond what is listed in tests.toml

The testset currently in runtests.jl is more in line with the problem description and so is recommended to be used. It also
encorages an implementation with instantiation which is closer to other Julia collections. The two testsets
have the same core (found in tests.toml), but the extended version tests further functionality.

Below the tests, there is sample starter code for the slug, if desired, and there are a few extra methods 
that could be added to the example if further functionality testing is done. Finally, there is an example implementation with 
an immutable struct which passes the basic tests found below.
=#


# Basic testset

@testset "data is retained" begin
    tree = BinarySearchTree([4])
    @test tree.data == 4
        @test isnothing(tree.left)
        @test isnothing(tree.right)
end

@testset "insert data at proper node" begin
    @testset "smaller number at left node" begin
        tree = BinarySearchTree([4, 2])
        @test tree.data == 4
            @test tree.left.data == 2
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end

    @testset "same number at left node" begin
        tree = BinarySearchTree([4, 4])
        @test tree.data == 4
            @test tree.left.data == 4
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end
    
    @testset "greater number at right node" begin
        tree = BinarySearchTree([4, 5])
        @test tree.data == 4
            @test isnothing(tree.left)
            @test tree.right.data == 5
                @test isnothing(tree.right.left)
                @test isnothing(tree.right.right)
    end
end

@testset "can create complex tree" begin
    tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
    @test tree.data == 4
        @test tree.left.data == 2
            @test tree.left.left.data == 1
                @test isnothing(tree.left.left.left)
                @test isnothing(tree.left.left.right)
            @test tree.left.right.data == 3
                @test isnothing(tree.left.right.left)
                @test isnothing(tree.left.right.right)
        @test tree.right.data == 6
            @test tree.right.left.data == 5
                @test isnothing(tree.right.left.left)
                @test isnothing(tree.right.left.right)
            @test tree.right.right.data == 7
                @test isnothing(tree.right.right.left)
                @test isnothing(tree.right.right.right)    

end

@testset "can sort data" begin
    @testset "can sort single number" begin
        tree = BinarySearchTree([2])
        @test sort(tree) == [2]
    end

    @testset "can sort if second number is smaller than first" begin
        tree = BinarySearchTree([2, 1])
        @test sort(tree) == [1, 2]
    end

    @testset "can sort if second number is same as first" begin
        tree = BinarySearchTree([2, 2])
        @test sort(tree) == [2, 2]
    end

    @testset "can sort if second number is greater than first" begin
        tree = BinarySearchTree([2, 3])
        @test sort(tree) == [2, 3]
    end

    @testset "can sort complex tree" begin
        tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
        @test sort(tree) == [1, 2, 3, 4, 5, 6, 7]
    end
end


# As long as inserstion is tested, the slug could take starter code since struct can only be mutable, 
# but inclusion is not necessary and the slug can be left 'blank'

mutable struct BinarySearchTree
    data
    left
    right
end

function Base.push!(tree::BinarySearchTree, node)
    # Your code here
end

function Base.in(node, tree::BinarySearchTree)
    # Your code here
end

function Base.sort(tree::BinarySearchTree)
    # Your code here
end

# Possible extra methods for example.jl

Base.minimum(tree::BinarySearchTree) = isnothing(tree.left) ? tree.data : minimum(tree.left)
Base.maximum(tree::BinarySearchTree) = isnothing(tree.right) ? tree.data : maximum(tree.right)
Base.extrema(tree::BinarySearchTree) = minimum(tree), maximum(tree)

# Below is an example of an immutable struct which passes basic instantiation (i.e. w/ only vector input) and sorting tests only
# It can be made to support searching, and non-vector input instatiation, but not insertion
#=
struct BinarySearchTree
    data
    left
    right
    function BinarySearchTree(arr::Vector{T}) where T<:Real
        d = popfirst!(arr)
        l, r = (x -> isempty(x) ? nothing : BinarySearchTree(x)).((arr[arr .≤ d], arr[arr .> d]))
        new(d, l, r)
    end
end

function traverse(tree::BinarySearchTree, channel::Channel)
    !isnothing(tree.left) && traverse(tree.left, channel)
    put!(channel, tree.data)
    !isnothing(tree.right) && traverse(tree.right, channel)
end

sort(tree::BinarySearchTree) = collect(Channel(channel -> traverse(tree, channel)))
=#

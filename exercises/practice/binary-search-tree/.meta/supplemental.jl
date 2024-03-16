#=
Below is a full testset, which is more complete than the literal translation of the specs in canonical-data.json which
was used for the initial testset in runtests.jl. 
The first two test groups below (instantiation and searching) are beyond the specs in canonical-data.json, 
so they don't have UUIDs, but those that follow (insertion and sorting) do follow the specs (albeit more liberally) and have UUIDs

Below the tests, there is sample starter code for the slug, if desired, and there are a few extra methods 
that could be added to the example if further testing is done. Finally, there is an example implementation with 
an immutable struct which passes the limited tests in the literal interpretation of the specs in canonical.json. 
However, it would not pass the majority of the tests below.
=#

# Further instantiation tests to encourage an implementation closer to other Julia collections

@testset "instantiation with different inputs" begin
    @testset "instantiation without input" begin
        tree = BinarySearchTree()
        @test isa(tree, BinarySearchTree)
    end

    @testset "instantiation with a single real number" begin
        tree = BinarySearchTree(4)
        @test isa(tree, BinarySearchTree)
        @test tree.data == 4
            @test isnothing(tree.left)
            @test isnothing(tree.right)
    end

    @testset "instantiation with vector containing a single real number" begin
        tree = BinarySearchTree([4])
        @test isa(tree, BinarySearchTree)
        @test tree.data == 4
            @test isnothing(tree.left)
            @test isnothing(tree.right)
    end

    @testset "instantiation with vector containing multiple real numbers" begin
        tree = BinarySearchTree([4, 3, 5])
        @test isa(tree, BinarySearchTree)
        @test tree.data == 4
            @test tree.left.data == 3
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test tree.right.data == 5
                @test isnothing(tree.right.left)
                @test isnothing(tree.right.right)
    end
end

# Tests for searching

@testset "searching" begin
    @testset "Single element" begin
        tree = BinarySearchTree([4])
        @test 4 ∈ tree
        @test 5 ∉ tree
    end

    @testset "two elements" begin
        tree = BinarySearchTree([4, 2])
        @test 4 ∈ tree
        @test 2 ∈ tree

        tree = BinarySearchTree([4, 5])
        @test 4 ∈ tree
        @test 5 ∈ tree
    end

    @testset "complex tree" begin
        tree = BinarySearchTree([4, 2, 6, 1, 3, 5, 7])
        @test 4 ∈ tree
        @test 2 ∈ tree
        @test 6 ∈ tree
        @test 1 ∈ tree
        @test 3 ∈ tree
        @test 5 ∈ tree
        @test 7 ∈ tree
    end
end

# Alternate testset to the one in runtests.jl which explicitly tests insertion instead of more general instantiation
# These can replace those in runtests.jl (especially if used with instantiation tests above) or supplement them
# If used to supplement, the test descriptions should probably be changed on one of the two sets

@testset "insert data at proper node" begin
    @testset "smaller number at left node" begin
        tree = BinarySearchTree([4])
        push!(tree, 2)
        @test tree.data == 4
            @test tree.left.data == 2
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end

    @testset "same number at left node" begin
        tree = BinarySearchTree([4])
        push!(tree, 4)
        @test tree.data == 4
            @test tree.left.data == 4
                @test isnothing(tree.left.left)
                @test isnothing(tree.left.right)
            @test isnothing(tree.right)
    end
    
    @testset "greater number at right node" begin
        tree = BinarySearchTree([4])
        push!(tree, 5)
        @test tree.data == 4
            @test isnothing(tree.left)
            @test tree.right.data == 5
                @test isnothing(tree.right.left)
                @test isnothing(tree.right.right)
    end
end

@testset "can create complex tree" begin
    tree = BinarySearchTree([4])
    foreach(node -> push!(tree, node), [2, 6, 1, 3, 5, 7])
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


# If inserstion is tested, the slug could take starter code since struct can only be mutable, but this in not necessary

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

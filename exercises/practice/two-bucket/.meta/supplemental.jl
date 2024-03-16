#=
Below are a few extra edge cases which are not in canonical-data.json. I encountered many trying to get a more mathematical 
implementation to work, but I only included a few here. I was testing against a more procedural implementation, 
which can be found below the tests (the two algorithms are mutually consistent as far as I can tell). 
Lastly, there is a function to produce example input, which I used to test the two implementations against each other.
=#

# Extra edge cases which could be added to testing

@testset "Buckets are same size but goal is different" begin
    @test_throws DomainError twobucket(4, 4, 2, 1)
end

@testset "Both buckets are the same size as the goal" begin
    @test twobucket(3, 3, 3, 1) == (1, 1, 0)
    @test twobucket(3, 3, 3, 2) == (1, 2, 0)
end

@testset "Goal is multiple of smaller bucket and smaller than larger bucket, start with smaller bucket" begin
    @test twobucket(4, 9, 8, 1) == (4, 2, 0)
end

@testset "Goal is multiple of smaller bucket and smaller than larger bucket, start with larger bucket" begin
    @test twobucket(1, 9, 7, 2) == (4, 2, 1)
end

@testset "Bucket one is larger than bucket two, start with bucket one" begin
    @test twobucket(9, 5, 4, 1) == (2, 1, 5)
end

@testset "Bucket one is larger than bucket two, start with bucket two" begin
    @test twobucket(9, 5, 4, 2) == (22, 2, 9)
end

@testset "Switching bucket order and start number gives same result only with end bucket number switched" begin
    @test twobucket(26, 12, 4, 1) == (10, 1, 12)
    @test twobucket(12, 26, 4, 2) == (10, 2, 12) 
end

# Procedural approach
function twobucket(bucket1, bucket2, goal, start)
    goal == (bucket1, bucket2)[start] && return (1, start, 0)
    goal == (bucket1, bucket2)[mod1(start+1,2)] && return (2, mod1(start+1,2), (bucket1, bucket2)[start])
    b1, b2 = isone(start) ? (bucket1, bucket2) : (bucket2, bucket1)
    (gcd(b1, b2, goal) != gcd(b1, b2) || max(b1, b2) < goal) && throw(DomainError(goal, "impossible"))
    
    actions, liters1, liters2, action = 0, 0, 0, "fill"
    while true
        if action == "fill"
            liters1, action = b1, "pour"
        elseif action == "pour"
            liters1, liters2 = max(0, liters1 + liters2 - b2), min(liters1 + liters2, b2)
            action = liters2 == b2 ? "empty" : "fill"
        elseif action == "empty"
            liters2, action = 0, "pour"
        end
        actions += 1
        liters1 == goal && return (actions, start, liters2)
        liters2 == goal && return (actions, 2, 0)
    end
end

function bucketinput(limit1=20, limit2=80, limitgoal=40)
    # Input creation used to check procedural and mathematical algorithms against each other
    bucket1 = rand(1:limit1)
    goal = rand(1:limitgoal)
    bucket2 = rand(goal:limit2)
    start = rand(1:2)
    bucket1, bucket2 = iszero(i%2) ? (bucket1, bucket2) : (bucket2, bucket1)
    (bucket1, bucket2, goal, start)
end

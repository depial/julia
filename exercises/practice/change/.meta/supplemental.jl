#=
Below is an implementation which uses recursion to memoize. It's less efficient than the
traditional dynamic programming version in example.jl. I used it to test correctness against
the other algo with the helper function below. I doubt there's much use for these, but theyre here.
=#

function change(coins, target)
    memo = Dict(0 => (0,0))
    function dfs(val=0, d=0)
        for coin in coins
            if val+coin ≤ target && d < first(get(memo, val+coin, Inf))
                memo[val+coin] = (d, val)
                dfs(val+coin, d+1)
            end 
        end
    end
    dfs()
    
    !haskey(memo, target) && throw(DomainError(target, "Not Possible"))
    
    changeback, previous = [], Inf
    while 0 < target
        _, previous = memo[target]
        push!(changeback, target-previous)
        target = previous
    end
    
    sort!(changeback)
end

function coins_n_target()
    coins = unique([rand(1:50) for _ in 1:rand(2:6)])
    target = rand(3:200)
    coins, target
end

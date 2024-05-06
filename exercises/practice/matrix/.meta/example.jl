function matrix(strmatrix)
    M = let mtrx = strmatrix
        mtrx = split(mtrx, "\n")
        mtrx = split.(mtrx, " ")
        mtrx = map(row-> parse.(Int, row), mtrx)
        reduce(hcat, mtrx)'
    end
    collect.((eachrow(M), eachcol(M)))
end

#=
A compressed version of the above algorithm

function matrix(strmatrix)
    M = reduce(hcat, map(row-> parse.(Int, row), split.(split(strmatrix, "\n"), " ")))'
    collect.((eachrow(M), eachcol(M)))
end
=#

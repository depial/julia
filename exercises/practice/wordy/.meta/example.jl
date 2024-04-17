function readeval(eq)
    m = match(r"-?\d+\.?\d* [-+*/] -?\d+\.?\d*", eq)
    isnothing(m) ? match(r"^-?\d+\.?\d*$", eq) : readeval(replace(eq, m.match => Base.eval(Meta.parse(m.match))))
end

function wordy(problem)
    optuples = zip(("plus","minus","divided by","multiplied by","What is ","?"), ("+","-","/","*","",""))
    foreach(op -> problem = replace(problem, first(op) => last(op)), optuples)
    answer = readeval(problem)
    isnothing(answer) ? throw(ArgumentError(problem)) : Meta.parse(answer.match)
end

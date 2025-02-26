function cleanupname(name)
    hyphensreplaced = replace(name, "-" => " ")
    cleaned = strip(hyphensreplaced)
    cleaned
end

firstletter = string ∘ first ∘ cleanupname

function initial(name)
    getfirstletter = firstletter(name)
    upper = uppercase(getfirstletter)
    join([upper, "."])
end

function couple(name1, name2)
    "\u2764 $(initial(name1))  +  $(initial(name2)) \u2764"
end

using DataFrames

function display()
    Base.print("\n--- The vectors current plot $(curplot()) ---\n")
    veclist = listcurvecs()
    df = DataFrame(Name = String[], Type = String[], DataType = Type[], Length = Int[])
    for v in veclist
        vname, vtype, vdata = getvec(v)
        push!(df, (vname, vtype, typeof(vdata), sizeof(vdata)))
    end
    df |> Base.print
end

function _vecswitch(vecstr)
    if !occursin("-", vecstr) return getrealvec
    elseif vecstr ∈ ("--real", "-r") return getrealvec
    elseif vecstr ∈ ("--imaginary", "-i")  return getimagvec
    elseif vecstr ∈ ("--magnitude", "-m") return getmagnitudevec
    elseif vecstr ∈ ("--phase", "-p") return getphasevec
    end
end

function print(params)
    if !occursin("-", params[1])
        veclist = getrealvec.(params)
        DataFrame(Dict(zip(params, veclist))) |> print
    else
        getthisvec = _vecswitch(params[1])
        veclist = getthisvec.(params[2:end])
        DataFrame(Dict(zip(params[2:end], veclist[2:end]))) |> print
    end
end

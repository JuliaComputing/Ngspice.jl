using ReplMaker

function _ngspice_repl_parser(str)
    if str == "init" init()
    elseif occursin("plot", str)
        params = split(str[6:end], " ")
        if !occursin("-", params[1]) semilogplot(getrealplot, params)
        elseif params[1] ∈ ("--real", "-r") semilogplot(getrealplot, params[2:end])
        elseif params[1] ∈ ("--imaginary", "-i") semilogplot(getimagplot, params[2:end]) 
        elseif params[1] ∈ ("--magnitude", "-m") semilogplot(getmagnitudeplot, params[2:end])
        elseif params[1] ∈ ("--phase", "-p") semilogplot(getphaseplot, params[2:end])
        else throw("$(params[1]) is not a valid plot type")
        end
    else cmd(str)
    end
end

interactive() = (init(); 
           initrepl(_ngspice_repl_parser,
                  prompt_text  = "NgSpice> ",
                  prompt_color = :yellow,
                  start_key    = '~',
                  mode_name    = "for NgSpice is",
                  ))

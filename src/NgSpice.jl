__precompile__()
module NgSpice

using ngspice_jll
export ngspice_jll

using Requires

include("interface/ctypes.jl")
export Ctm, Ctime_t, Cclock_t

include("interface/ngspice_common.jl")
include("interface/ngspice_api.jl")

#= Might not be necessary
export bgthreadrunning, controlledexit, #getISRCdata, detsyncdata, getVSRCdata,
       sendchar, senddata, sendstat, sendinitdata=#

export gen_pbgthread, gen_pcontrolledexit, gen_psendchar, gen_psenddata,
       gen_psendinitdata, gen_psendstat,
       pbgthread, pcontrolledexit, psendchar, psenddata, psendinitdata,
       psendstat

foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "ng")
        @eval export $s
    end
end #should this be replaced with aliases

include("API/get_vector.jl")
include("API/graphs.jl")
include("API/netlist.jl")
include("API/out.jl")
include("API/running.jl")

function __init__()
    @require Plots="91a5bcdd-55d7-5caf-9e0b-520d859cae80" @eval include("API/repl.jl")
end

export get_vector_info, 
       curplot, listallplots, listallvecs, listcurvecs, getimagvec, 
       getmagnitudevec, getphasevec, getvec, getrealvec,
       NgSpiceGraphs, graph,
       load_netlist, 
       bghalt, bgrun, cmd, init,
       interactive
       #isrunning,
end

using JLD
using PyPlot
function tiempos(ti,dt,tf)
ts=Float64[]
is=Float64[]
i=0
for t in ti:dt:tf
i=i+1
push!(ts,t)
push!(is,i)
save("prueba.jld","ts",ts,"is",is)
end
datos = load("prueba.jld")
ts=hcat(ts...)';
is=hcat(is...)';
plot(is,ts)
end
tiempos(0,5,10)


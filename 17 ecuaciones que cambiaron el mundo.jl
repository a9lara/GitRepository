using PyPlot

# Polinomios de Alexander de nudos

nudoTrivial(x) = 1
trébol(x) = x-1+x^(-1)
ocho(x) = -x+3-x^(-1)
rizo(x) = x^2-2x+3-(2/x)+x^(-2)
abuelita(x) = x^2-2x+3-(2/x)+x^(-2)
deStevedore(x) = -2x+5-(2/x)

function nudos(f)

xs=Float64[]
ys=Float64[]

	for x in -100:0.01:100

		y = f(x)

		push!(xs,x)  
		push!(ys,y)

	end

plot(xs,ys)

end

# nudos(trébol)


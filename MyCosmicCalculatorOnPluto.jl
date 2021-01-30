### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ c0156742-633f-11eb-0127-8d55706bd079
begin
	
	using Pkg
	Pkg.add.(["Markdown", "InteractiveUtils", "CSV", "DataFrames", "PlutoUI", "Plots", "PlotlyBase", "ProgressMeter"])
	
	using Markdown
	using InteractiveUtils
	using CSV
	using DataFrames
	using PlutoUI
	using Plots
	using PlotlyBase
	using ProgressMeter
	plotly()
	
end

# ╔═╡ b935f066-633f-11eb-131d-8b2a8e5d751c
md" ### Packages "

# ╔═╡ 41fd8282-634b-11eb-0662-83f18b91eae5


# ╔═╡ c0155416-633f-11eb-1352-5d18478245fd
md" ### Constants "

# ╔═╡ ce6f97ea-633f-11eb-07b2-e9e96055b9fc
begin
	
	###########################
	#        CONSTANTS      
	###########################
	
	c = 2.997925e10 # Speed of Light [cm/s]
	h_planck = 6.6256e-27 # Planck Constant [erg⋅s]
	Ωr = 0
	Ωm = 0.286
	ΩΛ = 0.714
	Ωk = 1-Ωm-Ωr-ΩΛ
	Ho = 72 # km/s/Mpc
	Ho = Ho/3.086e19 # 1/s
	Ho = Ho*3.154e16 # 1/Gyr
	e_charge = 1.6021e-19 # Electron charge [C]

	###########################
	#     UNIT CONVERTION     
	###########################
	
	convert_E_eV_erg = 1.6021e-12 # Convertion factor of Energy from [eV] to [erg]
	convert_E_eV_Hz = 2.4180452e14 # Convertion factor of Energy from [eV] to [Hz]
	convert_E_erg_Hz = 1.509e26 # Convertion factor of Energy from [erg] to [Hz]
	convert_E_keV_erg = 1.6021e-9 # Conertion factor of energy from [keV] to [erg]
	convert_d_cm_Å = 1e8 # Convertion factor of distance from [cm] to [Å]
	convert_d_pc_cm = 3.086e18 # Convertion factor of distance from [pc] to [cm]
	
end

# ╔═╡ 400cd29a-634b-11eb-104e-633c195f6352


# ╔═╡ d610cd48-633f-11eb-3e0b-bd524e4774a6
md" ### Theory "

# ╔═╡ d72c2664-633f-11eb-1dd6-7beaa05e6167
md"
 $\boxed{H^2(t) = \left(\frac{\dot{a}}{a}\right)^2 = H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(\frac{a_\mathrm{o}}{a}\right)^3+\Omega_\mathrm{r}\left(\frac{a_\mathrm{o}}{a}\right)^4+\Omega_\mathrm{k}\left(\frac{a_\mathrm{o}}{a}\right)^2+\Omega_\mathrm{\Lambda}\left(\frac{a_\mathrm{o}}{a}\right)^0\right]} \ \ (1)$



 $\boxed{\dot{a} = \frac{da}{dt} = \frac{da}{dz}\frac{dz}{dt}} \ \ (2)$

 $\boxed{a = \frac{1}{1+z}} \Rightarrow \boxed{\frac{da}{dz}=-\left(\frac{1}{1+z}\right)^2} \ \ (3)$

 $\Rightarrow \boxed{\frac{da}{dt} = -\left(\frac{1}{1+z}\right)^2 \frac{dz}{dt}} \ \ (4)$

 $\boxed{a_\mathrm{o} = 1} \ \ (5)$

 $\boxed{\left(-\left(\frac{1}{1+z}\right)^2 \frac{dz}{dt}\right)\left(1+z\right) =  \sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z\right)^3+\Omega_\mathrm{r}\left(1+z\right)^4+\Omega_\mathrm{k}\left(1+z\right)^2+\Omega_\mathrm{\Lambda}\right]}} \ \ (6)$

 $\boxed{-\left(\frac{1}{1+z}\right) \frac{dz}{dt}=  \sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z\right)^3+\Omega_\mathrm{r}\left(1+z\right)^4+\Omega_\mathrm{k}\left(1+z\right)^2+\Omega_\mathrm{\Lambda}\right]}} \ \ (7)$

 $\boxed{-\frac{dz}{dt}=  \sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z\right)^5+\Omega_\mathrm{r}\left(1+z\right)^6+\Omega_\mathrm{k}\left(1+z\right)^4+\Omega_\mathrm{\Lambda}\left(1+z\right)^2\right]}} \ \ (8)$


 $\boxed{dt= \frac{-dz}{\sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z\right)^5+\Omega_\mathrm{r}\left(1+z\right)^6+\Omega_\mathrm{k}\left(1+z\right)^4+\Omega_\mathrm{\Lambda}\left(1+z\right)^2\right]}}} \ \ (9)$

 $\boxed{t= \int_0^z \frac{dz}{\sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z\right)^5+\Omega_\mathrm{r}\left(1+z\right)^6+\Omega_\mathrm{k}\left(1+z\right)^4+\Omega_\mathrm{\Lambda}\left(1+z\right)^2\right]}}} \ \ (10)$

##### Under a numerical integration would be something like:

 $\boxed{t_2= t_1 + \frac{dz}{\sqrt{H_\mathrm{o}^2\left[\Omega_\mathrm{M}\left(1+z_1\right)^5+\Omega_\mathrm{r}\left(1+z_1\right)^6+\Omega_\mathrm{k}\left(1+z_1\right)^4+\Omega_\mathrm{\Lambda}\left(1+z_1\right)^2\right]}}} \ \ (a)$

 $\boxed{t_1 = t_2} \ \ (b)$ 
 
 $\boxed{z_1 =z_1 + dz} \ \ (c)$
"

# ╔═╡ 13cdd77e-634b-11eb-3868-1fdc4da9b130


# ╔═╡ e2128d66-633f-11eb-37b5-b5db87f1b281
md" ### Code "

# ╔═╡ e5d5280a-633f-11eb-195e-51f99d8f40c4
begin
	
	function CosmicCalculator(z)
	
	tᵤ = 1/Ho
	t = 0
	dz = 0.001
	z₂ = z
	z₁ = 0
	
	t_array = Float64[]
	z_array = Float64[]
		
	while z₁ <= z₂
			push!(t_array,tᵤ - t)
			push!(z_array,z₁)
			t = t + dz/(sqrt(Ho^2*((Ωm*(1+z₁)^5)+(Ωr*(1+z₁)^6)+(Ωk*(1+z₁)^4)+(ΩΛ*(1+z₁)^2))))
			z₁ = z₁ + dz			
	end
		t_array,z_array
		
	end
	
end

# ╔═╡ 077961ec-6340-11eb-00f9-2b35135fc57a
md" ### Runing the code"

# ╔═╡ 05cc753c-6340-11eb-0991-e1da1d615bd8
t,z = CosmicCalculator(2)

# ╔═╡ 16b821de-6340-11eb-063d-57e026af9c16
md" ### Plotting the rsults"

# ╔═╡ 1e8a5472-6340-11eb-13fd-2167bf7ef588
begin
	Plot(t,z)
end

# ╔═╡ c42b88a6-6345-11eb-01d0-c59a30d001ca
begin
	age = round(t[end],digits=3)
	redshift = round(z[end],digits=2)
end

# ╔═╡ 74a6f992-634b-11eb-0aaa-737adf2f68bb
println("La edad del universo a z = $redshift es $age Gyr.")

# ╔═╡ 8cbcbb9e-6348-11eb-0e37-4f056f528afd
md"### La edad del universo a z = $redshift es $age Gyr."

# ╔═╡ Cell order:
# ╟─b935f066-633f-11eb-131d-8b2a8e5d751c
# ╠═c0156742-633f-11eb-0127-8d55706bd079
# ╟─41fd8282-634b-11eb-0662-83f18b91eae5
# ╟─c0155416-633f-11eb-1352-5d18478245fd
# ╠═ce6f97ea-633f-11eb-07b2-e9e96055b9fc
# ╟─400cd29a-634b-11eb-104e-633c195f6352
# ╟─d610cd48-633f-11eb-3e0b-bd524e4774a6
# ╟─d72c2664-633f-11eb-1dd6-7beaa05e6167
# ╟─13cdd77e-634b-11eb-3868-1fdc4da9b130
# ╟─e2128d66-633f-11eb-37b5-b5db87f1b281
# ╠═e5d5280a-633f-11eb-195e-51f99d8f40c4
# ╟─077961ec-6340-11eb-00f9-2b35135fc57a
# ╠═05cc753c-6340-11eb-0991-e1da1d615bd8
# ╟─16b821de-6340-11eb-063d-57e026af9c16
# ╠═1e8a5472-6340-11eb-13fd-2167bf7ef588
# ╠═c42b88a6-6345-11eb-01d0-c59a30d001ca
# ╟─74a6f992-634b-11eb-0aaa-737adf2f68bb
# ╟─8cbcbb9e-6348-11eb-0e37-4f056f528afd

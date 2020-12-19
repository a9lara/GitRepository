### A Pluto.jl notebook ###
# v0.12.17

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ a94070d2-3c09-11eb-22fe-776f72d0035a
begin


	############################################
	# Credits for MySlider: https://github.com/barucden
	struct MySlider 
	    range::AbstractRange
	    default::Number
	end
	function Base.show(io::IO, ::MIME"text/html", slider::MySlider)
	    print(io, """
			<input type="range" 
			min="$(first(slider.range))" 
			step="$(step(slider.range))"
			max="$(last(slider.range))" 
			value="$(slider.default)"
			oninput="this.nextElementSibling.value=this.value">
			<output>$(slider.default)</output>""")
	end
	###########################################
	
		
	# import Pkg; Pkg.add("Plots")
	# import Pkg; Pkg.add("PlotlyBase")
	
	using PlutoUI
	using Plots
	plotly()
	
		###########################################
	
	function Maxwellian_Distribution(T)
thermal_distributions=Float64[]
vs=Float64[]
	for v in 0:0.1:50
thermal_distribution = T^(3/2) * v^2*exp.(-v^2/T)
push!(thermal_distributions,thermal_distribution)
		push!(vs,v)
	end
		thermal_distributions,vs
end
	
end

# ╔═╡ 24f93ad2-3b57-11eb-3aff-7964ec8e894a
md"
# 5 Line Atomic Parameters

## 5.1 Overview
To **describe how matter and light interact** we need to understand many **atomic physics quantits** and how they are related to one another.
## 5.2 Line Absorption
This is seen in the spectra when material between the source of light and the observer absorbs some of the light.
### 5.2.1 Line optical depths
Imagine we have a transition from an upper level **A**, to a lower level **B**.

The **optical depth** for such transition is given by:

$\boxed{dτ_{A,B}=α_{ν}\left(n_B-\frac{n_Ag_B}{g_A}\right)f(r)} \ \ \ (1)$

 $\boxed{f(r)}$ is the **filling factor**

 $\boxed{\alpha_ν}$ is the atomic **absorption cross section** [cm$^2$]

The term in parenthesis is the **population** [cm$^3$] of the lower level, with correction for **stimulated emission**. This term is the only place where **stimulated emission** enters in the **radiative balance** equations.
"

# ╔═╡ da7393f6-3b59-11eb-2aed-4d327edeb345
# Optical Depth 
dτ_AB(αν,nA,nB,gA,gB,r) = αν*(nB-nA*gB/gA)*f(r) 

# ╔═╡ df1a21c6-3b5a-11eb-3b57-756ae2eb251a
# Filling Factor
filling_factor(r) = r^3

# ╔═╡ f0ada102-3be5-11eb-2f6a-d77bf434a7e5
md"
### 5.2.2 Oscillator Strength
**What is it?** It is a **dimensionless number** of order unity.
	
**What is its concept?** It can be thought of as a **correction factor** to make the expression for a classical oscillator agree with the quantum mechanical value.
	
**What other line parameters are related to it?** Many, such as the **absorption coefficient** and the **transition probability**.
	
There are two Oscillator Strenght Coefficients:
	
**1) Absorption Oscillator Strenght Coefficient** (f$_{\mathrm{B,A}}$ = f$_{\mathrm{absorption}}$ )
	
**2) Emission Oscillator Strenght Coefficient**  (f$_{\mathrm{A,B}}$ = f$_{\mathrm{emision}}$)
	
And are related by:
	
$\boxed{g_B \ f_{B,A} = - \ g_A \ f_{A,B}} \ \ \ (2)$

**$\boxed{g}$**'s are the **statistical weights**.

The convention is that emission lines have negative oscillator strength.
	
### 5.2.3 Absorption Cross Section
	
The line center **absorption cross section** $\alpha_{\nu}$ (cm$^2$) is related with f$_{\mathrm{absorption}}$ by:

$\boxed{\alpha_{\nu} = \frac{\sqrt{\pi} \ q_e^2 \ \lambda  \ f_{\mathrm{abs}} \  \varphi_{\nu}(x)}{m_e \ c \ v_\mathrm{Doppler}} = 149.74 \ f_{\mathrm{absorption}} \ \frac{\lambda_{\mathrm{cm}}}{v_{\mathrm{Doppler}}} \ \varphi_{\nu}(x) \ \ [\mathrm{cm}^2]}\ \ \ (3)$

 $\boxed{v_\mathrm{Doppler}}$ is the **Doppler velocity** width (cm s$^{-1}$), the point where the line profile falls to $\boxed{\frac{1}{e}}$ of its peak.

 $\boxed{\varphi(x)}$ is the **Voigt function**.

 $\boxed{x \ \equiv \ \frac{\nu \ - \ \nu_o}{\Delta\nu_\mathrm{Doppler}}}$ is the **relative line displacement**.

With this definition of the **relative line displacement**, the **line profile** due to **thermal motions** alone is $\boxed{e^{-x^2}}$.
"

# ╔═╡ 9d73b22a-3be6-11eb-3b54-1714e19b250c
# relative line displacement
x(ν,νo,Δν_Doppler) = (ν-νo/Δν_Doppler)

# ╔═╡ 6683e03a-3be6-11eb-0276-150b8856697f
# Voigt function
φν(ν,νo,Δν_Doppler) = x(ν,νo,Δν_Doppler)^2

# ╔═╡ df8d4dd6-3be6-11eb-0d1d-cda97c11c343
# Absorption Cross Section
αν(f_absorption,λ,v_Doppler,ν,νo,Δν_Doppler) = 149.74*f_absorption*λ/v_Doppler*φν(ν,νo,Δν_Doppler)

# ╔═╡ 41ae4c22-3c03-11eb-2374-4da29bb8c418
md"
## 5.3 The Line Profile Function
### 5.3.1 Velocities in a thermal distribution
The dimensionless velocity distribution function for a Maxwellian distribution is
given by

$\boxed{f(v) = 4\pi \left(\frac{m}{2\pi kT}\right)^{\frac{3}{2}}v^2 e^{\frac{-mv^2}{2kT}}} \ (4)$ 
"

# ╔═╡ 47d760f4-40c2-11eb-37ad-279f3504f746
Boltzman_Constant = 1.381e-16 # [erg K^-1]

# ╔═╡ 57fed056-3c0e-11eb-056c-37f7b45ae745
md"Temperature: $(@bind T1111 MySlider(0:10, 0.01)) K"

# ╔═╡ 7097507e-3c0a-11eb-0e6c-c96b22de9c71
begin
	t,v = Maxwellian_Distribution(T1111)
	ta,va = Maxwellian_Distribution(T1111)
end

# ╔═╡ d664b216-3c0a-11eb-0399-4b10b37dabf4
begin 
	plot(v,t,label="T = $T1111 K")
	plot(va,ta,label="T = $T1111 K")
	xlabel!("Velocity")
	ylabel!("Thermal Distribution")
	xlims!((0,10))
	ylims!((0,120))
	title!("Maxwellian Distribution")
end

# ╔═╡ 490dc08e-40be-11eb-1ee3-7526cbcc6c45
md"

It is important to know that there are 3 mean speeds in a **thermal velocity distribution**

#### 1) The first speed is the **`Most Probable Speed`**

[It] is also known as **Mean Velocity**. It turns out that it is equal to the **Doppler Velocity Width**, sometiemes referred to as **Velocity Dispersion**. 

The important thing is that **it is the peak of the velocity distribution**, and is found by setting the derivative of the distribution function to zero. 

$\boxed{\mathrm{v}_\mathrm{ \ mean} = \sqrt{\frac{2 \ \mathrm{k}_\mathrm{B} \ T}{m}} \ [\mathrm{cm} \ \mathrm{s}^{-1}]} \ (5)$ 

Therefore, the **velocity distribution can be expressed in terms of the mean speed** as:

$\boxed{f(\mathrm{v}) = \frac{\sqrt{\frac{16}{\pi}} \ \left(\frac{\mathrm{v}^{\ 2}}{\mathrm{v}_\mathrm{\ mean}^{\ 3}}\right)}{\exp\left({\frac{\mathrm{v}^2}{\mathrm{v}_\mathrm{\ mean}^{\ 3}}}\right)}} \ (6)$ 

Regarding the **Doppler Velocity Width**: The observed linewidth is proportional to the velocity projected along our line of sight. The **Doppler Velocity Width**, $\mathrm{v_{Doppler}}$, is the velocity averaged over the projected line of sight. $\mathrm{v_{Doppler}}$ is the distance form line center where the line profile falls to $e^{-1}$  of its central value. 

#### 2) The second speed is the **`Average Speed`**

It is also known as **Expected Value**.

It is obtained by averaging over this function and is given by

$\boxed{\mathrm{v}_{\mathrm{\ average}}=\sqrt{\frac{8 \ \mathrm{k_B} \ T}{\pi \ m}}} \ (7)$ 

#### 3) The third speed is the **`Root Mean Square Speed`**

It corresponds to the speed of a particle with median kinetic energy.

$\boxed{\mathrm{v}_{\mathrm{\ rms}}=\sqrt{\frac{3}{8}} \ \mathrm{v}_\mathrm{ \ mean}} \ (7)$ 

"

# ╔═╡ 4b8b2b70-40ba-11eb-350b-971e7040f47c
v_mean(T,m) = sqrt(2*Boltzman_Constant*T/m)

# ╔═╡ 9582d11a-40c9-11eb-3476-cbafd81d7973
v_average(T,m) = sqrt(8*Boltzman_Constant*T/(π*m))

# ╔═╡ 9583b364-40c9-11eb-257c-3f2d926a3a91
v_rms(T,m) = sqrt(3/8)*v_mean(T,m)

# ╔═╡ 95e6bbd8-40c6-11eb-0851-9779c5789838
begin
	v_mean_ARRAY=Float64[]
	T_ARRAY=Float64[]
	for T in 0:1:50000
	v = v_mean(T,1)	
	push!(v_mean_ARRAY,v)
	push!(T_ARRAY,T)
	end
	T_ARRAY,v_mean_ARRAY
end

# ╔═╡ 87e2a4fc-40c6-11eb-37b8-d3a434c3465c
begin 
	plot(T_ARRAY,v_mean_ARRAY,label=false)
	xlabel!("Temperature")
	ylabel!("Velocity")
end

# ╔═╡ 4150c22e-4235-11eb-3079-1549a7209d3a


# ╔═╡ 55241024-4228-11eb-0391-f90756271892
md"
### 5.3.2 Line Widths

If there is no thermal component, the micr
"

# ╔═╡ 3c737760-4235-11eb-1be8-79b212f9f6eb


# ╔═╡ c7ddac9e-40b6-11eb-37f5-716ef3b2db5e
md"
### 5.3.3 The Doppler b parameter

It is simply the name that is given to de **velocity width** or  **velocity dispersion with turbulence included**, and is given by:

$\boxed{b^2 = \frac{2kT}{m_A}+v_\mathrm{ \ Turbulance}^{\ 2} \ \left[\mathrm{cm}^{2}  \ 
\mathrm{s}^{-2}\right]}$

$\boxed{b = \frac{\Delta v_\mathrm{FWHM}}{2 \ \sqrt{\ln (2)}} \ \left[\mathrm{cm}^{2}  \ 
\mathrm{s}^{-2}\right]}$
"

# ╔═╡ 8cf72bda-40ca-11eb-0ab7-fdb3f1c916f9
Doppler_b_parameter(T,m,v_Trubulance) = sqrt(2*Boltzman_Constant*T/m)+v_Trubulance^2 # [cm^2 s^-2]

# ╔═╡ 05ac39ce-4235-11eb-201a-0bcb6612d928


# ╔═╡ 89bc8eb8-422a-11eb-036b-0fd5e71e75b5
md"
### 5.3.4 Voigt function 

The **`RELATIVE DISPLACEMENT`** is given by 

$\boxed{x \equiv \frac{\nu - \nu_\mathrm{o}}{\Delta\nu_{\mathrm{Doppler}}}}$

"

# ╔═╡ ea76aaba-4232-11eb-23ec-abb60f290167
relative_displacement(ν,νo,Δν_Doppler) = (ν-νo)/Δν_Doppler

# ╔═╡ 2d51fb46-4233-11eb-16d2-d901efddf3db
xx = relative_displacement(2,1,1)

# ╔═╡ 0804d794-4235-11eb-1ff8-43557d6de7ad


# ╔═╡ a19b1b74-4234-11eb-2041-a9c728c0d4ac
md"

The **`VOIGT FUNCTION`** ,$\boxed{\varphi(x)}$, is normalized to unity at line center and is approximately given by

$\boxed{\varphi(x) \approx \frac{e^{-x^2} + a}{\sqrt{\pi} \ x^2} }$

where $\boxed{a}$ is the **`DAMPING CONSTANT`**.

"

# ╔═╡ 39a86a4c-4233-11eb-1c34-1be5c9b5d4f7
damping_constant = 1

# ╔═╡ fd96acd0-4232-11eb-38bf-ff83f01d94f2
a = damping_constant

# ╔═╡ da2132aa-4234-11eb-2b2d-d90d38979a2f
voigt_function(x,a) = (exp(-x ^2) + a)/(sqrt(π)*x ^2)

# ╔═╡ e06b358e-4234-11eb-0202-fb8f1315d0d2
Voigt = voigt_function(xx ,a) 

# ╔═╡ 150d054c-4235-11eb-3df3-4138d650c12e


# ╔═╡ b1c8b2c4-4234-11eb-2f3a-27120018dd90
md"

**`OPTICAL DEPTHS A RELATIVE DISPLACEMENT x AWAY FROM LINE CENTER`** are related to the **`LINE CENTER OPTICAL DEPTH`** $\boxed{\tau_\mathrm{o}}$ by

$\boxed{\tau = \tau_\mathrm{o} \ \varphi(x)}$

"

# ╔═╡ df78508e-4233-11eb-2b41-b9496b2b6aba
center_optical_depth = 100

# ╔═╡ dac8b652-4233-11eb-23e8-a9e829253b8d
τo = center_optical_depth

# ╔═╡ 294d9c5e-4232-11eb-0aee-c7c22ad6d36e
optical_depth_displaced(τo,Voigt) = τo*Voigt

# ╔═╡ 0779c330-4234-11eb-2e28-374080d859b4
τ = optical_depth_displaced(τo,Voigt)

# ╔═╡ 8239d1b8-4235-11eb-0639-efcbffca6299


# ╔═╡ 8326694c-4235-11eb-3ace-73dcfaa2a010
md"
## 5.4 The Einstein coefficients

The **`DIMENSIONLESS OSCILLATOR STRENGTH`**, $\boxed{gf}$ is related to the **`TRANSITION PROBABILITY`** $\boxed{A_{u,l} \ [s^{-1}]}$ by

$\boxed{g_lf_{abs}=\frac{m \ c \ \lambda_ {\mathrm{cm}}^2}{8 \ \pi^2 \ q_e^2} \ g_u \ A_{u,l}}$
 
$\boxed{g_lf_{abs}=1.4992 \ g_u \ A_{u,l}  \ \lambda_ {\mathrm{cm}}^2}$

where $\boxed{f_{abs}}$ is the **`ABSORPTION OSCILLATOR STRENGTH`**.

That way, we can combine the equations seen in this Pluto.jl notebook to get different expresions relating the **`TRANSITION PROBABILITY`** $\boxed{A_{u,l}}$, **`ABSORPTION CORSS SECTION`** $\boxed{\alpha_{nu}}$, **`ABSORPTION OSCILLATOR STRENGTH`**, $\boxed{f_{abs}}$, **`DOPPLER VELOCITY WIDTH`** $\boxed{\mathrm{v}_\mathrm{ \ Doppler}}$, etc. Such as:

$\boxed{f_{abs}=1.4992 \ \frac{g_u}{g_l} \ A_{u,l}  \ \lambda_ {\mathrm{cm}}^2}$

$\boxed{ A_{u,l} = \frac{f_{abs}}{1.4992} \ \frac{g_l}{g_u} \ \lambda_ {\mathrm{cm}}^{-2}}$

$\boxed{\alpha_{\nu} = 2.24484 \times 10 ^{-2} \ A_{u,l}  \ \lambda_ {\mathrm{cm}}^3 \frac{g_u}{g_l} \ \frac{\varphi_{\nu}(x)}{\mathrm{v}_\mathrm{ \ Doppler}} \ [\mathrm{cm}^2]}$

"

# ╔═╡ 0993d1a2-4238-11eb-1e43-9918fbd8b9e0


# ╔═╡ Cell order:
# ╟─24f93ad2-3b57-11eb-3aff-7964ec8e894a
# ╟─da7393f6-3b59-11eb-2aed-4d327edeb345
# ╟─df1a21c6-3b5a-11eb-3b57-756ae2eb251a
# ╟─f0ada102-3be5-11eb-2f6a-d77bf434a7e5
# ╟─df8d4dd6-3be6-11eb-0d1d-cda97c11c343
# ╟─6683e03a-3be6-11eb-0276-150b8856697f
# ╟─9d73b22a-3be6-11eb-3b54-1714e19b250c
# ╟─41ae4c22-3c03-11eb-2374-4da29bb8c418
# ╟─a94070d2-3c09-11eb-22fe-776f72d0035a
# ╟─47d760f4-40c2-11eb-37ad-279f3504f746
# ╟─57fed056-3c0e-11eb-056c-37f7b45ae745
# ╟─7097507e-3c0a-11eb-0e6c-c96b22de9c71
# ╟─d664b216-3c0a-11eb-0399-4b10b37dabf4
# ╟─490dc08e-40be-11eb-1ee3-7526cbcc6c45
# ╟─4b8b2b70-40ba-11eb-350b-971e7040f47c
# ╟─9582d11a-40c9-11eb-3476-cbafd81d7973
# ╟─9583b364-40c9-11eb-257c-3f2d926a3a91
# ╟─95e6bbd8-40c6-11eb-0851-9779c5789838
# ╟─87e2a4fc-40c6-11eb-37b8-d3a434c3465c
# ╟─4150c22e-4235-11eb-3079-1549a7209d3a
# ╟─55241024-4228-11eb-0391-f90756271892
# ╟─3c737760-4235-11eb-1be8-79b212f9f6eb
# ╟─c7ddac9e-40b6-11eb-37f5-716ef3b2db5e
# ╟─8cf72bda-40ca-11eb-0ab7-fdb3f1c916f9
# ╟─05ac39ce-4235-11eb-201a-0bcb6612d928
# ╟─89bc8eb8-422a-11eb-036b-0fd5e71e75b5
# ╠═ea76aaba-4232-11eb-23ec-abb60f290167
# ╠═2d51fb46-4233-11eb-16d2-d901efddf3db
# ╟─0804d794-4235-11eb-1ff8-43557d6de7ad
# ╟─a19b1b74-4234-11eb-2041-a9c728c0d4ac
# ╠═39a86a4c-4233-11eb-1c34-1be5c9b5d4f7
# ╠═fd96acd0-4232-11eb-38bf-ff83f01d94f2
# ╠═da2132aa-4234-11eb-2b2d-d90d38979a2f
# ╠═e06b358e-4234-11eb-0202-fb8f1315d0d2
# ╟─150d054c-4235-11eb-3df3-4138d650c12e
# ╟─b1c8b2c4-4234-11eb-2f3a-27120018dd90
# ╠═df78508e-4233-11eb-2b41-b9496b2b6aba
# ╠═dac8b652-4233-11eb-23e8-a9e829253b8d
# ╠═294d9c5e-4232-11eb-0aee-c7c22ad6d36e
# ╠═0779c330-4234-11eb-2e28-374080d859b4
# ╟─8239d1b8-4235-11eb-0639-efcbffca6299
# ╟─8326694c-4235-11eb-3ace-73dcfaa2a010
# ╟─0993d1a2-4238-11eb-1e43-9918fbd8b9e0

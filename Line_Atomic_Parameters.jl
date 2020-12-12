### A Pluto.jl notebook ###
# v0.12.12

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
	
	using Plots
	
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

# ╔═╡ df1a21c6-3b5a-11eb-3b57-756ae2eb251a
# Filling Factor
f(r) = r^3

# ╔═╡ da7393f6-3b59-11eb-2aed-4d327edeb345
# Optical Depth 
dτ_AB(αν,nA,nB,gA,gB,r) = αν*(nB-nA*gB/gA)*f(r) 

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

$\boxed{f(v) = 4\pi \left(\frac{m}{2\pi kT}\right)^{\frac{3}{2}}v^2 e^{\frac{-mv^2}{2kT}}}$
"

# ╔═╡ 57fed056-3c0e-11eb-056c-37f7b45ae745
md"Temperature: $(@bind T1111 MySlider(0:10, 0.01)) K"

# ╔═╡ 7097507e-3c0a-11eb-0e6c-c96b22de9c71
begin

t,v = Maxwellian_Distribution(T1111)
ta,va = Maxwellian_Distribution(T1111)
end

# ╔═╡ d664b216-3c0a-11eb-0399-4b10b37dabf4
begin 
	plot(v,t,label="T=$T1111")
	plot!(va,ta,label="T=$T1111")
	xlabel!("Velocity")
	ylabel!("Thermal Distribution")
	xlims!((0,10))
	ylims!((0,120))
end

# ╔═╡ Cell order:
# ╟─24f93ad2-3b57-11eb-3aff-7964ec8e894a
# ╠═da7393f6-3b59-11eb-2aed-4d327edeb345
# ╠═df1a21c6-3b5a-11eb-3b57-756ae2eb251a
# ╟─f0ada102-3be5-11eb-2f6a-d77bf434a7e5
# ╠═df8d4dd6-3be6-11eb-0d1d-cda97c11c343
# ╠═6683e03a-3be6-11eb-0276-150b8856697f
# ╠═9d73b22a-3be6-11eb-3b54-1714e19b250c
# ╟─41ae4c22-3c03-11eb-2374-4da29bb8c418
# ╟─a94070d2-3c09-11eb-22fe-776f72d0035a
# ╟─57fed056-3c0e-11eb-056c-37f7b45ae745
# ╟─7097507e-3c0a-11eb-0e6c-c96b22de9c71
# ╟─d664b216-3c0a-11eb-0399-4b10b37dabf4

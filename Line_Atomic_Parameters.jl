### A Pluto.jl notebook ###
# v0.12.18

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

# ╔═╡ 816dadd8-4288-11eb-2ee7-81dd43d2d9dc
begin
	using CSV
	using DataFrames
	using PlutoUI
	using Plots
	using PlotlyBase
	plotly()
end

# ╔═╡ 875420ea-4288-11eb-1251-2918c68f29ae
md"
### Packages
"

# ╔═╡ 24f93ad2-3b57-11eb-3aff-7964ec8e894a
md"
# 5 Line Atomic Parameters

## 5.1 Overview

To **describe how matter and light interact** we need to understand many **atomic physics quantits** and how they are related to one another.

## 5.2 Line Absorption

This is seen in the spectra when material between the source of light and the observer absorbs some of the light.
### 5.2.1 Line optical depths
Imagine we have a transition from an upper level **u**, to a lower level **l**.

The **`OPTICAL DEPTH`**, $\boxed{dτ_{l,u}}$, for such transition is given by:

$\boxed{dτ_{l,u}=α_{ν}\left(n_l-n_u \ \frac{g_l}{g_u}\right) \ f(r) \ dr } \ \ \ (1)$

 $\boxed{f(r)}$ is the **filling factor**

 $\boxed{\alpha_ν}$ is the atomic **absorption cross section** [cm$^2$]

The term in parenthesis is the **population** [cm$^3$] of the lower level, with correction for **stimulated emission**. This term is the only place where **stimulated emission** enters in the **radiative balance** equations.
"

# ╔═╡ 59d32bb8-42ec-11eb-3e86-b1057be05172
filling_factor(r) = r^3

# ╔═╡ 3aa2f1d8-42ec-11eb-163a-a5a17e9c9072
f = filling_factor(1)

# ╔═╡ da7393f6-3b59-11eb-2aed-4d327edeb345
optical_depth(αν,nu,nl,gu,gl,fr) = αν*(nl-nu*gl/gu)*fr 

# ╔═╡ 1652fc4c-42ec-11eb-1ca8-8509b1589380
dτ_lu = optical_depth(1,0,1,1,1,f)

# ╔═╡ a56a6b1c-4246-11eb-18d5-bf0c5e519018


# ╔═╡ f0ada102-3be5-11eb-2f6a-d77bf434a7e5
md"
### 5.2.2 Oscillator Strength



**What is it?** It is a **dimensionless number** of order unity.
	
**What is its concept?** It can be thought of as a **correction factor** to make the expression for a classical oscillator agree with the quantum mechanical value.
	
**What other line parameters are related to it?** Many, such as the **absorption coefficient** and the **transition probability**.
	
There are two Oscillator Strenght Coefficients, the **`ABSORPTION OSCILLATOR STRENGTH COEFFICIENT`** $\boxed{f_{{l,u}} = f_{\mathrm{absorption}}}$, and the  **`EMISSION OSCILLATOR STRENGTH COEFFICIENT`** $\boxed{f_{{u,l}} = f_{\mathrm{emision}}}$ 
	
And are related by:
	
$\boxed{g_l \ f_{l,u} = - \ g_u \ f_{u,l}} \ \ \ (2)$

**$\boxed{g}$**'s are the **statistical weights**.

The convention is that emission lines have negative oscillator strength.

"

# ╔═╡ 3601f4a6-4246-11eb-247d-891777c4f0ac


# ╔═╡ 34e9501c-4246-11eb-2004-43b848503e9a
md"

### 5.2.3 Absorption Cross Section

The **`VOIGT FUNCTION`**, $\boxed{\varphi(x)}$, 

> **Voigt Function**: Is a probability distribution given by a convolution of a Cauchy-Lorentz distribution and a Gaussian distribution. It is often used in analyzing data from spectroscopy or diffraction.

the **`RELATIVE LINE DISPLACEMENT`** , $\boxed{x \ \equiv \ \frac{\nu \ - \ \nu_o}{\Delta\nu_\mathrm{Doppler}}}$,

> With this definition of the **relative line displacement**, the **line profile** due to **thermal motions** alone is $\boxed{e^{-x^2}}$.

the **`WAVELENGTH IN CENTIMETERS`**  $\boxed{\lambda_\mathrm{cm}}$, and the **`DOPPLER VELOCITY WIDTH`**  $\boxed{v_\mathrm{Doppler} \ [\mathrm{cm} \ \mathrm{s}^{-1}]}$, 

> The point where the line profile falls to $\boxed{\frac{1}{e}}$ of its peak.

will be seen later.
	
Wright now, what is important to hightlight is that the **`LINE CENTER ABSORPTION CORSS SECTION`**, $\boxed{\alpha_{\nu} \ [\mathrm{cm}^2]}$, is related with the **`ABSORPTION OSCILLATOR STRENGTH COEFFICIENT`**, $\boxed{f_{\mathrm{absorption}}}$, by:

$\boxed{\alpha_{\nu} = \frac{\sqrt{\pi} \ q_e^2 \ \lambda  \ f_{\mathrm{absorption}} \  \varphi_{\nu}(x)}{m_e \ c \ v_\mathrm{Doppler}}\ \ [\mathrm{cm}^2]}\ \ \ (3.a)$

$\boxed{\alpha_{\nu}= 149.74 \ f_{\mathrm{absorption}} \ \frac{\lambda_{\mathrm{cm}}}{v_{\mathrm{Doppler}}} \ \varphi_{\nu}(x) \ \ [\mathrm{cm}^2]}\ \ \ (3.b)$

"

# ╔═╡ df8d4dd6-3be6-11eb-0d1d-cda97c11c343
absorption_cross_section(Voigt,f_absorption,λ,v_Doppler,ν,νo,Δν_Doppler) = 149.74*f_absorption*λ/v_Doppler*Voigt

# ╔═╡ 5ddc5df2-4246-11eb-1a3f-751eb48b06ea
αν = absorption_cross_section(1,1,1,1,1,1,1)

# ╔═╡ 4cc7b320-4246-11eb-3896-1d9eb3af6146


# ╔═╡ 41ae4c22-3c03-11eb-2374-4da29bb8c418
md"
## 5.3 The Line Profile Function
### 5.3.1 Velocities in a thermal distribution
The dimensionless velocity distribution function for a Maxwellian distribution is
given by

$\boxed{f(v) = 4\pi \left(\frac{m}{2\pi kT}\right)^{\frac{3}{2}}v^2 e^{\frac{-mv^2}{2kT}}} \ (4)$ 
"

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

The **`COEFFICIENT FOR INDUCED EMISSION`**, $\boxed{B_{ul}}$ is related to the **`TRANSITION PROBABILITY`** $\boxed{A_{ul}}$ by the **`PAHSE SPACE FACTOR`** given by $\boxed{\frac{2h\nu ^3}{c^2}}$;

$\boxed{A_{u,l}=\frac{2h\nu ^3}{c^2} B_{u,l} \ [\mathrm{s}^{-1}]}$

And the **`INDUCED EMISSION PROBABILITY`** $\boxed{gu \ B_{u,l}}$ and the **`INDUCED ABSORPTION PROBABILITY`** $\boxed{gl \ B_{l,u}}$ are related by

$\boxed{g_l \ B_{l,u} = g_u \ B_{u,l}}$

The  **`ABSORPTION CORSS SECTION`**, $\boxed{\alpha_{\nu}}$, is related to  **`??????`**, $\boxed{B_{l,u}}$, by

$\boxed{\alpha_{\nu}=\frac{h \ c}{4 \ \pi^{3/2}}\frac{B_{l,u}}{v_{\mathrm{Doppler}}}\varphi_{\nu}(x) \ [\mathrm{cm}^2]}$

In these terms the **`OPTICAL DEPTH INCREMENT`**, $\boxed{d\tau_{l,u}}$,is given by

$\boxed{d\tau_{l,u}=\frac{h \ c}{4 \ \pi^{3/2}}\frac{B_{l,u}}{v_{\mathrm{Doppler}}}\varphi_{\nu}(x)\left(n_l-n_u\frac{g_l}{g_u}\right)f(r)dr}$
"

# ╔═╡ b7ad29b0-423c-11eb-0e69-e974b103458b


# ╔═╡ 09e2993c-42f0-11eb-06a8-dfca1bdfc019
md"
## 5.5 Continumm pumping

### 5.5.1 Photon occupation number

The **`INTENSITY`**,  $\boxed{I_{\nu}}$ of a **radiation field** can be thought of as two parts, the **`AVAILABLE VOLUME OF PHASE SPACE`**, $\boxed{\frac{2 \ h \ \nu^3}{c^2}}$, and a **`DIMENSIONLESS OCCUPATION NUMBER GIVING THE FRACTION OF THE SPACE THAT IS FILLED`**, $\boxed{\eta}$. 

> **Ocupation numbers** can be larger than unity for photons, which are **Bose-Einstein particles**.

For reference, the **`PLANCK FUNCTION`** is given by

$\boxed{B_{\nu}=I_{\nu}=\frac{F_{\nu}}{\pi}=\frac{2 \ h \ \nu^3}{c^2}\frac{1}{\exp(\frac{\mathrm{h} \ \nu}{\mathrm{k_B} \ T})-1} \ [\mathrm{erg \ cm^{-2} \ s^{-1} \ Hz^{-1} \ sr^{-1}} ]}$

where $\boxed{F_{\nu}}$ is **`THE SINGLE-HEMISPHERE EMITTANCE FROM AN OPAQUE SURFACE.`**
 
The **`PHOTON OCCUPATION NUMBER OF A BLACKBODY`** is

$\boxed{\eta_{\nu}=\frac{1}{\exp(\frac{\mathrm{h} \ \nu}{\mathrm{k_B} \ T})-1}}$

The **`DIMENSIONLESS OCCUPATION NUMBER`** $\boxed{\eta_\nu}$  **`FOR ANY CONTINUUM WITH A MEAN INTENSITY`** $\boxed{J_{\nu} \ [\mathrm{erg \ cm^{-2} \ s^{-1} \ Hz^{-1} \ sr^{-1}} ]}$ **`AT A FREQUENCY`** $\boxed{\nu}$ is defined as

$\boxed{\eta_{\nu}\equiv\frac{J_{\nu}}{\frac{2 \ h \ \nu^3}{c^2}}=\frac{1}{\exp(\frac{\mathrm{h} \ \nu}{\mathrm{k_B} \ T_\mathrm{excitation}})-1}}$

Where $\boxed{T_\mathrm{excitation}}$ is the **`EXCITATION TEMPERATURE OF THE CONTINMMUM AT THE FREQUENCY`**.
"

# ╔═╡ 85e4d3f8-43ed-11eb-1b69-65b3047c1d11


# ╔═╡ 725e7970-43e2-11eb-3944-b576fdc4f08b
c_light = 2.99e10 # Light Velocity [cm s^-1]

# ╔═╡ 2f62d794-43de-11eb-3c35-abd4c3f1d582
h_Planck = 6.626e-27 # Plank's Constant [erg s^-1]

# ╔═╡ 53d07d9e-43df-11eb-3436-53f8032ce66f
k_Boltzman = 1.381e-16 # Boltzman's Constant [erg K^-1]

# ╔═╡ 8443944c-43ed-11eb-0b7d-e7baa044d2ba


# ╔═╡ 4cbfa2f8-43e1-11eb-1d88-319d38af6365
md"**`EXCITATION FREQUENCY`**: $(@bind νo MySlider(1e10:1e18,1e10)) Hz"

# ╔═╡ 9a32422c-43eb-11eb-029d-d9b1245f0692
md"**`FREQUENCY`**: $(@bind ν MySlider(1e10:1e18,1e10)) Hz"

# ╔═╡ 833223d6-43ed-11eb-122e-d129afb9df33


# ╔═╡ 4e25d73a-43e2-11eb-3a5c-47c259346605
# I'm not sure abaout this cell.
excitation_temperature(νo)=h_Planck*νo/k_Boltzman

# ╔═╡ d82de736-43e2-11eb-352f-3b5759becf95
T_excitation = excitation_temperature(νo) # K

# ╔═╡ f0cef5a0-43dd-11eb-0ba8-714473a60998
dimensionless_occupation_number_of_a_blackbody(ν,T_excitation)=1/(exp((h_Planck*ν)/(k_Boltzman*T_excitation)))

# ╔═╡ b230d436-43eb-11eb-2bd2-9df1cc168ee6
ην = dimensionless_occupation_number_of_a_blackbody(ν,T_excitation)

# ╔═╡ 0993d1a2-4238-11eb-1e43-9918fbd8b9e0


# ╔═╡ 96b4a50e-43dd-11eb-3b2a-83dad1d169f9
md"
### 5.5.2 Pumping rates

>> **Continuum pumping:** Is the rate of induced radiative excitation by continuum photos. 

**`CONTINUUM PUMPING`** $\boxed{r_{l,u}}$ is given by:

$\boxed{r_{l,u} = n_l \ B_{l,u} \ J_{l,u}} \ (156)$

$\boxed{r_{l,u} = n_l \ A_{u,l} \ \frac{J_{l,u}}{\frac{2 \ h\ \nu^3}{c^2}} \ \frac{g_u}{g_l}} \ (156)$

$\boxed{r_{l,u} = n_l \ A_{u,l} \ \eta_c \ \frac{g_u}{g_l} \ [\mathrm{cm}^{-3} \ \mathrm{s}^{-1}]} \ (156)$

Where $\boxed{\eta_{c}}$ is the **`DIMENSIONLESS CONTINUUM OCCUPATION NUMBER AT THE LINE ENERGY`**.

The **`RATE OF INDUCED RADIATIVE DE-EXCITATION`**, $\boxed{r_{u,l}}$, is related by detailed balance and is given by

$\boxed{r_{u,l}=r_{l,u} \ \frac{g_l}{g_u} \ [\mathrm{cm}^{-3} \ \mathrm{s}^{-1}]} \ (157)$

The **`OCUPATION NUMBER`** has the advantage that the Einstein B's do not enter any rate equations. All radiative rates can be expressed in terms of an A and $\eta$.

### 5.5.3 Optical depth effects
"

# ╔═╡ Cell order:
# ╟─875420ea-4288-11eb-1251-2918c68f29ae
# ╟─816dadd8-4288-11eb-2ee7-81dd43d2d9dc
# ╟─24f93ad2-3b57-11eb-3aff-7964ec8e894a
# ╠═59d32bb8-42ec-11eb-3e86-b1057be05172
# ╠═3aa2f1d8-42ec-11eb-163a-a5a17e9c9072
# ╠═da7393f6-3b59-11eb-2aed-4d327edeb345
# ╠═1652fc4c-42ec-11eb-1ca8-8509b1589380
# ╟─a56a6b1c-4246-11eb-18d5-bf0c5e519018
# ╟─f0ada102-3be5-11eb-2f6a-d77bf434a7e5
# ╟─3601f4a6-4246-11eb-247d-891777c4f0ac
# ╟─34e9501c-4246-11eb-2004-43b848503e9a
# ╠═df8d4dd6-3be6-11eb-0d1d-cda97c11c343
# ╠═5ddc5df2-4246-11eb-1a3f-751eb48b06ea
# ╟─4cc7b320-4246-11eb-3896-1d9eb3af6146
# ╟─41ae4c22-3c03-11eb-2374-4da29bb8c418
# ╠═a94070d2-3c09-11eb-22fe-776f72d0035a
# ╟─47d760f4-40c2-11eb-37ad-279f3504f746
# ╠═57fed056-3c0e-11eb-056c-37f7b45ae745
# ╠═7097507e-3c0a-11eb-0e6c-c96b22de9c71
# ╠═d664b216-3c0a-11eb-0399-4b10b37dabf4
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
# ╟─b7ad29b0-423c-11eb-0e69-e974b103458b
# ╟─09e2993c-42f0-11eb-06a8-dfca1bdfc019
# ╟─85e4d3f8-43ed-11eb-1b69-65b3047c1d11
# ╟─725e7970-43e2-11eb-3944-b576fdc4f08b
# ╟─2f62d794-43de-11eb-3c35-abd4c3f1d582
# ╟─53d07d9e-43df-11eb-3436-53f8032ce66f
# ╟─8443944c-43ed-11eb-0b7d-e7baa044d2ba
# ╟─4cbfa2f8-43e1-11eb-1d88-319d38af6365
# ╟─9a32422c-43eb-11eb-029d-d9b1245f0692
# ╟─833223d6-43ed-11eb-122e-d129afb9df33
# ╟─4e25d73a-43e2-11eb-3a5c-47c259346605
# ╟─d82de736-43e2-11eb-352f-3b5759becf95
# ╟─f0cef5a0-43dd-11eb-0ba8-714473a60998
# ╟─b230d436-43eb-11eb-2bd2-9df1cc168ee6
# ╟─0993d1a2-4238-11eb-1e43-9918fbd8b9e0
# ╟─96b4a50e-43dd-11eb-3b2a-83dad1d169f9

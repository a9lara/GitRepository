### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 86bbd69a-4a38-11eb-2c1a-13c6e4a44d08
md"
### **`2020-12-29 . 1`**

$\newline$

 $\eta = \frac{\# \ baryons}{\# \ photons}$

$\newline$

### **`2020-12-29 . 2`**

$\newline$

 $\Phi$: **`Photon flux`** $\rightarrow$ Is the **`energy of each photon times the number of photons that hit the surface per unit time`**.

 $I$: **`Intensity`** $\rightarrow$ Refers to the **`density of radiant power carried by the electromagnetic radiation`**, typically measured in $\frac{\mathrm{W}}{\mathrm{m}^2}$ 


 $\boxed{I = \frac{\mathrm{power}}{\mathrm{area}} = \frac{\mathrm{energy}}{\mathrm{area \times \mathrm{time}}} = \frac{\mathrm{photons}}{\mathrm{area \times \mathrm{time}}} \times \frac{\mathrm{energy}}{\mathrm{photons}} = \Phi \ E}$

The **`radiant power carried by the electromagnetic radiation`** is tipically measured in Watts (W). W is energy per time. Tipically using Joule (J) per second (s).

 $\mathrm{W} = \frac{\mathrm{J}}{\mathrm{s}}$

What would be the intensisty in your skin if you are 3 m away from a lightbulb of 40 W?

 $I = \frac{\mathrm{power}}{\mathrm{area}} = \frac{40 \mathrm{W}}{4 \ \pi r^2 } = \frac{40 \mathrm{W}}{4 \ \pi (3 \ \mathrm{m})^2 } = 0.353 \ \frac{\mathrm{W}}{\mathrm{m}^2}$ 

"

# ╔═╡ 836870c4-4a3c-11eb-3987-a1d9327ea172
intensity(radiant_power,distance)=radiant_power/(4*π*distance^2) 

# ╔═╡ 62966794-4a3d-11eb-357b-c76ddab5ecb0
intensity(40,3)

# ╔═╡ Cell order:
# ╟─86bbd69a-4a38-11eb-2c1a-13c6e4a44d08
# ╠═836870c4-4a3c-11eb-3987-a1d9327ea172
# ╠═62966794-4a3d-11eb-357b-c76ddab5ecb0

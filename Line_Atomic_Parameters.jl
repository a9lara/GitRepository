### A Pluto.jl notebook ###
# v0.12.12

using Markdown
using InteractiveUtils

# ╔═╡ 24f93ad2-3b57-11eb-3aff-7964ec8e894a
md"
# 5 Line Atomic Parameters

## 5.1 Overview
To **describe how matter and light intercact** we need to understand many **atomic physics quantits** and how they are related to one another.
## 5.2 Line Absorption
This is seen in the spectra when material between the source of light and the observer absorbs some of the light.
### 5.2.1 Line optical depths
Imagine we have a transition from an upper level **A**, to a lower level **B**.

The **optical depth** for such transition is given by:

$dτ_{A,B}=α_{ν}\left(n_B-\frac{n_Ag_B}{g_A}\right)f(r)$

**f(r)** is the **filling factor**

 **$\alpha_ν$** is the **atomic absorption cross section** [cm$^2$]

The term in parenthesis is the **population** [cm$^3$] of the lower level, with correction for **stimulated emission**. This term is the only place where **stimulated emission** enters in the **radiative balance** equations.
"

# ╔═╡ df1a21c6-3b5a-11eb-3b57-756ae2eb251a
f(r) = r^3

# ╔═╡ da7393f6-3b59-11eb-2aed-4d327edeb345
dτ_AB(αν,nA,nB,gA,gB,r) = αν*(nB-nA*gB/gA)*f(r) # optical depth

# ╔═╡ 33ef51bc-3b5b-11eb-28af-570947628a4d
dτ_AB(1,2,3,4,5,6)

# ╔═╡ 0ccdfc72-3b68-11eb-37db-55eab8ae9d36
md"
### 5.2.2 Oscillator Strength
**What is it?** It is a **dimensionless number** of order unity.

**What is its concept?** It can be thought of as a **correction factor** to make the expression for a classical oscillator agree with the quantum mechanical value.

**What other line parameters are related to it?** Many, such as the **absorption coefficient** and the **transition probability**.
"

# ╔═╡ Cell order:
# ╟─24f93ad2-3b57-11eb-3aff-7964ec8e894a
# ╠═da7393f6-3b59-11eb-2aed-4d327edeb345
# ╠═df1a21c6-3b5a-11eb-3b57-756ae2eb251a
# ╠═33ef51bc-3b5b-11eb-28af-570947628a4d
# ╟─0ccdfc72-3b68-11eb-37db-55eab8ae9d36

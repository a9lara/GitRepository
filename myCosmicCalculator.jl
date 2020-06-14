function cosmicTime(z)


Ho=69.6 
h = Ho/100.
Ωr = 4.165e-5/(h*h)    
Ωm=0.286
ΩΛ=0.714

n=1000
age=0
az=(1/(1+z))

    
    for i in 1:1000
    	
        a= az*((i+0.5)/n)
        adot=sqrt((Ωr/a^2)+(Ωm/a)+(1-Ωm-Ωr-ΩΛ)+(ΩΛ*a^2))
        age=age+1/adot 
        
    end
    zage=az*age/n
    zage_Gyr=(977.8 /Ho)*zage
    zage_Gyr=round(zage_Gyr,digits=9)
    print("$zage_Gyr Gyrs")


end



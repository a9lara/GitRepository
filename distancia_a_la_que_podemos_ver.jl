function distancia_máxima_a_la_que_podemos_ver_un_objeto_que_mide_x_metros(x)
           x = x/2
           ca = x/0.00014539
           ca = ca/1000
           ca = round(ca, digits = 3)        
           if ca < 1 
               ca = ca*1000
               println("Puedes ver ese objeto hasta $ca m de distancia.")
           elseif ca > 1 
               println("Puedes ver ese objeto hasta $ca km de distancia.")
           end
       end


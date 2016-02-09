#Método Newton-Raphson

#Es un método para aproximar la solución de una ecuación de una sola
#variable por medio de la aproximación de su derivada y con un punto fijo,
#cercano a la raíz.

#f=Función previamente definida en consola (use el siguiente comando en consola "f = @(x)(escriba aquí su función)"); 
#ff=derivada analítica de la función f (difinida previamente con el mismo comando anterior); 
#a=punto cercano a la raíz; e=margen de error; n=numero de
#iteraciones maximo permitido

#El ingreso de datos es de la forma np(f,ff,a,e,n)
#
#by Francisco Peña Gallardo (Peñovsky Freeman) 
#UMSNH
#

PHI=2.63391579
MM=6.08198200
e=0.00001
n=1000
f(x)=x^3/6+x^5/120+x^7/5040+x^9/362880-MM
ff(x)=3*x^2/6+5*x^4/120+7*x^6/5040+9*x^8/362880-MM
a=PHI

function PolyRoot(f,ff,a,e,n)

print("Método de Newton-Raphson\n");


x0=a;
i=0;
error=1;

    
    while error>=e || i==n
        
        f0=f(x0);
        f1=ff(x0);
        
        x1=x0-(f0/f1);
                
        i=i+1;
        
        error=abs((x1-x0)/x1);
        
        
        if f(x1)==0
           
            return
        end
        
        x0=x1;
    end
    
    print("La raiz del polinomio es $x0");


end

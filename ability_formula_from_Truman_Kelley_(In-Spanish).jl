begin
	"""
	
		capacidad(fiabilidad,resultado_individual,resultado_del_grupo) -> Float64
		
	En 1947, Truman Kelley, profesor de Harvard, publicó una fórmula que estima la capacidad a partir del desempeño. Explicó que la predicción de la capacidad de una persona es un promedio ponderado del desempeño individual y el desempeño promedio del grupo al que pertenece la persona.
	fiabilidad: medida de la consistencia del desempeño de una persona. 0% indica completamente random. 100% indica completamente consistente.
		Es la correlación `r` que ya habíamos visto.
	capacidad: se puede pensar como el `resultado verdadero` de la persona bajo circunstancias óptimas.		
	Imaginemos que tenemos un artículo de portada de Sports Illustrated que es un jugador de béisbol con un promedio de bateo actual de 0.357. Si el promedio de bateo de la MLB es 0.255 y la correlación de año a año para el promedio de bateo es 0.41, ¿cuál es la capacidad estimada del jugador de portada?

	(0.41)(0.357)+(0.59)(0.255) = 0.297
		
		
	# Example:
	```jldoctest
	julia> capacidad(0.41,0.357,0.255)
	0.297
		
	julia> capacidad(0.5,0.5,0)
	0.25
	```
	"""		
	function capacidad(fiabilidad,resultado_individual,resultado_del_grupo)
		c = fiabilidad*resultado_individual + (1-fiabilidad)*resultado_del_grupo
	end
end



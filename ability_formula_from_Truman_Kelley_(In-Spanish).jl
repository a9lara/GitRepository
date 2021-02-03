# En 1947, Truman Kelley, profesor de Harvard, publicó una fórmula que estima la capacidad a partir del desempeño. Explicó que la predicción de la capacidad de una persona es un promedio ponderado del desempeño individual y el desempeño promedio del grupo al que pertenece la persona.

# fiabilidad: medida de la consistencia del desempeño de una persona. 0% indica completamente random. 100% indica completamente consistente.

# capacidad: se puede pensar como el "resultado verdadero" de la persona bajo circunstancias óptimas.

capacidad(fiabilidad,resultado_individual,resultado_del_grupo)=fiabilidad*resultado_individual + (1-fiabilidad)*resultado_del_grupo
	

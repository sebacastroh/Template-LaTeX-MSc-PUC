# Template-LaTeX-MSc-PUC
## Descripción
El template <i>Thesis.tex</i> y la clase <i>pucthesis.cls</i> han sido diseñados para facilitar la labor de escritura de tesis del Magister en Ciencias de Ingeniería de la Pontificia Universidad Católica de Chile.

El formato del template cumple con las especificaciones de Bibliotecas UC (<url>http://sibuc.uc.cl</url>).

Deseo remarcar que este template **no es oficial**, aunque su función es corregir el oficial del SIDING. Hasta el momento ninguna tesis ha sido rechazada por utilizar este formato (hasta Marzo de 2015 se ha probado con 4 estudiantes). Hay que informar, eso sí, que en el DIPEI al parecer no están completamente actualizados con el formato, pues siempre alegan con respecto a la sangría presente en la bibliografía. Sin embargo, cuando se les dice que en Bibliotecas UC especifican que ese es el formato APA, aceptan. Ojalá pronto se actualicen.

## Pasos de compilación:

Las instrucciones son muy simples:

1. Compilar Thesis.tex con pdflatex o similar
2. Compilar Thesis.bib con bibtex
3. Compilar dos veces Thesis.tex con pdflatex o similar

Otra alternativa, que no he probado pero que supuestamente ahorra todos los pasos antes descritos, es utilizar [`latexmk`](http://tex.stackexchange.com/a/249243/49596) 

El template llama a los paquetes fundamentales para generar correctamente la tesis.

## Preguntas frecuentes

- A veces el título de la tesis es bastante largo y hay elementos de las primeras páginas que se pasan a las siguientes. Para corregir eso agregué una opción que permite ajustar el espacio antes y después del título. Un poco antes de empezar el documento hay unas líneas comentadas con la explicación apropiada.

## Comentarios adicionales

- Esta clase no fue escrita totalmente por mí. Me basé en el trabajo del profesor Miguel Torres, de la PUC, aunque modifiqué muchas líneas. De todas formas, deseo dejar en claro que sin su trabajo previo no podría haber generado este archivo.
- Lean atentamente el archivo *Thesis.tex*, vean cómo se llaman a los capítulos. Noten que los apéndices se consideran como secciones, no como capítulos. Tuve que hacer esto para que el TOC quedara bien (una larga historia)
- Por defecto el template está en inglés y con pdflatex, pero ustedes pueden escoger la opción español y/o desactivar el pdflatex si utilizan imágenes de formato PS o EPS.

Espero les sea de mucha utilidad, cualquier problema escriban en el apartado Issues, no me escriban a mi correo por favor. Estoy seguro que la duda de uno es la duda de varios.

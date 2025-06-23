# Material Complementario: Segmentación Automática de Lesiones de Melanoma en Imágenes Dermatoscópicas

Junio de 2025

La estructura que tiene el proyecto es la siguiente:

├── README.md
├── images
│   ├── image_01.jpg
│   ├── image_02.jpg
│   ├── image_03.jpg
│   ├── image_04.jpg
│   ├── image_05.jpg
│   └── image_06.jpg
└── code
    ├── active_contours.m
    ├── attack_strength.m
    ├── extract_largest_element.m
    ├── grow_cut.m
    ├── grow_cut_algorithm.m
    ├── main.m
    ├── make_growcut_mask.m
    ├── otsu_binarization.m
    ├── remove_dermatoscope_values.m
    └── remove_hair.m

Dentro del directorio 'images' se adjuntan seis imágenes de ejemplo para probar los algoritmos. El documento 'main.m' en el directorio 'code' es el archivo ejecutable, basta con modificar la variable 'image_path' para cambiar la imagen, y la variable 'segmentation_model' para el método con el que se segmentará (0 para contornos activos y 1 para crecimiento de corte).

Por ejemplo, si se quisiera segmentar la imagen 'image_02' con el algoritmo de contornos activos, las variables deberán estar declaradas de la siguiente manera:

```
image_path = '../images/image_02.jpg';
segmentation_model = 0;
```

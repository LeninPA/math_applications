# Tarea-examen 1
## Simulación estocástica

En este repositorio se encuentra el código para reproducir los resultados de los tres problemas de la tarea-examen 1 de simulación estocástica

## Uso e instalación

Se requiere hacer uso de [uv](https://docs.astral.sh/uv/) para manejar la paquetería del proyecto. Posterior a su instalación se los scripts de Python (como `main.py`) se tienen que ejecutar de la siguiente manera:

```shell
uv run main.py
```

## Organización del código

- `data/`: directorio donde se encuentran los datos usados para el problema 2 y 3
- `gcl.py`: Script de Python que contiene el código para generar un generador congruencial lineal de números psudoaleatorios
- `test.py`: Script de Python que contiene la prueba estadística de Kolmogorov-Smirnof

# -*- coding: utf-8 -*-
"""
Tarea 2: Modelo de Lorenz-63 y Matrices de Covarianza
"""

# ============================================================
# Imports
# ============================================================

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from scipy.integrate import odeint


# ============================================================
# Sistema Lorenz-63
# ============================================================

def lorenz63(state, t, params):
    """
    Calcula la derivada del sistema Lorenz-63.

    Parameters
    ----------
    state : list or array
        Vector [x, y, z].
    t : float
        Tiempo actual.
    params : list or array
        Parámetros [sigma, rho, beta].

    Returns
    -------
    list
        Derivadas [dx/dt, dy/dt, dz/dt].
    """
    x, y, z = state
    sigma, rho, beta = params

    dxdt = sigma * (y - x)
    dydt = x * (rho - z) - y
    dzdt = x * y - beta * z

    return [dxdt, dydt, dzdt]


# ============================================================
# Métodos Runge-Kutta
# ============================================================

def rk4_step(state, h, t, params):
    """
    Calcula un paso del método de Runge-Kutta 4.

    Parameters
    ----------
    state : array
        Estado previo [x, y, z].
    h : float
        Paso de tiempo.
    t : float
        Tiempo actual.
    params : list
        Parámetros [sigma, rho, beta].

    Returns
    -------
    array
        Estado siguiente.
    """
    k1 = np.array(lorenz63(state, t, params))
    k2 = np.array(lorenz63(state + h / 2 * k1, t, params))
    k3 = np.array(lorenz63(state + h / 2 * k2, t, params))
    k4 = np.array(lorenz63(state + h * k3, t, params))

    return state + h / 6 * (k1 + 2*k2 + 2*k3 + k4)


def rk4_solve(state0, t, params):
    """
    Resuelve Lorenz-63 usando RK4 para todos los tiempos.

    Parameters
    ----------
    state0 : list or array
        Condición inicial.
    t : array
        Arreglo de tiempos.
    params : list
        Parámetros del sistema.

    Returns
    -------
    array
        Trayectoria completa Nx3.
    """
    sol = np.zeros((len(t), 3))
    sol[0] = state0

    for i in range(len(t) - 1):
        h = t[i + 1] - t[i]
        sol[i + 1] = rk4_step(sol[i], h, t[i], params)

    return sol


# ============================================================
# Utilidades de graficación
# ============================================================

def plot_attractor(solution, title="Atractor de Lorenz"):
    """
    Grafica un atractor 3D del sistema Lorenz-63.

    Parameters
    ----------
    solution : array
        Matriz Nx3 con la solución.
    title : str
        Título del gráfico.
    """
    fig = plt.figure()
    ax = fig.add_subplot(111, projection="3d")

    x, y, z = solution[:, 0], solution[:, 1], solution[:, 2]
    ax.plot(x, y, z)

    ax.set_title(title)
    plt.show()


# ============================================================
# Matrices de Covarianza y Correlación
# ============================================================

def compute_cov_corr(samples):
    """
    Calcula matrices de covarianza y correlación.

    Parameters
    ----------
    samples : array
        Muestras Nx3.

    Returns
    -------
    tuple
        (covarianza, correlación)
    """
    cov = np.cov(samples.T)
    corr = np.corrcoef(samples.T)
    return cov, corr


def plot_heatmap(matrix, labels, title):
    """
    Muestra un mapa de calor para una matriz.

    Parameters
    ----------
    matrix : array
        Matriz cuadrada.
    labels : list
        Etiquetas de ejes.
    title : str
        Título del mapa.
    """
    plt.figure(figsize=(6, 5))
    sns.heatmap(matrix, annot=True, fmt=".2f", xticklabels=labels,
                yticklabels=labels, cmap="coolwarm", square=True)
    plt.title(title)
    plt.tight_layout()
    plt.show()


# ============================================================
# Ejecución principal
# ============================================================

def main():
    """Ejecuta todos los experimentos de la tarea."""
    # Condiciones iniciales
    state0 = [-10, -10, 20]

    # Parámetros estándar
    sigma = 10
    rho = 28
    beta = 8 / 3
    params = [sigma, rho, beta]

    # Tiempo para la integración
    t = np.linspace(0, 50, 10_000)

    # Resolver ODEINT
    sol = odeint(lorenz63, state0, t, args=(params,))
    plot_attractor(sol, "Atractor Lorenz (ODEINT)")

    # Variación de sigma
    sigmas = [10, 15, 5, 2.5]
    for s in sigmas:
        params_s = [s, rho, beta]
        sol_s = odeint(lorenz63, state0, t, args=(params_s,))
        plot_attractor(sol_s, f"Atractor Lorenz (sigma={s})")

    # RK4
    for s in sigmas:
        params_s = [s, rho, beta]
        sol_rw = rk4_solve(state0, t, params_s)
        plot_attractor(sol_rw, f"Atractor RK4 (sigma={s})")

    # Sol largo para matrices
    t_long = np.linspace(0, 1000, 100_000)
    sol_long = rk4_solve(state0, t_long, params)

    # Muestras cada n pasos
    freqs = [5, 10, 15, 20, 25, 30]
    labels = ["X", "Y", "Z"]

    for f in freqs:
        samples = sol_long[::f]
        cov, corr = compute_cov_corr(samples)

        alpha = 2.0 / np.max(np.diag(cov))
        B_final = cov * alpha

        print(f"\n=== Frecuencia {f} ===")
        print("Covarianza:\n", cov)
        print("Correlación:\n", corr)
        print("Alpha:", alpha)

        plot_heatmap(cov, labels, f"Covarianza (cada {f} pasos)")
        plot_heatmap(corr, labels, f"Correlación (cada {f} pasos)")

    print("\nEjecución completa.")


# Punto de entrada
if __name__ == "__main__":
    main()


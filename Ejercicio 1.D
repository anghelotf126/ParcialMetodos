import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import CubicSpline

# 1. DATOS EXPERIMENTALES
f = np.array([100, 120, 145, 170, 200, 235, 270, 310, 355, 405, 460, 520, 585, 
              655, 730, 810, 895, 985, 1080, 1180, 1290, 1410, 1540, 1680, 
              1830, 1990, 2160, 2340, 2530, 2730], dtype=float)

Z = np.array([152.3, 149.1, 146.8, 144.9, 142.0, 139.5, 137.9, 136.1, 134.8, 
              133.6, 132.7, 131.9, 131.4, 131.1, 130.9, 131.0, 131.3, 131.9, 
              132.7, 133.8, 135.2, 136.9, 138.9, 141.1, 143.5, 146.1, 149.0, 
              152.2, 155.6, 159.2], dtype=float)

f_fino = np.linspace(f[0], f[-1], 1000)
cs = CubicSpline(f, Z, bc_type='natural')

# 2. DEFINICIÓN DE FRONTERAS Y RAÍCES EXACTAS REFINADAS
r1, r2, Z_th = 113.1118, 2212.9135, 150.0

# 3. TRAZADO DE LA BANDA DE ATENUACIÓN
plt.figure(figsize=(8, 5))
plt.plot(f_fino, cs(f_fino), color='#2ca02c', linewidth=2, zorder=2, label='Spline Cúbico')
plt.scatter(f, Z, color='black', s=30, zorder=3, label='Datos medidos')
plt.axhline(Z_th, color='#d62728', linestyle='--', linewidth=1.5, label='Umbral $Z_{th} = 150\ \Omega$')

# Marcadores de estrella y texto para las raíces
plt.scatter([r1, r2], [Z_th, Z_th], color='red', marker='*', s=120, edgecolor='black', zorder=5, label='Raíces ($150\ \Omega$)')
plt.text(r1 + 50, Z_th + 1.5, f'{r1:.4f} Hz', color='red', fontweight='bold', fontsize=9)
plt.text(r2 - 420, Z_th + 1.5, f'{r2:.4f} Hz', color='red', fontweight='bold', fontsize=9)

# Sombreado de la zona operacional segura en Colab
plt.fill_between(f_fino, cs(f_fino), Z_th, where=(cs(f_fino) <= Z_th), color='#2ca02c', alpha=0.1, label='Zona Segura ($|Z| \leq 150\ \Omega$)')

plt.title('Búsqueda de Raíces y Banda de Operación Segura')
plt.xlabel('Frecuencia $f$ (Hz)')
plt.ylabel('Impedancia $|Z|$ ($\Omega$)')
plt.ylim(128, 162)
plt.xlim(50, 2800)
plt.legend(loc='lower center', frameon=True, shadow=True)
plt.grid(True, linestyle=':', alpha=0.5)
plt.tight_layout()

plt.savefig('plot_d.png', dpi=300)
plt.show()

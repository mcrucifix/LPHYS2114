# FitzHugh–Nagumo–like system with interactive slider for \(\beta\)

We consider the 2D dynamical system
\[\begin{aligned}
\dot x &= y + \beta,\\[4pt]
\dot y &= y - \frac{y^3}{3} - x,
\end{aligned}\]
with initial condition \((x(0),y(0)) = (-1,0)\) and time span \(t\in[0,30]\).

Use the slider to change the parameter \(\beta\in[-2,2]\). The **top plot** shows the time series \(x(t)\) and \(y(t)\). The **bottom plot** shows the phase trajectory \((x(t),y(t))\).

This notebook uses `ipywidgets` + `matplotlib` for interactivity and `scipy.integrate.solve_ivp` to integrate the ODEs.



```python
# Imports
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp
import ipywidgets as widgets
from IPython.display import display, clear_output

# Default plotting style for readable output
plt.rcParams.update({'figure.figsize': (8, 6), 'font.size': 12})

```


```python
# System definition and integrator
def f(t, z, beta):
    x, y = z
    dxdt = y + beta
    dydt = y - (y**3)/3 - x
    return [dxdt, dydt]

t_span = (0.0, 30.0)
t_eval = np.linspace(t_span[0], t_span[1], 1000)
z0 = [-1.0, 0.0]  # initial condition

```


```python
# Plotting function that updates when beta changes
def plot_for_beta(beta):
    sol = solve_ivp(f, t_span, z0, t_eval=t_eval, args=(beta,), rtol=1e-8, atol=1e-8)
    t = sol.t
    x = sol.y[0]
    y = sol.y[1]

    fig, (ax1, ax2) = plt.subplots(2, 1, sharex=False)
    # Time series
    ax1.plot(t, x, label='x(t)')
    ax1.plot(t, y, label='y(t)')
    ax1.set_xlim(t_span)
    ax1.set_xlabel('t')
    ax1.set_ylabel('x, y')
    ax1.set_title(f'Time series (\\beta = {beta:.3f})')
    ax1.legend()
    ax1.grid(True)

    # Phase portrait (trajectory only)
    ax2.plot(x, y, linewidth=1.5)
    ax2.plot(x[0], y[0], 'o', label='initial')  # mark initial condition
    ax2.set_xlabel('x')
    ax2.set_ylabel('y')
    ax2.set_title('Phase portrait (trajectory)')
    ax2.grid(True)
    plt.tight_layout()
    plt.show()

```


```python
# Create and display the interactive slider
beta_slider = widgets.FloatSlider(value=0.0, min=-2.0, max=2.0, step=0.01,
                                  description=r'$\beta$', continuous_update=True, readout_format='.3f',
                                  layout=widgets.Layout(width='80%'))

out = widgets.Output()

def _update(change):
    with out:
        clear_output(wait=True)
        plot_for_beta(change['new'])

# Initial plot
with out:
    plot_for_beta(beta_slider.value)

beta_slider.observe(_update, names='value')
display(beta_slider, out)

```


    FloatSlider(value=0.0, description='$\\beta$', layout=Layout(width='80%'), max=2.0, min=-2.0, readout_format='…



    Output()



```python

```

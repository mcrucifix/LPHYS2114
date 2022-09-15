
import numpy as np
from scipy import integrate
import matplotlib.pyplot as plt

t = np.linspace(0,10,10)


def dice(x, t, S):
    if (x > 0):
       x_dot = x - np.sqrt(3)/3 * x*x*x - S
    else: 
       x_dot = np.max((0.,-S))
    return x_dot


i = 0

def ppxevol(S):
   global i 
   print (i)
   x0s = np.linspace(0.,1.,10)
   def pxevol(x0):
       xevol = integrate.odeint(dice, x0, t, args=(S,))
       axes.flatten()[i].plot(t, xevol)
   # pxevol(x0s[0])
   list( map (pxevol, x0s) )
   i = i+1


fig, axes = plt.subplots(2,3)
list ( map ( ppxevol, np.linspace(-0.2,0.8,6 )  ) )
plt.show()

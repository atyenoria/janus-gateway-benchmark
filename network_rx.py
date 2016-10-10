import csv
from matplotlib import pylab as pl
import numpy as np
from matplotlib.legend_handler import HandlerLine2D
import matplotlib.lines as mlines

csv = np.genfromtxt ('./test/test_net.csv', delimiter=",")
time = csv[:,0]
rec = csv[:,6]

x=time[0:100]
y1=rec[0:100]
c1="Concurrency="+str(csv[1])


line1, = pl.plot(x,y1 ,marker='o', label="rx")
pl.legend(handler_map={line1: HandlerLine2D(numpoints=4)})


pl.xlim([0, 100])
pl.ylim([0, 3000])
pl.title("Janu Gateway Performance", fontsize = 20)
pl.xlabel("Elapse Time (s)")
pl.ylabel("Receive Bandwidth (kB/s)")
pl.savefig("rx.png")
pl.show()
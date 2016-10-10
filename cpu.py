import csv
from matplotlib import pylab as pl
import numpy as np
from matplotlib.legend_handler import HandlerLine2D
import matplotlib.lines as mlines

csv = np.genfromtxt ('./test/test_cpu.csv', delimiter=",")
time = csv[:,0]
cpu = csv[:,9]

x=time[0:100]
y1=cpu[0:100]
c1="Concurrency="+str(csv[1])

for idx, val in enumerate(cpu):
    cpu[idx]=100-val
    print(idx, val)

line1, = pl.plot(x,y1 ,marker='o', label="CPU Usage Rate")
pl.legend(handler_map={line1: HandlerLine2D(numpoints=4)})


pl.xlim([0, 100])
pl.ylim([0, 100])
pl.title("Janu Gateway Performance", fontsize = 20)
pl.xlabel("Elapse Time (s)")
pl.ylabel("CPU Usage Rate (%)")
pl.savefig("cpu.png")
pl.show()
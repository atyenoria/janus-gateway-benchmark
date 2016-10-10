import csv
from matplotlib import pylab as pl
import numpy as np
from matplotlib.legend_handler import HandlerLine2D
import matplotlib.lines as mlines

csv = np.genfromtxt ('./test/test_stream.csv', delimiter=",")
time = csv[:,0]
rec = csv[:,1]

x=time[0:100]
y1=rec[0:100]
c1="Concurrency="+str(csv[1])


line1, = pl.plot(x,y1 ,marker='o', label="Streams(Sessions)")
pl.legend(handler_map={line1: HandlerLine2D(numpoints=4)})


pl.xlim([0, 100])
pl.ylim([0, 50])
pl.title("Janu Gateway Performance", fontsize = 20)
pl.xlabel("Elapse Time (s)")
pl.ylabel("Numbers of Janus Streams(Sessions)")
pl.savefig("stream.png")
pl.show()
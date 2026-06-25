##1. CLEAN NODE INDEXING (IMPORTANT FIX)

My nodes were or are 3D tuples → must be mapped to integers 

IN PYTHON 

import networkx as nx
import numpy as np

node_list = list(G_clean.nodes())
node_index = {node: i for i, node in enumerate(node_list)}

G_indexed = nx.relabel_nodes(G_clean, node_index)
coords = np.array(node_list)
```

converts graph: from `(x,y,z)` nodes to integer-indexed graph (0…N)


## 2. BUILD SPARSE ADJACENCY MATRIX

IN PYTHON 

from scipy.sparse import coo_matrix

rows, cols = [], []

for u, v in G_indexed.edges():
    rows.append(u)
    cols.append(v)
    rows.append(v)
    cols.append(u)  # undirected graph

data = np.ones(len(rows))

A = coo_matrix((data, (rows, cols)),
               shape=(len(G_indexed), len(G_indexed))).tocsr()
```


I now have: adjacency matrix A for graph Laplacian

## 3. GRAPH LAPLACIAN (SIGNAL PROCESSING STEP)

IN PYTHON 

from scipy.sparse import csgraph

L = csgraph.laplacian(A, normed=False)


This is the core operator: to encode connectivity and enables diffusion / smoothing on graph



## 4. DEFINE GRAPH SIGNAL (DEGREE OR TORTUOSITY)


degree signal: 

IN PYTHON 
degree = np.array(A.sum(axis=1)).flatten()



## 5. LAPLACIAN SMOOTHING

IN PYTHON 
from scipy.sparse import identity
from scipy.sparse.linalg import spsolve

alpha = 0.1

I = identity(L.shape[0])

M = I + alpha * L

x_smooth = spsolve(M, degree)


## 6. PLOT RAW VS SMOOTHED SIGNAL

IN PYTHON 
import matplotlib.pyplot as plt

plt.figure()
plt.hist(degree, bins=50)
plt.title("Raw Degree")
plt.show()

plt.figure()
plt.hist(x_smooth, bins=50)
plt.title("Smoothed Graph Signal")
plt.show()
```

---

## 7. NODE TORTUOSITY MAPPING 

IN PYTHON
node_tort = np.zeros(len(G_indexed))
counts = np.zeros(len(G_indexed))

for u, v, d in G_indexed.edges(data=True):
    t = d["tortuosity"]

    node_tort[u] += t
    node_tort[v] += t

    counts[u] += 1
    counts[v] += 1

node_tort = node_tort / (counts + 1e-6)


## 8. OPTIONAL: SMOOTH TORTUOSITY

IN PYTHON
x_smooth_tort = spsolve(M, node_tort)

## 9. MAP BACK TO 3D IMAGE

IN PYTHON
img_smooth = np.zeros(vessels_small.shape)

for i, (x, y, z) in enumerate(coords):
    img_smooth[x, y, z] = x_smooth_tort[i]


## 10. VISUALISATION

```python
z = img_smooth.shape[2] // 2

plt.figure(figsize=(6,6))
plt.imshow(img_smooth[:, :, z], cmap="hot")
plt.title("Smoothed Vessel Signal (Graph Laplacian)")
plt.colorbar()
plt.show()

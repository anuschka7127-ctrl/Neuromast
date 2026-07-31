Load NifTl vessel segmentation
‹ Python

import nibabel as nib import numpy as np
img = nib.load("vessels.nii")
data = np.asanyarray(img.dataobj
print(data.shape)
print (data.dtype)
print(np.min(data), np.max(data))

Binarise vessel mask
‹ Python
vessels data 0).astype.int)
• Run
print("vessel voxels:", np.sum(vessels))
print("fraction:", np.sum(vessels)/vessels.size)

Visual sanity check (slice)
‹> Python
import matplotlib.pyplot as plt
z = vessels. shape[2] // 2
plt. imshow(vesselsl:, :, z], cmap="gray")
plt.title("Vessel Mask Slice")
plt.show()

Downsample (optional for performance becuase it's quite big)
‹ Python
import scipy. ndimage as nd
vessels_small = nd.zoom(vessels, (0.25, 0.25, 0.25), order=0)
print (vessels_small.shape)

Skeletonisation (3D centerlines)
« Python
from skimage. morphology import skeletonize_3d
skeleton = skeletonize_3d(vessels_small)
print ("skeleton vorels:", skeletonsum))

Extract skeleton coordinates
‹> Python
coords = np.array(np.where(skeleton)).T
print (coords.shape)

Build spatial graph (k-NN or radius graph)
‹> Python
from scipy. spatial import cKDTree
tree = cKDTree(coords)
pairs = tree.query_pairs(r=1.8)

Build NetworkX graph
< Python
import networkx as n
G = nx. Graph)
G. add_nodes_from(range(len(coords)))
G. add_edges_from (pairs)
print(G.number_of_nodes())
print(G.number_of_edges())

Identify main connected component
<> Python
components = list(nx.connected_components(G))
components_sorted = sorted(components, key=len, reverse=True)
main_nodes = components_sortedle]
G_main = G. subgraph(main_nodes). copy ()

Graph cleaning (removing tiny edges)
<> Python 
G_clean = nx.Graph()

for u, v in G_main.edges():
    seg_length = 1  # or computed earlier
    G_clean.add_edge(u, v, length=seg_length)

G_clean.remove_edges_from(
    [(u, v) for u, v, d in G_clean.edges(data=True) if d["length"] < 5]
)

Remove self-loops (CRITICAL FIX)
« Python
G_clean. remove_edges_from(nx.selfloop_edges(G_clean))

Define voxel size (mm conversion)
< Python
voxel_size = 0.1746

Compute edge length in mm
< Python
for u, v, d in G_clean. edges (data=True):
d["length_mm"] = d["length"] * voxel_size

Compute tortuosity
‹ Python
import numpy as np
def euclidean(a, b) :
return np.linalg.norm(np.array(a) -np.array(b))
for u, v, d in G_clean. edges (data=True) :
path_len = d["length_mm"]
straight = euclidean(u, v) * voxel_size
d["tortuosity"] = path_len / straight

Remove extreme outliers
‹› Python
lengths = [d["length_mm"] for _ -, d in G_clean. edges(data=True) ]
threshold = np.mean(lengths) + 3*np.std(lengths)
bad_edges = L
(u, v)
for u, V, d in G_clean.edges (data=True) if d["length_mm"] > threshold
• Run
G_clean. remove_edges_from(bad_edges)

Extract summary statistics
‹> Python
tort = [d["tortuosity"] for -, -, d in G_clean.edges(data=True) ]
lengths = [d["length_mm"] for -, -, d in G_clean.edges(data=True)]
print("Nodes:", G_clean. number_of_nodes ( ))
print("Edges:", G_clean.number_of_edges ( ))
print("Mean tortuosity:", np.mean(tort))
print( "Median:", np.median(tort))
print("Max: ", np.max (tort))

Detect pathological values (debug step)
‹ Python
print(">10:", sum(t > 10 for t in tort))
print(">100:", sum(t> 100 for t in tort))

Final tortuosity filtering (optional plotting clean-up)
«> Python
tort_clean = It for t in tort if t ‹ 10]



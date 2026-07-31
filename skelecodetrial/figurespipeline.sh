FIGURE PIPELINE 

FIGURE 1 - Tortuosity histogram
<> Python
plt.hist(tort, bins=50)
plt.title("Vessel Tortuosity Distribution")
plt.xlabel("Tortuosity")
plt. ylabel("Count")
plt.show()

FIGURE 2 - Length vs Tortuosity
« Python
plt. scatter(lengths, tort, s=5)
plt.xlabel("Length (mm) ")
plt.ylabel("Tortuosity")
plt. title("Length vs Tortuosity")
plt.show()

FIGURE 3 - Skeleton slice
‹> Python
z = skeleton. shape[2] // 2
plt.imshow(skeleton[:, :, z], cmap="gray")
plt.title("Vessel Skeleton Slice")
plt.show()

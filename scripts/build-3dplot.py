import matplotlib.image as img
import matplotlib.pyplot as plt
import numpy as np
import yaml

ax = plt.axes(projection='3d')

ax.set_title('Villages Map')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

with open('data/locations.yaml') as file:
    try:
        locations = yaml.safe_load(file)
    except yaml.YAMLError as e:
        print(e)
        raise

for village in locations['villages']:
    ax.scatter(
        village['coords']['x'],
        village['coords']['y'],
        village['coords']['z'],
        label=village['name']
    )
    ax.text(
        village['coords']['x'],
        village['coords']['y'],
        village['coords']['z'],
        village['name'],
        fontsize=5
    )

plt.savefig('maps/villages.png', dpi=500)
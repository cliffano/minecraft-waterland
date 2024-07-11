import matplotlib.image as img
import matplotlib.pyplot as plt
import numpy as np
import yaml

def generate_villages_map(title, data_file, output_file):

    ax = plt.axes(projection='3d')

    ax.set_title(title)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')

    with open(data_file) as file:
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

    plt.savefig(output_file, dpi=500)

generate_villages_map('Overworld Villages Map', 'data/locations-overworld.yaml', 'images/villages-map-overworld.png')
generate_villages_map('Nether Villages Map', 'data/locations-nether.yaml', 'images/villages-map-nether.png')

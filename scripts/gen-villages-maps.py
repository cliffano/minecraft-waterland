from conflog import Conflog
import matplotlib.image as img
import matplotlib.pyplot as plt
import numpy as np
import yaml

cfl = Conflog(conf_files=["./config/conflog.yaml"])
logger = cfl.get_logger("gen-villages-maps")


def generate_villages_map(title, data_file, output_file):
    logger.info(f"Generating villages map for {title} ...")

    ax = plt.axes(projection="3d")

    ax.set_title(title)
    ax.set_xlabel("X")
    ax.set_ylabel("Y")
    ax.set_zlabel("Z")

    with open(data_file) as file:
        try:
            logger.info(f"Loading locations data from {data_file} ...")
            locations = yaml.safe_load(file)
        except yaml.YAMLError as e:
            print(e)
            raise

    for village in locations["villages"]:
        ax.scatter(
            village["coords"]["x"],
            village["coords"]["y"],
            village["coords"]["z"],
            label=village["name"],
        )
        ax.text(
            village["coords"]["x"],
            village["coords"]["y"],
            village["coords"]["z"],
            village["name"],
            fontsize=5,
        )

    logger.info(f"Creating villages map image at {output_file} ...")
    plt.savefig(output_file, dpi=500)
    plt.close()

    logger.info(f"Villages map for {title} generated successfully")


generate_villages_map(
    "Overworld Villages Map",
    "data/locations-overworld.yaml",
    "images/villages-map-overworld.png",
)
generate_villages_map(
    "Nether Villages Map",
    "data/locations-nether.yaml",
    "images/villages-map-nether.png",
)

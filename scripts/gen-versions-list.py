import minecraftverse
from tabulate import tabulate

def generate_versions_data():

    data = []

    launchermeta_conf = minecraftverse.Configuration(
      host = 'https://launchermeta.mojang.com'
    )
    piston_conf = minecraftverse.Configuration(
      host = 'https://piston-meta.mojang.com'
    )

    with minecraftverse.ApiClient(launchermeta_conf) as launchermeta_api_client:

        launchermeta_api = minecraftverse.DefaultApi(launchermeta_api_client)

        manifest = launchermeta_api.get_minecraft_version_manifest()
        for version in manifest.versions:
            version_url_parts = version.url.split('/')
            version_id = version_url_parts[-1].replace('.json', '')
            package_id = version_url_parts[-2]

            with minecraftverse.ApiClient(piston_conf) as piston_api_client:

                piston_api = minecraftverse.DefaultApi(piston_api_client)

                try:

                    print(f'Retrieving package info for version {version.id} with package ID {package_id} ...')

                    version_package_info = piston_api.get_minecraft_version_package_info(package_id, version_id)

                    if (version_package_info.downloads.server is None):
                        print(f'No server jar fou  nd for version {version.id} with package ID {package_id}')
                        continue

                    data.append({
                        'Minecraft Version': version.id,
                        'Server Jar Download URL': version_package_info.downloads.server.url
                    })

                except minecraftverse.exceptions.NotFoundException as e:
                    print(f'Unable to find package info for version {version.id} with package ID {package_id}')

    return data

def render_versions_list(data):
    print(tabulate(data, headers="keys", tablefmt="pipe"))

data = generate_versions_data()
render_versions_list(data)

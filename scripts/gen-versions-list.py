# This script creates a Markdown file with a list of Minecraft versions and their server jar download URLs,
# to be published to https://gist.github.com/cliffano/77a982a7503669c3e1acb0a0cf6127e9

from conflog import Conflog
import minecraftverse
from tabulate import tabulate

cfl = Conflog(conf_files=['./config/conflog.yaml'])
logger = cfl.get_logger('gen-versions-list')

def retrieve_versions_data():
    logger.info('Retrieving versions data...')

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
            package_id = version_url_parts[-2]

            with minecraftverse.ApiClient(piston_conf) as piston_api_client:

                piston_api = minecraftverse.DefaultApi(piston_api_client)

                try:

                    logger.info(f'Retrieving package info for version {version.id} with package ID {package_id} ...')

                    # version.id value is not URL encoded, we offload the encoding to the API client.
                    # For version that has spaces in the name, we must pass the non-URL-encoded value.
                    version_package_info = piston_api.get_minecraft_version_package_info(package_id, version.id)

                    if (version_package_info.downloads.server is None):
                        logger.error(f'No server jar found for version {version.id} with package ID {package_id}')
                        data.append({
                            'Minecraft Version': version.id,
                            'Server Jar Download URL': 'Not found'
                        })
                        continue

                    data.append({
                        'Minecraft Version': version.id,
                        'Server Jar Download URL': version_package_info.downloads.server.url
                    })

                except minecraftverse.exceptions.NotFoundException:
                    logger.error(f'Unable to find package info for version {version.id} with package ID {package_id}')

    logger.info('Versions data retrieved successfully')
    return data

def write_versions_list_markdown_file(data, file_path):
    logger.info(f'Writing versions list Markdown file at {file_path} ...')
    versions_list_in_markdown = tabulate(data, headers="keys", tablefmt="pipe")
    with open(file_path, 'w') as file:
        file.write(versions_list_in_markdown)
        logger.info('Versions list Markdown file written successfully')

data = retrieve_versions_data()
write_versions_list_markdown_file(data, 'stage/versions-list.md')

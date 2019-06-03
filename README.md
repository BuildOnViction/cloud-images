# cloud-images

This repo holds the TomoChain cloud images for diverse purposes and providers.

## Build

The images are built with [packer](https://www.packer.io/downloads.html).

```shell
packer build $file
```

For example:

```shell
# Find the variables you need to provide
packer inspect DigitalOcean/fullnode-18-04.json

# Export the environment variables found in the last step
 export DO_API_TOKEN="XXXXXXXXXXXXXXXXXXX"

# Start the build
packer build DigitalOcean/fullnode-18-04.json
```

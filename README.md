# cloud-images

This repo holds the TomoChain cloud images for diverse providers.

## Build

The images are built with [packer](https://www.packer.io/downloads.html).

```shell
packer build $file
```

For example:

```shell
 export DO_API_TOKEN=XXXXXXXXXXXXXXXXXXX
packer build DigitalOcean/fullnode-18-04.json
```

Note: to know which env variables are required, just take a look in the `variables` section of each files.

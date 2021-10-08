#!/bin/sh
# Reference: https://gist.github.com/pkuczynski/8665367
parse_yaml() {
    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
    sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
    awk -F$fs '{
        indent = length($1)/2;
        vname[indent] = $2;
        for (i in vname) {if (i > indent) {delete vname[i]}}
        if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s=\"%s\"\n", vn, $2, $3);
        }
    }'
}

# Read yaml file
eval $(parse_yaml parameters.yaml)

# Pull Docker image
echo "Pulling Docker image..."
docker pull ${FROM_IMAGE}:cuda${CUDA_VER}-${IMAGE_TYPE}-${LINUX_VER}
echo "Done"
# Start Docker container
echo "Start running Docker container..."
docker run --name cugraph -d --gpus all --rm -it -p 8888:8888 -p 8787:8787 -p 8786:8786 -v ${PWD}:/rapids/host \
    ${FROM_IMAGE}:cuda${CUDA_VER}-${IMAGE_TYPE}-${LINUX_VER}

# Install dependencies
docker exec -it cugraph /bin/bash -c "echo Installing dependencies in Docker container...; \
source activate rapids && pip install papermill; \
cd /rapids/host; \
mkdir -p output; \
papermill dataloader.ipynb output/dataloader_output_$EPOCHSECONDS.ipynb -f parameters.yaml; \
papermill model.ipynb output/model_output_$EPOCHSECONDS.ipynb -f parameters.yaml"

# Stop Docker container
docker stop cugraph
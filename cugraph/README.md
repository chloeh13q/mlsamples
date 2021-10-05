```
docker build -t cugraph .
docker run --rm -it --gpus all -p 8888:8888 -p 8787:8787 -p 8786:8786 -v ${PWD}:/rapids/host cugraph /bin/bash
```
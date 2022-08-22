# stable_diffusion_docker
dockerfile for running stable diffusion on nvidia-docker

```bash
docker build -t stable_diffusion . && docker run --net=host --gpus all --memory 60g --memory-swap 60g --shm-size 8G -v /path/to/stable-diffusion-v1-4:/stable-diffusion --rm -it --name sd1 stable_diffusion
```

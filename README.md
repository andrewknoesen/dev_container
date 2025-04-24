# dev_container
This is a containerised development environment 

### Useful links
[cli tools](https://www.josean.com/posts/7-amazing-cli-tools)

## Build
`docker build -t dev-container .`

## Start server
`docker run --name dev-container -it dev-container`

## Connect to server 
`docker exec -it dev-container bash`

## Edit Files Locally with Volume Mounts
`docker run --name dev-container -v /path/to/code:/home/devuser/code -it <image_name>`

## Copy Files Between Host and Container
### Copy from host to container
`docker cp myfile.txt dev-container:/home/devuser/`

### Copy from container to host
`docker cp dev-container:/home/devuser/myfile.txt .`



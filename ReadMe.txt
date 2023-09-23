✏︎ The topics we will discuss in this README are:
What is Docker? ->
Docker is a tool designed to allow you to build, deploy and run applications in an isolated 
and consistent manner across different machines and operating systems. This process is done using CONTAINERS.
which are lightweight virtualized environments that package all the dependencies and code an application
 needs to run into a single text file, which can run the same way on any machine.

While Docker is primarily used to package and run applications in containers, it is not limited to that use case.
Docker can also be used to create and run other types of containers, 
such as ones for testing, development, or experimentation.

How Does Docker Work?->
Docker uses a client-server architecture, where Docker client talks to Docker daemon, 
which is responsible for building, running, and distributing all Docker containers. 
The Docker client and Docker daemon communicate using a REST API, 
over a UNIX socket or a network interface.

What is a Docker Image?->
Docker Image is a lightweight executable package that includes everything the application needs to run, 
including the code, runtime environment, system tools, libraries, and dependencies.
Although it cannot guarantee error-free performance, as the behavior of an application 
ultimately depends on many factors beyond the image itself, 
using Docker can reduce the likelihood of unexpected errors.
Docker Image is built from a DOCKERFILE, which is a simple text 
file that contains a set of instructions for building the image, 
with each instruction creating a new layer in the image.

What is a Dockerfile?->
Dockerfile is that SIMPLE TEXT FILE that I mentioned earlier, 
which contains a set of instructions for building a Docker Image. 
It specifies the base image to use and then includes a series of 
commands that automate the process for configuring and building the image, 
such as installing packages, copying files, and setting environment variables. 
Each command in the Dockerfile creates a new layer in the image.
Here's an example of a Dockerfile to make things a little bit clear:
# This Specifies the base images for the container 
(in this case, it's the 3.14 version of Alpine)
FROM alpine:3.14
# This Run commands in the container shell and installs the specified packages
# (it will install nginx & OpenSSL, and will create the directory "/run/nginx" as well)
RUN apk update && \
    apk add nginx openssl && \
    mkdir -p /run/nginx

# This Copies the contents of "./conf/nginx.conf" on the host machine to the "/etc/nginx/http.d/"
# directory inside the container
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# This Specifies the command that will run when the container gets started
CMD ["nginx", "-g", "daemon off;"]

What is a Docker Compose?->
Docker Compose is a powerful tool that simplifies the deployment 
and management of multi-container Docker applications. 
It provides several benefits, including simplifying the process of defining related services, 
volumes for data persistence, and networks for connecting containers. 
With Docker Compose, you can easily configure each service's settings, including the image to use, 
the ports to expose, and the environment variables to set...

Overall, Docker Compose streamlines the development process, 
making it easier for you to build and deliver your applications with greater efficiency and ease.
A Docker Compose has 3 important parts, which are:
=> Services: A service is a unit of work in Docker Compose, it has a name, 
and it defines container images, a set of environment variables, 
and a set of ports that are exposed to the host machine.
When you run docker-compose up, Docker will create a new container for each service in your Compose file.
=> Networks: A network is a way for containers to communicate with each other. 
When you create a network in your Compose file, 
Docker will create a new network that all the other containers in your Compose file will be connected to. 
This allows containers to communicate with each other 
without even knowing the IP of each other, just by the name.
=> Volumes: A volume is a way to store data that is shared between containers.
 When you create a volume in your Compose file, 
 Docker will create a new volume (a folder in another way) that all the containers have access to. 
 This allows you to share data between the containers without having 
 to copy-paste each and every time you want that data.

Here's an example of a Docker Compose to make things a little bit clear:
version: '3'

# All the services that you will work with should be declared under the SERVICES section!
services:

  # Name of the first service (for example nginx)
  nginx:
  
    # The hostname of the service (will be the same as the service name!)
    hostname: nginx
    
    # Where the service exists (path) so you can build it
    build:
      context: ./requirements/nginx
      dockerfile: Dockerfile
      
    # Restart to always keep the service restarting in case of any unexpected errors causing it to go down
    restart: always
    
    # This line explains itself!!!
    depends_on:
      - wordpress
      
    # The ports that will be exposed and you will work with
    ports:
      - 443:443
      
    # The volumes that you will be mounted when the container gets built
    volumes:
      - wordpress:/var/www/html
      
    # The networks that the container will connect and communicate with the other containers
    networks:
      - web
How Does Docker Compose Work?->
Docker Compose uses a YAML file to configure all the services, networks, 
and volumes that your application needs to. You can then with just a single 
command create and start all the services from your configuration. 
That's it. As simple as that.

What is the difference between a Docker image used with Docker Compose and without Docker Compose?->

The main difference between the two is that Docker Compose provides a high level of abstraction 
for defining and managing multi-container applications, and it also simplifies the process of building, 
and running all the services (containers) in one take, which means instead of building the image and 
running the containers one by one, 
Docker Compose allows you do that for all the containers that you have in just one single command.

Using Docker directly without Docker Compose gives you more fine-grained control over individual containers, 
but it requires more work on your end to manage and deal with multiple containers.

What is a Container?->
A Container is a standard unit of software that packages up code and all its dependencies 
so the application runs quickly and reliably from one computing environment to another

What is The Difference Between a Container and a VM?->
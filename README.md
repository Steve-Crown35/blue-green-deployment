# blue-green-deployment
This repo is created for the blue-green deployment of a static web page. 
# How to setup the deployment
Setup the Environments:

1. install the latest version of virtualbox from  https://www.virtualbox.org/wiki/Downloads
2. install vagrant from https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-install
3. install git from https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

Clone the repository:

1. create a github account if you do not already have one. Use https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account for instructions on how to create one.
2. create a new folder on your machine, open a terminal, navigate into the folder and run the following command (command prompt or git bash): "git clone https://github.com/Steve-Crown35/blue-green-deployment.git"
3. navigate into the repo "blue-green-deployment".

Running the scripts:

-- Set up the VM
1. run "vagrant up" to set up the virtual machine, install nginx and docker
2. on complete installation, run "vagrant ssh nginx-proxy" to access the virtual machine.
3. switch user to root by running "sudo -i"
4. navigate into the shared folder by running "cd /vagrant" 

-- Create the docker containers, one for each environment

1. run "docker build -t blue-hello-world:latest ." to build the docker image for the blue environment.
2. run "docker build -t green-hello-world:latest ." to build the docker image for the green environment.
3. run "docker images" to get a list of all docker images in the VM.
4. run "docker run -d --name blue-hello-world -p 8080:80 blue-hello-world:latest" to create the blue environment container.
5. run "docker run -d --name green-hello-world -p 8081:80 green-hello-world:latest" to create the green environment container.
6. use "docker ps" to get the list of running containers. Note the containers' IDs.
7. use "docker inspect container_id | grep IPAddress" to get the IPAddress assigned to the container.Replace container_id with the actual container ID from step 6. Repeat step 7 for the second container.

-- Configure nginx server to serve as a reverse proxy

1. navigate to sites-available directory in the nginx file system by running "cd /etc/nginx/sites-available"
2. create two configuration files blue.conf and green.conf by open a text editor (e.g nano)
using "sudo nano blue.conf". copy and patse the following configuration:
upstream blue-env {
  server container_IP:8080;
}

server {
  listen 80;
  server_name localhost;

  location / {
    proxy_http_version 1.1;
    proxy_set_header Connection "";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    
    proxy_pass http://blue-env;
  }
}

Replace container_IP in the above with the IPAddress of the blue-hello-world container from step 7 above under "Create the docker containers, one for each environment" section. Use "ctrl + s" to save and "ctrl + x" to exit the editor.
3. Repeat step 2 for the green container and copy and paste the following configuration: 
upstream green-env {
  server container_IP:8081;
}

server {
  listen 80;
  server_name localhost;

  location / {
    proxy_http_version 1.1;
    proxy_set_header Connection "";
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;

    proxy_pass http://green-env;
  }
}
Replace container_IP in the above with the IPAddress of the green-hello-world container from step 7 above under "Create the docker containers, one for each environment" section. Use "ctrl + s" to save and "ctrl + x" to exit the editor.

4. run "sudo ln -s /etc/nginx/sites-available/blue.conf /etc/nginx/sites-enabled/blue.conf" and "sudo ln -s /etc/nginx/sites-available/green.conf /etc/nginx/sites-enabled/green.conf" to create symbolic links between the sites-available and sites-enabled.
5. run "sudo nginx -t" to test the configuration and ensure there are no syntax errors.
6. run "systemctl restart nginx" to update nginx configuration.

-- Run the switch-env.sh srcipt to switch between environments

1. navigate into the shared folder by running "cd /vagrant" 
2. run "chmod +x switch-env.sh" to make the switch-env file executable
3. run the script by running "./switch-env". The script checks for the current active environment. If it is blue, it switches to green and vice versa.
7. if the active environment is blue, run "100.100.100.100:8080" on the web browser or "curl 100.100.100.100:8080" on the terminal, to see the static webpage.
8. if the active environment is green, run "100.100.100.100:8081" on the web browser or "curl 100.100.100.100:8080" on the terminal, to see the static webpage.




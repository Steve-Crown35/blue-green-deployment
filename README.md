# blue-green-deployment
This repo is created for the blue-green deployment of a static web page. 
# How to setup the deployment
Setup the Environments:

1. install the latest version of virtualbox from  https://www.virtualbox.org/wiki/Downloads
2. install vagrant from https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-install
3. install git from https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

Clone the repository:

1. create a github account if you do not already have one. Use https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account for instructions on how to create one.
2. create a new folder on your machine and run the following command on your terminal (command prompt or git bash): git clone https://github.com/Steve-Crown35/blue-green-deployment.git
3. navigate into the repo "blue-green-deployment".

Running the scripts:

1. run "vagrant up" to set up the virtual machine, install nginx and docker
2. on complete installation, run "vagrant ssh nginx-proxy" to access the virtual machine.
3. switch user to root by running "sudo -i"
4. navigate into the shared folder by running "cd /vagrant" 
5. run "chmod +x switch-env.sh" to make the switch-env file executable
6. run the script by running "./switch-env". The script checks for the current active environment. If it is blue, it switches to green and vice versa.
7. if the active environment is blue, run "100.100.100.100:8080" on the web browser to see the static webpage.
8. if the active environment is green, run "100.100.100.100:8081" on the web browser to see the static webpage.




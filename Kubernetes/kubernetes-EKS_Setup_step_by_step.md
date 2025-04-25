container : it is run time instance of our application (osimage + softwares + code also)

pod : it is a smallet building block that we will create in k8s to run our containers.

--> docker container will run inside the POD.

+++++++++++++++++++++++++
kubernetes Cluster Setup
+++++++++++++++++++++++++

Step - 1 : Create EKS Management Host in AWS

remote machine --> kubectl commands --> ubuntu (t2.micro)

2.Connect to machine and install kubectl using below commands

curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl


chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin


kubectl version --short --client


3. install aws cli latest version using below commands

sudo apt install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"


unzip awscliv2.zip


sudo ./aws/install

aws --version

4. eksctl using below commands

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version


step 2: Create IAM role & attach to EKS Management Host

Create New Role using IAM service ( Select Usecase - ec2 )

Add below permissions for the role

IAM - fullaccess
VPC - fullaccess
EC2 - fullaccess
CloudFomration - fullaccess
Administrator - acces
Enter Role Name (eksroleec2)

Attach created role to EKS Management Host (Select EC2 => Click on Security => Modify IAM Role => attach IAM role we have created)

Step - 3 : Create EKS Cluster using eksctl

Syntax:

eksctl create cluster --name cluster-name
--region region-name
--node-type instance-type
--nodes-min 2
--nodes-max 2 \ --zones ,

N. Virgina:
eksctl create cluster --name techworldwithhari-cluster4 --region us-east-1 --node-type t2.medium  --zones us-east-1a,us-east-1b

Mumbai:
eksctl create cluster --name techworldwithhari-cluster4 --region ap-south-1 --node-type t2.medium  --zones ap-south-1a,ap-south-1b

Note: Cluster creation will take 5 to 10 mins of time (we have to wait). After cluster created we can check nodes using below command.

kubectl get nodes

Step - 4 : After your practise, delete Cluster and other resources we have used in AWS Cloud to avoid billing








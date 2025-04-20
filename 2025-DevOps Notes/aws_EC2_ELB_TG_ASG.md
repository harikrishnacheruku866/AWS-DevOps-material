

Cloud Computing: PAY PER USE/ OnDemand Computing Resource allocation

Why? No Maintain , Less Cost, Fast service.
What is the use? To run apps/ to store our data.

Deployment Modes:
Public
Private
Hybrid
Community

Infrastructure as a Service (IaaS) --> Hardware (Networks/CPU/RAM/Storage)
Platform as a Service (PaaS)  --> OS
Software as a Service (SaaS)  --> Ready to use Software
			(online editors/white board/Gdrive)


-------------------
Virtualization: 
1. Create multiple VMs (Virtual Computers)
2. Isolated, Abstraction
3. Supports networking
4. Required on s/w : hypervisor 
5. Install any OS - Machine Image (OS S/w ISO)

*) All Cloud Providers (AWS, GCP, AZURE..etc) are using Virtualization.
------------------------------------------------------------------------
AWS with DevOps
===============
Date: 11-04-24
++++++++++++++

How to create aws account and launch Compute service [EC2 instance]
--------------------------------------------------------------------
-> In order to use aws cloud services we need to create account in AWS

  URL: https://aws.amazon.com/

-> By accessing above URL in browser we can create account in aws


Q) how many types of accounts we can create in aws?

We can create 2 types of accounts

1) root account (all privileges)

2) IAM Account(Identity access management)

--> Company will manage root account and as a team member we will use the IAM account.


Development team

Devops team

cloud team

Note: once root account is created, with root account we can create server IAM accounts for managing works in AWS

AWS Providing morethan 200 services

(we can choose the services which are required for business)

--> machines
-> servrers
databases
storages
network
security
analytics
monitoring .. etc..



Note: If we use aws cloud in our project then we can focus on development and business because infra we can use from aws.

Regions and AZ

AWS EC2
+++++++

=> EC2 stands for Elastic compute cloud 

=> EC2 is one of the most famous service available in AWS

=> By using EC2 we can create virtual machines(VM) required for our project

=> Virtual machine -> Instance in AWS

Computer/machine/server/vm ====> instance

--------------
EC2 Instances
--------------
-> AMI (os template) - Amazon Machine Image
-> Network (VPC + SG)
-> Volumes (storages and backups)
-> Keypair (pub/pri)
-> Loadbalancer(TG/LB/ASG)

=> EC2 instance is a region/AZ specific
=> with every EC2 instance a volume is created and attached i.e called a root volume
=> root volume contains OS + our files
=> Min root vol size is 8GB (Linux) , 100G(mac), 30gb (windows)
=> Mix vol size for EBS: 16 tb
=> Volume creation, resize, deletion is done using EBS (Elastic Block storage)
=> EC2 root volume is deleted on termination of ec2(default)
Date : 16-04-2025
AWS Cloud
Mr . Hari(BluJay Tech)
--------------------

ELB [Elastic Load Balancer]
===========================

Aws  provides two ways of infrastructure configurations

1) AWS web console

2) AWS CLI


Using AWS web console:
+++++++++++++++++++++

it is a graphical method to connect to various aws resources, their configuration , modification etc..It is simple to used and does not require knowledge of scripting.

AWS command Line Interface:
===========================
Usually, the script provides you with the flexibility to mange multiple aws resources, infrastructure effectively.

For example, we can use the script to deploy multiple resources without the need to go through a complete configuration wizard each time.


Prerequisites to use AWS CLI:
+++++++++++++++++++++++++++++
1) Create AWS Account: 

xxxxxxxxx

2) Install AWS CLI : AWS CLI is available for windows, Mac and Linux distribution of OS

How to install aws cli on windows : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

a) for windows : https://awscli.amazonaws.com/AWSCLIV2.msi (download and install)

step1: you can run the msiexec command to run the MSI installer.


C:\> msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi

step2 : check the version

awscli --version

3) Create aws iam user(blujaytech) with programmatic access (For this need to learn what is IAM)
access key : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
secret key : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxxxxx

Windows:

aws configure

List out all ec2 instances
++++++++++++++++++++++++++
$ aws ec2 describe-instances

$aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId" --output text


Aws with DevOps:
===============
Date: 18-04-25
--------------

check aws credentials
=====================

$ aws sts get-caller-identity


check your aws region
=====================
aws configure get region


Create a new key pair for EC2 Instances
+++++++++++++++++++++++++++++++++++++++
Before launching a new EC2 instance we will need an SSH key pair that will use to connect the ec2 instance

$ aws ec2 create-key-pair --key-name blujaytechkey --output text > blujaytechkey.pem


Launch new EC2 instance through awscli [windows command prompt]
===============================================================
$ aws ec2 run-instances --image-id ami-07a6f770277670015 --instance-type t2.micro --key-name blujaytechkey

stop and start an EC2 Instances
++++++++++++++++++++++++++++++++
$ aws ec2 stop-instances --instance-ids instance_id

ex: aws ec2 stop-instances --instance-ids i-05f3f511feab70f0a

and start again:
    
    aws ec2 start-instances --instance-ids i-05f3f511feab70f0a


Terminate an Instance:
++++++++++++++++++++++
 $  aws ec2 terminate-instances --instance-ids i-05f3f511feab70f0a


stop -- > it will shutdown the machine/vm/server/instance
terminate (decommission - delete/remove permanently) 

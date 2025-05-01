AWS with DevOps batch-54
++++++++++++++++++++++++
Date: 01-05-2025
================
Trainer : Har!


================
Ansible setup
================

Create 2 Amazon Linux instances of instance type t2.micro (free tier eligible)

1. Ansible (server) ==> Control Node ==> We need to install ansible before that python3 needs to install.

2. Target server(new build server) ==> Managed Node


===========================================
passwordless authentication b/w two servers
============================================


Execute below commands in all nodes:
====================================
step 1: create a one new user on both the servers
          $ sudo useradd ansible
          $ sudo passwd  ansible
      

step 2: Provide sudoer permissions(like root user)
          $ sudo visudo
          ansible ALL=(ALL) NOPASSWD:ALL

step 3: Activate password authentication yes
        $ sudo vi /etc/ssh/sshd_config
        PasswordAuthentication yes (might be default value NO, change it to Yes)

step 4: restart sshd service
        $ sudo systemctl restart sshd

step 5: switch to ansible user
         $sudo su - ansible

step 6: Generate a new key-pair using SSH
=========================================
          $ssh-keygen
         click enter --> enter --> enter

         /home/ansible/.ssh/ (under .ssh directory) ==> id_rsa, id_rsa.pub(public key) files will be created.

What is command to see the hidden files/directory 
                  $ ls -la
  
copy the public key in to Managed(target server) nodes
             $cat /home/ansible/.ssh/id_rsa.pub
 

step 7: Login to the managed node as ansible user and run the same command as below

                  $ssh-keygen

                cd /home/ansible/.ssh

              U can create a file authorized_keys and paste the id_rsa.pub 

                  vi authorized_keys


******************Execute Below commands Only on Master Node***************************

step 8: Install python and pip(package installers for python) software for ansible runtime
         $ sudo yum install python3 -y
         $ python3 --version
         $ sudo yum install python3-pip -y

step 9: install ansible
         $ pip3 install ansible --user
         $ ansible --version


step 10: create a ansible root directory

         $sudo mkdir /etc/ansible

step 11: create ansible configuration and inventory file
          $sudo vi /etc/ansible/ansible.cfg

           copy and paste (https://github.com/ansible/ansible/blob/stable-2.9/examples/ansible.cfg)

           Uncomment few lines
           inventory = /etc/ansible/hosts
           sudo_user = ansible
           :wq!(save and quit forcefully)

          $sudo vi /etc/ansible/hosts
          copy and paste (https://github.com/ansible/ansible/blob/stable-2.9/examples/hosts.yaml)
          [webservers]
          65.0.201.456

          [dbservers]
          65.0.201.423

        wq!(save and quit forcefully)


step 12: test ansible and after installation successful

          $ ansible all --list-hosts
          $ ansible webservers --list-hosts
          $ ansible dbservers --list-hosts


Ansible ad-hoc commands
=======================
switch to ansible user and run ansible ad-hoc commands

    $sudo su - ansible
    
To run any ansible command we will follow the below syntax

     $ ansible[all/gropname/hostname/op] -m <<module name>> -a <<args>>

Here -m is the module name and -a is the arguments to module.

Example:
#ping all manged nodes listed in host inventory file
 $ ansible all -m ping

#ping only webservers listed in host inventory file
 ansible webservers -m ping

#ping only dbservers listed in host inventory file
 ansible dbservers -m ping

SHELL Modules:
==============================================================
#it will display date from all managed host machines
 ansible all -m shell -a date

#it will display uptime from all managed host machines
 ansible all -m shell -a uptime

==============================================================

#it will display the all modules available in ansible
  ansible-doc -l

#it will display a particular module information
 ansible-doc yum
 ansible-doc service
 ansible-doc copy

#it will ping all the servers which you have mentioned in inventory file(/etc/ansible/hosts)
 ansible all -m ping

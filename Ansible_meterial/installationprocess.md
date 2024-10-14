1.created two instances in aws and login as ec2-user and switch to root user by using the #sudo su -
2.In sshd configuration file vi /etc/ssh/sshd_config
3.enable the passwordlessauthentication yes
4.enable the permitrootlogin yes
5.execute the ssh-keygen command on both the server it will create the id_rsa (this is private key file) and id_rsa.pub (this is publickey)

6. in the ansible server need to copy the id_rsa.pub key the location is #cd .ssh/
#ls
#cat id_rsa.pub 

copy the key

7. login to the clientmachine switch to the root user and paste the id_rsa.pub key into authorized_keys file

8. verify if the passwordless authentication is working or not?

by using the below command
# ssh -p 22 root@private ip address (ssh -p 22 root@172.31.26.120)


9. install the ansible on the ansibleserver machine by using the below command

# amazon-linux-extras install ansible2 -y

# ansible --version (verify the ansible version)

10 . create a playbook for the installing the apacheserver(httpd)

User Administration
---------------------------------

All users UID or GID starts from 1000 by default.

		uid,gids   --> 60,000
		0-999 	   --> system itself uses ( 0 ..root )
		1000-60,000 --> all general users uses.

hari -->1000
krishna -->1001
eze --> 1002
ayyappa --> 1003
blujay --> 1010

****For a user account primary group is manadatory. If you not assigned to any group, user himself behaves as group.

Groupadd:  to create a system group. For a user it may be primary or secondary group. 
And All groups information available in /etc/group.

     groupadd  group-name
     groupadd -g GID  groupname

     ex:   groupadd hr
	   groupadd -g 10000 nagios

     more  /etc/group      OR      grep  hr  /etc/group

     Fields in /etc/group,    groupname:GID:X:secondarygroupmembers


Useradd: To create a new user account.

#useradd	<options>	<username>
		-u uid
		-g primary group
		-G secondary group
		-d home dir
		-c comment
		-s shell


Whenever you create a user, the user details are going to store under "/etc/passwd" database file
 and users passwords are going store under "/etc/shadow" database file.

SHEEL: Is used to interact with the system. To know how many shells are available, /etc/shells

       cat  /etc/shells
     And,  /bin/bash is the default shell for all Linux/Unix 
          /sbin/nologin is a special shell which gives no-interaction with the system.
 Generally all service user accounts are assigned with nologin shells.

   grep 'nologin$' /etc/passwd  ( to see the users list with nologin shell ) 
   echo  $SHELL  ( to know working shell )


To assign password for the user account.

      passwd  username
      
      passwd  options  username
              -l (lock the password)
              -u (unlock the password)
              -d (delete the password .. passwordless login)
              -S (status)
    

 ex:   useradd  user1
       useradd  -u 1010  user2
       useradd  -g hr user3
       useradd -G hr user4
       useradd -g hr -G finance user5
       useradd -s /sbin/nologin user6
       useradd -c "FTP User" -s /sbin/nologin user7


  ****Fields in  /etc/passwd****
  instructor:x:1000:1000::/home/instructor:/bin/bash
    1        2  3    4   5   6               7
  squid:x:23:23:Proxy Server:/var/spool/squid:/sbin/nologin
    1   2  3 4      5             6               7


 1.Username: It is used when user logs in.
 2.Password: An x character indicates that encrypted password is stored in /etc/shadow file.
 3.User ID (UID)
 4.Group ID (GID)
 5.User ID Info: The comment field. It allow you to add extra information about the users such as user's full name, phone number etc. 
 6.Home directory: 
 7.Shell: 



  ****Fields in /etc/shadow****

   instructor:$1$WR0GVXVl$bnJ3Cd032bpdiliWe:16040:0:99999:7: : :
     1                 2                     3    4  5    6 7 8
  
1.User name : It is your login name
2.Password: It your encrypted password. ( $1$ .. MD5 ,  $6$ .. SHA )
3.Last password change (lastchanged): Days since Jan 1, 1970 that password was last changed
4.Minimum: The minimum number of days required between password changes i.e. the number of days left before the user is allowed to change his/her password
5.Maximum: The maximum number of days the password is valid (after that user is forced to change his/her password)
6.Warn : The number of days before password is to expire that user is warned that his/her password must be changed
7.Inactive : The number of days after password expires that account is disabled
8.Expire : days since Jan 1, 1970 that account is disabled i.e. an absolute date specifying when the login may no longer be used
  

USERMOD :  to modify a user account properties without deleting the user account.

               usermod  options  uname

           options:   -u  userid
		      -g  primary group id
		      -G  secondary group id
		      -s   shell
		      -c   commentspace
		      -d   homedirectory
                      -l   loginname

Add a user to multiple secondary groups,  
                                     usermod -G group -a user

To remove a user from a secondary group,    gpasswd  -d   username  groupname


USERDEL : to delete a user account
 
                   userdel   options   uname

                   options:  -r (recursively delete everything)
			     -f (delete forcefully ever if the account is logged in)

               ex:  userdel  user1  ( removes the user account but it won't delete his data)
                    userdel -rf user1  ( removes everything related to user1)


NOTE:  1. The default user administration options are available in, 

                     /etc/login.defs
		     /etc/defaults/useradd

       2. When we are creating a user account,
			/etc/passwd ( users db file)
 			/etc/shadow (users passwords file)
			/etc/group (group information file)  are going to update
		And
			home directory creates as ( /home/username)
			user mail mox is creates as (/var/spool/mail/username)

      3. id username  --> with this you will get user along with the groups information
         finger username --> it gives you the user information


chage command (change user password expiry information)
--------------
The chage command changes the number of days between password changes and the date of the last password change.
This information is used by the system to determine when a user must change his/her password.


  chage  options   username

Options:
  -d 	set date of last password change
  -E 	set account expiration date
  -I 	set password inactive after expiration
  -l 	show account aging information
  -m 	set minimum number of days before password change
  -M 	set maximim number of days before password change
  -W 	set expiration warning days

Examples:
-------------
#chage -l hari                       ( shows password aging information for the user hari ) 
#chage -m 3 -M 60 -W 5 -I 5 hari (min days -- 3,max days--60, warning days--5,inactive days--5 for the user hari) 

#chage -d 0 hari   (To preempt user to change password at first login)

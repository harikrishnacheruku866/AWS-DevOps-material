Logical Volume Manager
pvcreate  /dev/sdc1
vgcreate vg_apps /dev/sdc1
lvcreate -l +100%FREE -n lv_apps vg_apps
mkfs.xfs  /dev/mapper/vg_apps-lv_apps
echo "/dev/mapper/vg_apps-lv_apps /apps   xfs    defaults   0 0" >> /etc/fstab
mkdir /apps
mount /apps

pvcreate  /dev/sdb1
vgcreate vg_logs /dev/sdb1
lvcreate -l +100%FREE -n lv_logs vg_logs
mkfs.xfs  /dev/mapper/vg_logs-lv_logs
echo "/dev/mapper/vg_logs-lv_logs /logs   xfs    defaults   0 0" >> /etc/fstab
mkdir /logs
mount /logs
df -Ph




Server build completed.

Created mount point /usr/share/nginx/html all the newly build servers.


   echo "- - -" > /sys/class/scsi_host/host0/scan
  echo "- - -" > /sys/class/scsi_host/host1/scan
 echo "- - -" > /sys/class/scsi_host/host2/scan
 echo "- - -" > /sys/class/scsi_host/host3/scan
lsblk

/dev/mapper/vg_rcpylsdbpgr01-LogVol02

/dev/mapper/vg_pgsql-lv_pgsql

/dev/mapper/vg_root-lv_root


/dev/mapper/vg_db-lv_db                                              800G  777G   24G  98% /var/lib/pgsql

/dev/mapper/vg_db-lv_db                                              350G  346G  4.3G  99% /var/lib/pgsql



Add 200GB to /u03
Add 100GB to /u04
Add 200GB to /u06

sde                            8:64   0  200G  0 disk
└─sde1                         8:65   0  200G  0 part
  └─vg_oracle-archive_lv_u04 253:5    0  300G  0 lvm  /u04

sdd                            8:48   0  550G  0 disk
└─sdd1                         8:49   0  550G  0 part
  └─vg_oracle-data_lv_u03    253:4    0  750G  0 lvm  /u03
sde                            8:64   0  200G  0 disk


sdg                            8:96   0  150G  0 disk
└─sdg1                         8:97   0  150G  0 part
  └─vg_oracle-lv_u06         253:7    0  350G  0 lvm  /u06
 
/dev/mapper/vg_oracle-archive_lv_u04                                       300G   25G  276G   9% /u04
/dev/mapper/vg_oracle-lv_u06                                               350G   48G  303G  14% /u06
/dev/mapper/vg_oracle-data_lv_u03                                          750G  307G  444G  41% /u03
/dev/mapper/vg_oracle-temp_lv_u02                                          100G   12G   89G  12% /u02
/dev/mapper/vg_oracle-os_lv_u01                                             50G   31G   20G  61% /u01


@raghu we have extended the 300gb to /mysql on rcpacbdbmys102 and now disk space is under the threshold level

[root@rcpacbdbmys102 ~]# df -h /mysql
Filesystem                  Size  Used Avail Use% Mounted on
/dev/mapper/vg_db-lv_mysql  2.0T  1.2T  865G  58% /mysql
[root@rcpacbdbmys102 ~]#


941  24/10/19 22:17:07 psql -U esuser -d blackblue_master -f ~/1.48.0_up.sql
  942  28/10/19 06:35:36 fdisk -l
  943  28/10/19 06:35:41 fdisk /dev/sde
  944  28/10/19 06:35:58 pvcreate /dev/sdd1
  945  28/10/19 06:36:00 df -hT
  946  28/10/19 06:36:22
  947  28/10/19 06:36:23 pvs
  948  28/10/19 06:36:37
  949  28/10/19 06:37:03 df -hT /var/lib/pgsql
pvcreate /dev/sdl1
pvcreate /dev/sde1


/dev/mapper/vg_db-lv_mysql


/dev/mapper/vg_db-lv_mysqllogs                                        40G   19G   22G  46% /mysqllogs

/dev/mapper/vg_db-lv_mysqllogs

vgextend vg_db /dev/sde1


/dev/mapper/vg_db-lv_mysql                                                         1.7T  1.2T  565G  68% /mysql


lvextend -r -l +100%FREE /dev/mapper/vg_db-lv_mysql
lvextend -r -l +100%FREE /dev/mapper/vg_oracle_undo-lv_u06

xfs_growfs /dev/mapper/vg_db-lv_mysqllogs  

 23  22/07/19 02:14:05 pvcreate /dev/sdb2; vgextend vg_docker /dev/sdb2; lvextend -r -l +100%FREE /dev/mapper/vg_docker_lv_docker
 
 
 
pvcreate /dev/sdc1
vgextend vg_workfusion /dev/sdc1
lvextend -l +100%FREE /dev/mapper/vg_workfusion-lv_workfusion
xfs_growfs /dev/mapper/vg_workfusion-lv_workfusion

/dev/mapper/vg_workfusion-lv_workfusion

resize2fs /dev/mapper/vg_root-LogVol01


xfs_growfs /dev/mapper/vg_workfusion-lv_workfusion



183  13/12/19 12:36:58 df -h /gpdata
  184  28/1
   24  22/07/19 02:14:29 lvdisplay
   25  22/07/19 02:14:37 mkfs /dev/vg_docker/lv_docker
   26  22/07/19 02:14:58 mkfs.xfs /dev/vg_docker/lv_docker
   27  22/07/19 02:15:17 mkfs.xfs -f /dev/vg_docker/lv_docker
   28


/dev/mapper/vg_oracle_archive-lv_u04      100G
 
/dev/mapper/vg_oracle_undo-lv_u06      50G

fdisk /dev/sdb

lsblk
pvcreate  /dev/sdb1
vgcreate vg_nginx /dev/sdb1
lvcreate -l +100%FREE -n lv_nginx vg_nginx
mkfs.xfs  /dev/mapper/vg_nginx-lv_nginx
echo "/dev/mapper/vg_nginx-lv_nginx  /usr/share/nginx/html  xfs    defaults   0 0" >> /etc/fstab
mkdir -p /usr/share/nginx/html
mount /usr/share/nginx/html
df -Ph
   
pvcreate /dev/sdb1
vgcreate vg_workfusion /dev/sdb1
lvcreate -n lv_workfusion -l 100%FREE vg_workfusion
mkfs.xfs /dev/mapper/vg_workfusion-lv_workfusion
echo "/dev/mapper/vg_workfusion-lv_workfusion  /app/workfusion  xfs    defaults   0 0" >> /etc/fstab
mkdir -p /app/workfusion
mount -a
df -h




subscription-manager register --org="companyname" --activationkey=prod-rhel-7-x86_64-ak --serverurl=https://rhn.company.com:8443/rhsm --baseurl=https://rhn.company.com/pulp/repos

   
pvcreate  /dev/sdb1
vgcreate vg_app /dev/sdb1
lvcreate -l +100%FREE -n lv_app vg_app
mkfs.xfs  /dev/mapper/vg_app-lv_app
echo "/dev/mapper/vg_app-lv_app /var/lib/rabbitmq    xfs    defaults   0 0" >> /etc/fstab
mkdir /var/lib/rabbitmq
mount /var/lib/rabbitmq
df -Ph
 
/dev/mapper/vg_mysqllogs-lv_mysqllogs
     
   VolGroup01-LogVol05
   
/dev/mapper/data-data--oracle
                      2.5T  2.4T   20G 100% /u03



pvcreate  /dev/sdd1
vgcreate vg_commitlog /dev/sdd1
lvcreate -l +100%FREE -n lv_commitlog vg_commitlog
mkfs.xfs  /dev/mapper/vg_commitlog-lv_commitlog
echo "/dev/mapper/vg_commitlog-lv_commitlog /commitlog   xfs    defaults   0 0" >> /etc/fstab
mkdir /commitlog
mount /commitlog
df -Ph

/dev/mapper/vg_app-lv_app

/dev/mapper/data-data-oracle
EasyMoney2019



fdisk /dev/sdc
   lsblk
pvs
pvcreate /dev/sdl1
vgs

/dev/mapper/vg_data-lv_oracle--data

/dev/mapper/vg_db-lv_mysql
/dev/mapper/vg_db-lv_mysqllogs


/dev/mapper/vg_app-lv_app

/dev/mapper/vg_db-mysql

vgcreate vg_db /dev/sdc1
vgextend vg_data /dev/sdf1
lvextend -l +100%FREE /dev/mapper/vg_db-mysql
resize2fs /dev/mapper/vg_root-lv_root
 xfs_growfs /dev/mapper/vg_db-mysql
 xfs_growfs /dev/mapper/vg_db-lv_pgsql
 
 
 /dev/vg_db/lv_db        /var/lib/pgsql  xfs     defaults        0       2
 
 
 /dev/mapper/vg_os-lv_oracle_os  /u01    ext4    defaults        1 0


  pvcreate /dev/sdc1
 vgcreate -s 32 vg_data /dev/sdb1
 lvextend -L200G -n /dev/mapper/vg_db-lv_mysql
 lvs
 lvcreate -l +100%FREE -n lv_home vg_data
 lvs
 mkfs.xfs /dev/vg_data/lv_home
 mkfs.xfs /dev/vg_data/lv_logs
 vi /etc/fstab
 mkdir /home
   70  19/0


pvcreate /dev/sdb1
vgcreate  vg_data_u01 /dev/sdb1
lvcreate -l +100%FREE -n lv_data_u01 vg_data_u01
mkfs.xfs /dev/vg_data_u01/lv_data_u01


production-unified-communications-12 i-05b0fd5f78f24c966 us-east-1a
production-unified-communications-15 i-0a1fdec9fa8b76de8 us-east-1a
production-unified-communications-redis i-049a00368b3a43389 us-east-1a





pvcreate /dev/sdb1
vgcreate  vg_data_u01 /dev/sdb1
lvcreate -l +100%FREE -n lv_data_u01 vg_data_u01
mkfs.xfs /dev/vg_data_u01/lv_data_u01
mkfs.xfs /dev/vg_data_u01/lv_logs_u01


vi /etc/fstab
mkdir -p /db/archivelogs
mount -a
df 0h
df -h
   38  19/04/19
   
   
   169  21/05/18 04:35:17 vgextend vg_app /dev/sdc1


lvcreate -l +100%FREE /dev/mapper/vg_db-lv_u01
 



  lvcreate -L30G -n lv_u01 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u01
 
 
  lvcreate -L50G -n lv_u02 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u02
 
 
 
  lvcreate -L3600G -n lv_u03 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u03
 
 
 
  lvcreate -L100G -n lv_u04 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u04
 
 
  lvcreate -L20G -n lv_u05 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u05
 
 
  lvcreate -L29G -n lv_u06 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u06
 
 
 
 
 
 
 
  lvcreate -L50G -n lv_u03 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u01
 
 

 lvcreate -L50G -n lv_u03 vg_db
 
  mkfs.xfs /dev/mapper/vg_db-lv_u01
 
 
 
pvs
lvcreate -l +100%FREE -n lv_u03 vg_db
 
mkfs.xfs /dev/mapper/vg_db-lv_u03


lvcreate -l +100%FREE -n lv_u04 vg_db
 
mkfs.xfs /dev/mapper/vg_db-lv_u04



lvcreate -l +100%FREE -n lv_u05 vg_db
 
mkfs.xfs /dev/mapper/vg_db-lv_u05



lvcreate -l +100%FREE -n lv_u06 vg_db
 
mkfs.xfs /dev/mapper/vg_db-lv_u06



echo "/dev/mapper/vg_db-lv_db /data   ext4    defaults   0 0" >> /etc/fstab
mkdir /data
mount /datavi

echo "/dev/mapper/vg_db_u01-lv_u01 /u01   xfs    defaults   0 0" >> /etc/fstab
echo "/dev/mapper/vg_db_u02-lv_u02 /u02   xfs    defaults   0 0" >> /etc/fstab
echo "/dev/mapper/vg_db_u03-lv_u03 /u03   xfs    defaults   0 0" >> /etc/fstab
echo "/dev/mapper/vg_db_u04-lv_u04 /u04   xfs    defaults   0 0" >> /etc/fstab
echo "/dev/mapper/vg_db_u05-lv_u05 /u05   xfs    defaults   0 0" >> /etc/fstab
echo "/dev/mapper/vg_db_u06-lv_u06 /u06   xfs    defaults   0 0" >> /etc/fstab


mkdir /u01
mkdir /u02
mkdir /u03
mkdir /u04
mkdir /u05
mkdir /u06

mount /u01
mount /u02
mount /u03
mount /u04
mount /u05
mount /u06

df -Ph




 
 
  pvcreate /dev/sdb1
 pvcreate /dev/sdc1
pvcreate /dev/sdd1
pvcreate /dev/sde1
pvcreate /dev/sdf1
pvcreate /dev/sdg1
pvcreate /dev/sdh1

  vgcreate vg_db /dev/sdb1
  vgextend vg_db /dev/sdc1
  vgextend vg_db /dev/sdd1
  vgextend vg_db /dev/sde1
  vgextend vg_db /dev/sdf1
  vgextend vg_db /dev/sdg1
  vgextend vg_db /dev/sdh1
 
 
 
 pvcreate  /dev/sdc1
 vgextend vg_db /dev/sdc1
 lvextend -L +200G /dev/mapper/vg_db-lv_mysql
 lvextend -L +99G -n /dev/mapper/vg_db-lv_mysqllogs
 xfs_growfs /dev/mapper/vg_db-lv_mysql
 xfs_growfs /dev/mapper/vg_db-lv_mysqllogs
 df -h


 /etc/vmware-tools/services.sh start

/exports/scripts/VMware_tools_upgrade_version.sh

 vmware-toolbox-cmd -v
 
 /etc/vmware-tools/services.sh status
 
 
 systemctl status vmtoolsd.service
 /exports/scripts/install_vmtools.sh
 /etc/vmware-tools/services.sh start
 vmware-toolbox-cmd -v
 /etc/vmware-tools/services.sh status
 


225  30/09/19 01:35:09 vi /etc/yum.conf
  226  30/09/19 01:35:35 yum remove open-vm-tools* -y
  227  30/09/19 01:35:56 yum install open-vm-tools -y
  228  30/09/19 01:36:15 /etc/vmware-tools/services.sh status
  229  30/09/19 01:36:21 vmware-toolbox-cmd -v
  230  30/09/19 01:36:49 yum install vmware-vm-tools-devel
  231  30/09/19 01:36:59 yum install vm-tools-devel
  232  30/09/19 01:37:16 yum install open-vm-tools-devel
  233  30/09/19 01:37:42 ll /etc/vmware-tools/services.sh
  234  30/09/19 01:38:33 rpm -ql open-vm-tools-devel-10.2.5-3.el7.x86_64
  235  30/09/19 01:39:16 rpm -ql open-vm-tools-10.2.5-3.el7.x86_64
  236  30/09/19 01:39:46 cd /etc/vmware-tools/scripts
  237  30/09
    yum --disableexcludes=main --enablerepo=mysql-commercial-embedded-compat-5.7.25-1.1.el7.x86_64.rpm repolist

rsync -avuh /u05/* /u05_new/

rsync -avuh /u04/* /u04_new/

rsync -avuh /u02/* /u02_new/

/bin/cat /dev/null > /tmp/check_logfiles_cognos_server_errors-monitoring_status.txt

0 2 * * * /bin/gzip /usr/local/web*/logs/*.log.20??-??-??

A - ====== VMware Engineer Task ==============

Take VMware snapshots on scheduled day 2 hours before implementation time for the server list


B - ==== Linux Engineer=======================

Step 1: Confirm VM snapshots were successfully taken earlier:

Step 2: Update SELINUX from disabled to permissive on list of servers.

Edit /etc/selinux/config
Change "SELINUX=disabled"
to "SELINUX=permissive"

Step 3: OS Patching
as root execute: yum update -y


Step 4: reboot server
as root execute: reboot


Step 5: Startup application
- start application on servers

Step 6:Check Application up

- check application is up on all servers

Step 7: Update MTU
as root execute:/exports/scripts/change_mtu_value.sh


Roll back from VM snapshot from rp1 production Vcenter

) Confirm kernel version is at minimum 3.10.0-957.21.3.el7.x86_64:
uname -r
2) Confirm MTU is 9000
cat /sys/class/net/eth0/mtu

3) Confirm SELINUX is "permissive" with the following command
getenforce

What's New What's Coming product Team will verify.

AWS with DevOps batch-56
++++++++++++++++++++++++
Date: 28-04-2025
================
Trainer : Har!


==========================
Linux Disk partitions
==========================

Where we installed the Linux OS --> we need a hard disk space to install the os

--> Harddisk (HDD) 20GB

Where we can see the hard disk information in the Linux machine 

            $ df -hT    

                   disk free

            $ lsblk   (  list of block devices)



In Linux file system hierarchy --> hard disk information will be available under the which directory

AWS with DevOps Batch-55
========================
Date: 30-04-2025
================
Trainer : Har!

================
Disk Partitions
================

Disks are like -> /dev/sda , /dev/sdb ==> whole disks
                  /dev/sdb1 , /dev/sdb2 ==> Partitions on those disks

mount point         purpose          typical filesystem   disks
 
/boot               boot files         ext4 , xfs         /dev/sda1

/

/home

swap



fdisk  --> create the partitions 

lsblk  ---> lists block devices

blkid  ---> shows UUID and type info


Temporary partitions:
+++++++++++++++++++++
Partitions that are mounted manually while running the machine using command like mount 
it will not mount it again after reboot the machine. 

$mount /dev/sdb1  /applogs
$mount /dev/sbd2  /dbalogs


after reboot: these mounts are gone because of these mount points are not added
in the /etc/fstab (file)


Permanent partitions:
=====================

The below are mounted in the /etc/fstab . that's why these are mounted after reboot also..
/dev/mapper/centos-root xfs        17G  5.9G   12G  35% /
/dev/sda1               xfs      1014M  150M  865M  15% /boot

Partitions that are mounted automatically at boot, and they persist across reboots.

always mounted to the same mount point like / /boot etc ..

==> configurations stored in /etc/fstab
==> Automatically mounted at startup


================
Unmount in Linux
=================
The umount command in Linux is used to unmount a mounted filesystem it will detaches a device or partition from the hierarchy.

syn: umount <directory-name>
ex:  umount /applogs
     umount /dblogs

I don't want to mount after reboot what you can do. U can do like open the file 
vi /etc/fstab

#/dev/sdb1  /applogs xfs defaults 0 0
#/dev/sdb2  /dblogs xfs defaults 0 0

if the mount point is used by someother user.I want to unmount forcefully

# umount -f /applogs
# umount -f /dbalogs


fstab entry format:
===================
Syn :  <device> <mount_point> <filesytem_type> <options> <dump> <fsck>
ex:    /dev/sdb2  /dblogs         xfs            defaults  0       0

1 is nothing but enable

0 is nothing but disable

==> device :  Device Name (eg .. /dev/sdb1 )

==> Mount Point : Where the devices is mounted in the directory(/applogs, /dblogs)

==> Filesystem : Filesytem type (eg ext3, ext4, xfs, ntfs, vfat, swap)

==> Options : Mount options ( defaults, noatime, ro, rw)

==> Dump : used by dump utility (by default 0)

==> fsck : filesystem checks at boot ( 1 for root, 2 for others, 0 skip)

blkid:
=====
it finds the UUID 

blkid

==================================================
package management(most imp topic in the Linux os)
===================================================

what are the commands to install the softwares on Linux machine

task1: create a temparory mount point with 5gb - /appserver

task2: create a permanent mount point with 3gb - /dbserver



# Linux SysOps Handbook

An essentials notebook for the common knowledge and tasks of a Linux system admin.

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
<a href="https://www.youtube.com/@TechWorldWithHari/featured)" alt="YouTube ">


## Table of Content

- [1. Processes](#processes)
- [2. User Management](#user-management)
- [3. Shell Tips and Tricks](#shell-tips-and-tricks)
- [4. File Permissions](#file-permissions)
- [5. Background Services and Crons](#background-services-and-crons)
- [6. Linux Distros](#linux-distros)
- [7. Logs, Monitoring, and Troubleshooting](#logs-monitoring-and-troubleshooting)
- [8. Network Essentials](#network-essentials)
- [9. System Updates and Patching](#system-updates-and-patching)
- [10. Storage](#storage)
- [11. Notes & Additional Resources](#notes-and-additional-resources)

## Processes

List the current active process with their statuses, numbers, resource usage, etc. using the command `ps`.

```shell
$ ps auxc
```

Quoting man's page documentation on `ps`: "A different set of processes can be selected for display by using any combination of the `-a, -G, -g, -p, -T, -t, -U, and -u` options.  If more than one of these options are given, then ps will select all processes which are matched by at least one of the given options".

The daemon `systemd` process starts during boot time, and remains active until the shutdown. It's the parent process for all other process in the system.

Each process contains several main parts, such as: PID, state, virtual space address (memory), threads, network and file descriptors, scheduler information, and links. Processes are controlled and respond to signals. The states that a process can transition among are depicted below:

<img src="https://github.com/abarrak/linux-sysops-handbook/blob/main/images/process-states.png?raw=true" width="700px" />

To observe the states and other information of the processes interactively, use the `top` command.

To run executables as background process (job), append an ampersand to it:

```shell
$ echo "Hi .. looping:" | sleep 10000 | echo "done." &
```

To view the current jobs, and their details run `job`, `ps j` commands respectively.

To bring back a job in the foreground in the current session, and send it back use the following:

```shell
$ fg %<job-no>
$ ctrl+z
$ bg %<job-no>
```

Use the command `kill -l` to see the available signals to send to processes, like interrupt, terminate, resume, etc.

```shell
$ kill -l
$ kill -9 5921
$ kill -SIGTERM 6152
```

Use `killall` to operate on multiple processes using their executable name. Use `pkill` for filtering with more options.

```shell
$ killall -15 nginx
$ pkill -U tester
```

Finally, use `pstree` and `pgrep` to view process parent/child tree and search for processes by pattern.

```shell
$ psgrep -u abdullah -l
```

## User Management

The users and groups are managed in `/etc/passwd` and `/etc/group` files.

```shell
$ tail /etc/passwd
$ tail /etc/group
$ tail /etc/shadow
```

The commands to manage a user are as follows:
- `useradd`
- `usermod`
- `userdel`

And for groups:
- `groupadd`
- `groupmod`
- `groupdel`

Each user in the system is associated with unique user id `uid`, and each group is associated with `gid`.

```shell
$ id abdullah
```

Use flags `-g` and `-aG` for users to replace group or append group, respectively:

```shell
$ sudo usermod -G admins abdullah
$ sudo usermod -aG staff abdullah
```

To lock or unlock a user account, us the `-L`, `-U` options respectively.

```shell
$ usermod -L <username>
$ usermod -U <username>
```

To restrict service user accounts (e.g. accounts for web servers), the shell can be set to `nologin`:

```shell
$ usermod -s /sbin/nologin nginx_usr1
```

To change a user password, use the command `passwd` interactively. Additionally `change` command sets the password policy in the system.


Use the command `su - <username>` to switch to the specified user. which will promote for her password. Running the command without username will switch to
the root user. To avoid cases where password is not available, use `sudo` to switch accounts using current user password only and according to rules in `/etc/sudoers` directory. Use `sudo -i` to gain an interactive root shell.


## Shell Tips and Tricks 


Getting used to [bash language and its fundamentals](https://learnxinyminutes.com/docs/bash/) like conditions, looping, functions, etc. is recommended.

The popular files and text processing and manipulation utilities are important to master, such as:

- `cat`
- `cp`
- `rm`
- `mkdir`
- `rmdir`
- `touch`
- `less`
- `more`
- `head`
- `tail`
- `grep`
- `find`
- `locate`
- `wc`
- `sed`

Use the command `date` to print the current date and time or others in the past and future:

```shell
$ date +%x
```

The standard terminal channels in Linux are 3: `stdin`, `stdout`, and `stderr` where the first is for input stream and the latters for output and error streams. 

By default the successful command results are outputted to `stdout` (equivalent to `>`). You can explicity redirect to `stdout` or `stderr` as follows:

```shell
$ echo "hi there!" 1> error_log.txt
$ cat ~/incorrect-path 2> error_log.txt
# To both:
$ (echo "hi" && cat ~/wrong) >> log.txt 2>&1
```

To discard output stream, redirect it to the special directory `/dev/null`.

The standard input can be captured via redirection or file pipes:

```shell
$ cat <<EOF
This is coming from the stdin
EOF

$ cat LICENSE | wc -l
```

The `ssh` command used to connect to servers in secure manner using OpenSSH library using public key cryptography. The configuration and known hosts are kept under `/etc/ssh` system-wide or in `~/.ssh/` in current user's home directory. On the other hand `scp` is used for secure copy on secure shell fashion.

The following list of commands are used to generate and manage ssh keys between client and server:

1. `ssh-keygen`: to generate new key pairs.
2. `ssh-copy-id`: to copy the public key to the remote machines.
3. `ssh-agent`: to simplify working with the private key passphrase if used.
4. `ssh-add`: to cache the passphrase in the current session.


## File Permissions

A file permissions are considered in three dimensions: the owner user, the owner's group, and rest of other users. 

Showing the permisison of files and directories can be using `ls -l`, `ls -ld` respectively.

The basic permission types are: read (r), write (w), and execute (x) on both folders and files:

```shell
$ ls -l
-rw-r--r--  1 abdullah  staff  35149 Jan 30 17:20 LICENSE
```

Setting the files and folders permission is done by `chmod` command and can be using symbols or digits. 

The symbols/letter way is made for `u`, `g`, `o`, or `a` basis for the user, group, others, or all. Whereas, the digits are written for all at once in sequence for user, group, and others. Examples are below for both cases:

```shell
# Use + to add, - to remove, and = to reset.

# adding execute permission to user
$ chmod u+x my-file.txt
# setting read, execute to all on a folder and its content
$ chmod -R a=rX my-folder

$ chmod 740 special.txt
$ chmod -R 444 read-only-files/
```

`chown` is used to change the ownership of folder/files to users or groups respectively. `chgrp` is a shortcut to group change only. The root or the owner are only people can change ownership and in the latter, she needs to be part of the new target group before the change.

```shell
$ chown sarah file-10.txt
$ chown sarah:staff file-12.txt

$ chown :admins server_log.txt
$ chgrp operators server_log.txt
```

Lastly, a fourth dimension at the start can be added to represent the special permissions of `suid s`, `sgid s`, and `sticky t` which control executable nature of files to be of owner users, and groups regardless of the current user. The last is to restrict deletion for only the root and owner always.

```shell
$ chmod a+t protected-folder/
$ chmod -R 1444 read-only-protected/
```

## Background Services and Crons

`systemctl` is the command used to list, manage, and check background processes or so called `daemons`.

To list the available categories of daemons, run:

```shell
$ systemctl -t help
```

There are 3 types of daemons: 1. services, 2. sockets, 3. paths. Use the following to see the system's processes in each:

```shell
$ systemctl
$ systemctl list-units --type=service
$ systemctl list-units --type=socket --state=LOAD
$ systemctl list-units --type=path --all
$ systemctl list-unit-files
```

The states `enabled` and `disabled` indicate wether a service is lanuched on startup or not. The subcommands `enable` and `disable` can be used to control this aspect.

To view the status of a daemon use the `status` command or its state shortcuts:

```shell
$ systemctl status kubelet
$ systemctl is-active dockerd
$ systemctl is-enabled sshd.service
```

Use the subcommands `start`, `stop`, `restart`, and `reload`, `reload-or-restart` to control daemons.

Additionally, use the following to list a daemon dependencies:

```shell
$ systemctl list-dependencies nginx.service
```

Finally, to resolve conflicting services making them unavailable, the `mask` and `unmask` commands can be used to point a deamons config to `dev/null` then back to normal respectively.


The cron daemon `crond` is responsible for managing the user's and system's scheduled jobs. Use the command `crontab` to manage jobs and their files in the user account or in the system wide `/etc/crontab`, `/etc/cron.d/` locations.

```shell
$ sudo crontab -l
$ sudo crontab -e
$ vim /etc/cron.d/my-backup
```

The syntax of crontab entries is captured by the diagram below. Use the [following tool to quick assistance.](https://crontab.guru/)

<img src="https://github.com/abarrak/linux-sysops-handbook/blob/main/images/crontabs.jpg?raw=true" />

An example of a cron entry that runs backup command, every day at 5:00 AM:

```shell
0 5 * * * /usr/bin/daily-backup
```

## Linux Distros

In 1991, Linux kernel was introduced by Linus Torvalds, and combined with GNU project, which was previously created in 1983-1984 as open source OS programs and components. This formed what we call today Linux distribution, a Unix-like operating system.

Today the Linux operating system is supported on most hardware platforms.  [Linux works on almost every architecture from i386 to SPARC](https://www.linuxtrainingacademy.com/linux-distribution-intro/). Linux can be found on almost every type of device today, from watches, televisions, mobile phones, servers, desktops, and even vending machines.

One of the major distinction between Linux distributions is the package management part and how software is installed and managed. There are multiple package formats, and the most common ones are Debian (deb), RedHat Package Manager (RPM).

<img src="https://github.com/abarrak/linux-sysops-handbook/blob/main/images/distros.jpg?raw=true" width="700px" />

Here's a listing for the common Debian based distributions:

- Debian.
- Ubuntu.
- Linux Mint.
- Kali Linux.

And here's for RPM based distributions:

- Fedora.
- RedHat Enterprise Linux (RHEL).
- CentOS.
- openSUSE.

<img src="https://github.com/abarrak/linux-sysops-handbook/blob/main/images/timeline.png?raw=true" width="700px" />

## Logs, Monitoring, and Troubleshooting

You can monitor the system's resources usage, uptime, and sessions' load leverages over time as follows:

```shell
$ top
$ uptime
$ w
```

Use `lscpu` to see the system's CPU in use and other details.

The system events and processes traces are usually kept in as logs in `/var/log` directory. There are two categories of logs: 1. essential system logs via `journald`, that are wiped across boots by default (can be configured to persist). 2. `rsyslog` logs that persist by default and organized inside `/var/log/` folder. Mainly, the logging mechanism in Linux follows the standard `syslog` protocol for the system's messages, events, security incidents, mailing, and jobs logs, while other programs may or may not follow `syslog` format identically.


As explored in section (3), use `cat`, `head`, `tail` commands to interactively see or follow the logs.

```shell
$ head -n 50 /var/logs/mail.log
$ tail -f /var/logs/mysql.log
```

You can configure `rsyslog` service and manage it as any daemon:

```shell
$ vim /etc/rsyslog.conf
$ systemctl reload rsyslog
```

On the other hand, use `journalctl` to view and follow the system's `journald` log entries, which resides in `/run/log/journal`.

```shell
$ journalctl -n 50 -p err 
$ journalctl -f
$ journalctl _PID=6610
```


## Network Essentials

For effective work on the system network configurations and troubleshooting, it is essential to review network/internet protocols (TCP/UDP) and IPv4/IPv6 concepts [(Ref.1)](https://www.ibm.com/cloud/learn/networking-a-complete-guide), [(Ref.2)](https://www.cloudflare.com/learning/network-layer/what-is-a-protocol/).


See the hostname of current machine or set it as below:

```shell
$ hostname
$ hostnamectl set-hostname rhel.n1.apps.com
```

The host name is managed under `/etc/hostname`. 

The host connection is either managed dynamically (`DHCP`) configured in `/etc/resolv.conf` or manually in `/etc/hosts` file.

The `ping` utiltiy helps for connectivity checking:

```shell
$ ping 172.168.9.13
$ ping -c4 github.com
$ ping6 2001:db8:3333:4444:5555:6666:7777:8888
```

To see the network routing table and interfaces, use the following:

```shell
$ ip route
$ ip -6 route
$ ip help
$ ip show link
```

Use the command `nmap` [for advanced network investigation and security monitor and scan.](https://www.cyberciti.biz/security/nmap-command-examples-tutorials/)

```shell
# Scan a single ip address
$ nmap 192.168.1.1
 
# Scan a host name 
$ nmap -v server1.cyberciti.biz

# View open ports:
$ nmap --open 192.168.2.18

# Trace all pakets:
$ nmap --packet-trace 192.168.1.1
```

`NetworkManager` is the kernel feature [to manage network configurations in Linux](https://en.wikipedia.org/wiki/NetworkManager). `nmcli` is the terminal utility.

```shell
$ nmcli device wifi list
$ nmcli dev status
$ nmcli general hostname centos-8.cluster.internal
$ nmcli con show 
```


## System Updates and Patching

Managing the system packages varies depending on Linux distributions, but the essential parts are the same (installation, repositories, package managers, etc.). For Debian based distributions, `apt` is the package manager, whereas for Fedora / RHEL, `yum` is used.

Search for some package:

```shell
$ apt search <KEYWORD>
$ yum search <KEYWORD>
```

Install a package:

```shell
$ apt install <NAME>
$ yum install <NAME>
```


Update a package or all packages:

```shell
$ apt upgrade <NAME>
$ yum update <NAME>
```

Remove a package:

```shell
$ apt remove <NAME>
$ yum remove <NAME>
```

Show details on a package:

```shell
$ apt show <NAME>
$ yum info <NAME>
```

List all current packages on the system:

```shell
$ apt list --installed
$ yum list
```

Audit the history of package management actions:

```shell
$ cat less /var/log/apt/history.log | less
$ cat less /var/log/dnf.rpm.log | less
$ yum history
```

And finally, the package source repositories can be set up and updated through the following:

```shell
# list current enabled repos
$ yum repolist all
$ apt-cache policy

# manage and add repos in these directories:
$ cat /etc/apt/sources.list /etc/apt/sources.list.d/*
$ cat /etc/yum.repos.d/*
```

## Storage

Linux is formed for a unified file-system consists of all file systems provided by the hardware or virtual storage devices attached to the system. Essentially, everything in Linux is a file. It can be viewed as a reversed tree of nested directories starting from the root directory `/`.

<img src="https://github.com/abarrak/linux-sysops-handbook/blob/main/images/linux-file-system.png?raw=true" width="700px" />

Block devices are the mechanism that the kernel detects and identify raw storage devices (HDD, SSD, USBs, ..). [As the name indicates, the kernel interfaces and references them by fixed-size blocks (chunks of spaces)](https://www.digitalocean.com/community/tutorials/an-introduction-to-storage-terminology-and-concepts-in-linux). The block devices are stored in `/dev` directory by the OS, and has letters naming convention such as `/dev/sda`, `/dev/sdb`, `/dev/vda`, and appended numbers in case of partitions `/dev/sda3`. The attachment of the block device into the system is done through mounting it to a directory in the system.

Two operations are essential for using block storage:

**1. Partitioning:**

  Breaking the disk into reusable smaller units, each treated as own disk. 
  The main partitioning methods are MBR (Master Boot Record) and GPT (GUID Partition Table).
  Use `parted` or equivalent commands to prepare partitions of block devices.

**2. Formatting:**

  Preparing the device as a file-system to be read and write to. Many file-system formats exists like:

  - `Ext4`.
  - `XFS`.
  - `Btrfs`.
  - `ZFS`.


Additionally, LVM concepts focus on building more extensible storage layout by grouping physical volumes (PV) into logical groups (VG), then creating logical volumes from, with possibility of extending or reduction later on.

To see the block devices and currently attached file system with mounts, and disk usage:

```shell
$ blkid
$ mount
$ df -h
$ du -h /opt/data
```

The `lsof` command lists all active processes using the block device.

The permanent mounting process rely on `/etc/fstab` file to determine devices to mount on the boot time.

Use the commands `lsblk`, `mount`, and `unmount` to check and mount filesystem devices, respectively.


## Notes and Additional Resources

Use the `man` command to lookup the manual information on commands or topics in the system.

Additionally, the `info` command is the GNU documentation tool and provide more detailed materials.

Both provide shortcuts, navigation, and searching capabilities (e.g. `man -K <keyword>` to search across manual).


## Important System Directories

```shell
## DIRECTORIES ##
cat      /etc/hostname                       # Instance's hostname
cat      /etc/nsswitch.conf                  # List of Databases: 'passwd', 'hosts', and sources for those DBs
cat      /etc/hosts                          # Mapping of hostnames to IP addresses
cat      /etc/hosts.allow                    # Allowed hostnames, processed first
cat      /etc/hosts.deny                     # Denied hostnames, processed second
cat      /etc/nologin                        # If exists, only root can login. Contents of file displayed
cat      /etc/passwd                         # DB of info on users, can include hashed passwords, or x
cat      /etc/shadow                         # DB of users and hashed passwords + password config
cat      /etc/group                          # DB of groups + users in groups, can include group passwords
cat      /etc/gshadow                        # DB of groups and hashed passwords + password config
ls       /etc/skel                           # Its contents will be copied to each new user's /home/ directory
cat      /etc/profile                        # Set system wide environmental variables on users shells
file     /bin/bash                           # Unix shell and command language
cat      /etc/bash.bashrc                    # System wide bash initialization file
cat      /etc/aliases                        # Aliases for sendmail. Not bash aliases
cat      ~/.profile                          # User specific shell initialization script/file.
cat      ~/.bashrc                           # Personal bash initialization file for interactive, non-login shells
cat      ~/.bash_profile                     # Personal bash initialization file login shells (console or ssh)
cat      ~/.bash_aliases                     # Personal bash aliases config, can also go bash_profile, or bashrc
cat      ~/.bash_login                       # Additional config executed right after login
cat      ~/.bash_logout                      # Additional config executed right after logout
cat      ~/.bash_history                     # Bash command history
cat      /etc/issue                          # Message or system identification to be printed before the login prompt
cat      /etc/os-release                     # Contains OS info
cat      /etc/crontab                        # Contains the crontab file jobs and scheduling
ls       /etc/cron.daily                     # Contains the crontab scripts to be run daily
cat      /etc/anacrontab                     # Contains the anacrontab file jobs and scheduling
cat      /etc/at.allow                       # Determines which user can submit commands for later execution via at or batch
cat      /etc/at.deny                        # Determines which user can submit commands for later execution via at or batch
cat      /etc/protocols                      # DB of TCP/IP protocols + protocol number + description
cat      /etc/services                       # DB of services and TCP/UDP ports used + description
cat      /etc/timezone                       # Stores configured timezone
cat      /etc/localtime                      # Stores configured localtime
cat      /etc/sudoers                        # Determines the groups and users sudo priviledges. Edit with visudo
ls       /etc/sudoers.d/                     # Ideal place to add sudoers
cat      /etc/ntp.conf                       # Configuration file for for ntpd
cat      /etc/inetd.conf                     # Configuration file for inetd. Edit requires service restart
cat      /etc/xinetd.conf                    # Configuration file for xinetd. Edit requires service restart
ls       /etc/xinetd.d/                      # Configuration files for each service managed by xinetd . Edit requires service restart
cat      /etc/initramfs-tools/initramfs.conf # Configuration file for initramfs
ls       /etc/udev                           # Device Manager - udev (systemd). Execute changes from kernel in /sys and /dev
cat      /etc/udev/udev.conf                 # udev configuration file.
file     /usr/sbin/logrotate                 # Log rotation utility
cat      /etc/logrotate.conf                 # Configuration file for logrotate
ls       /etc/logrotate.d                    # Configuration files for logrotate - system packages
cat      /etc/logrotate.d/rsyslog            # Configuration files for logrotate - system rsyslog
cat      /etc/rsyslog.conf                   # Configuration file for syslog
ls       /etc/rsyslog.d                      # Configuration files for services
cat      /etc/rsyslog.d/50-default.conf      # Default logging rules
cat      /etc/updatedb.conf                  # Config file read by updatedb before updating the locate database
cat      /etc/environment                    # Stores the PATH env variable
cat      /etc/fstab                          # Where should partitions should be mounted and how
ls       /etc/rc0.d                          # System-v runlevel initiation - halt
ls       /etc/rc6.d                          # System-v runlevel initiation - reboot
cat      /etc/init/dbus.conf                 # dbus config file
file     /sbin/upstart                       # Upstart initialization script
ls       /etc/init                           # Contains configuration files used by Upstart
file     /sbin/init                          # System-V initialization script
ls       /etc/init.d                         # Contains scripts used by the System V init tools
cat      /etc/init.d/networking              # System-v script for service
cat      /etc/init.d/cron                    # System-v script for service
cat      /etc/init.d/halt                    # System-v script for service
cat      /etc/init.d/dbus                    # System-v script for service
cat      /etc/init.d/functions               # Contains functions to be used by most or all shell scripts stored in the /etc/init.d directory
cat      /etc/inittab                        # describes how the INIT process should set up the system in a certain run-level (RedHat - Sys-V)
ls -lrt  /bin/systemd                        # Systemd initialization script symlink
file     /lib/systemd/systemd                # Systemd initialization script
ls -lrt  /etc/systemd/system/                # Contains symlinks to files in lib/systemd/system/
ls       /lib/systemd/system/*.target        # Contains init scripts
cat      /etc/systemd/journald.conf          # Configuration for the systemd journal logging service
cat      /etc/default/grub                   # GRUB config. Run 'update-grub' to update grub.cfg
ls       /etc/grub.d/                        # Additional files to configure the GRUB menu
cat      /boot/grub/menu.lst                 # GRUB menu list config file
cat      /boot/grub/grub.cfg                 # GRUB 2 menu list config file
cat      /etc/dhcp/dhclient.conf             # Configuration file for /sbin/dhclient - DHCP
cat      /etc/network/interfaces             # Network interface configuration information (Debian)
cat      /etc/sysconfig/network              # Network interface configuration information (RedHat)
cat      /etc/sysconfig/network-scripts      # Network interface configuration information (RedHat)
cat      /etc/ssh/sshd_config                # OpenSSH service configuration file
cat      /etc/cups/cupsd.conf                # Configuration file for the CUPS scheduler
ls       /usr/share/X11/xorg.conf.d/         # Xorg configuration file directory
cat      /etc/apt/sources.list               # Lists the 'sources' from which packages can be obtained
cat      /etc/yum.conf                       # Yum configuration file
ls       /etc/yum.repos.d                    # A list of directories where to look for .repo files
cat      /etc/ld.so.conf                     # Contains a list of directories in which to search for libraries for ldconfig
ls       /etc/ld.so.conf.d/                  # Directories in which to search for libraries for ldconfig, add new libs here, run ldconfig
ls       /lib                                # Library directory, also searched by ldconfig
ls       /usr/lib                            # Library directory, also searched by ldconfig
ls       /dev/sd*                            # SCSI drives
cat      /proc/1/status                      # Pseudo filesystem with info on running process
cat      /proc/1/io                          # Pseudo filesystem with info on running process
cat      /proc/1/syscall                     # Pseudo filesystem with info on running process
ls       /var/log                            # Main directory for log files
cat      /var/log/syslog                     # Syslog log files
cat      /var/log/mail.log                   # Mail log files - MTA
cat      ~/.forward                          # Email forwarding configuration
ls       ~/.ssh/                             # Root dir of ssh keys and config
cat      ~/.ssh/id_rsa                       # Example of ssh private key
cat      ~/.ssh/id_rsa.pub                   # Example of ssh public key
cp       ~/.ssh/authorized_keys              # Configures permanent access using SSH keys - copy .pub keys here
cat      /etc/ssh/ssh_known_hosts            # Systemwide list of known host keys.
cat      ~/.ssh/known_hosts                  # list of host keys for user not already in the systemwide list
```

## System Administration Commands

```shell
## COMMANDS ##
which ls                                     # Locate a command directory
whereis ls                                   # Locate the binary, source, and manual page files for a command
file /etc/passwd                             # Determine file type
type ls                                      # Display information about command type
who                                          # Show who is logged on
who -r                                       # Print current runlevel
w                                            # Show who is logged on and what they are doing
whoami                                       # Print effective userid
id                                           # Print real and effective user and group IDs
man                                          # An interface to the on-line reference manuals
info                                         # Read Info docum
shutdown                                     # Halt, power-off or reboot the machine
shutdown -c
shutdown -r now
uptime                                       # Tell how long the system has been running.
tzselect                                     # View and adjust timezones
timedatectl                                  # Control the system time and date
timedatectl set-time "2015-11-08 08:00:00"
timedatectl set-timezone "Asia/Kathmandu"
timedatectl set-ntp false
locale                                       # Get locale-specific information - LC_ALL
date                                         # Print or set the system date and time
date +%s                                     # Print or set the system date and time in UNIX epoch time
ntpd                                         # Network Time Protocol (NTP) daemon - auto update
ntpdate                                      # Set the date and time via NTP - manual update
ntpdate pool.ntp.org
hwclock                                      # Read or set the hardware clock (RTC)
hwclock --systohc --localtime
hwclock --systohc --utc
vmstat                                       # Reports information about processes, memory, paging, block IO, traps, disks and cpu activity
lscpu                                        # Display information about the CPU architecture
lspci                                        # List all PCI devices
lsusb                                        # List USB devices
free                                         # Display amount of free and used memory in the system
uname -r                                     # Print system information --kernel-release
uname -p                                     # Print system information --processor
uname -o                                     # Print system information --operating-system
dmesg                                        # Print or control the kernel ring buffer
lsmod                                        # Show the status of modules in the Linux Kernel
modprobe                                     # Add and remove modules from the Linux Kernel
rmmod                                        # Remove a module from the Linux Kernel
env                                          # Display all environment variables
export                                       # Display all environment variables
export ENV=/home/user                        # Create new environment variable
declare -r ENV=/home/user                    # Declare variables and give them attributes
crontab -e                                   # Edit crontab for current user
crontab -l                                   # List crontab for current user
export VISUAL=nano; crontab -e               # Set nano as default editor
at                                           # Queue jobs for later execution
atq                                          # Examine jobs for later execution
atrm                                         # Delete jobs
batch                                        # Executes commands when system load levels permit
ping                                         # Send ICMP ECHO_REQUEST to network hosts
ping6                                        # Send ICMP ECHO_REQUEST to network hosts IPv6
dig                                          # DNS lookup utility
nslookup                                     # Query Internet name servers interactively
traceroute                                   # Trace the route to a host
traceroute6                                  # Trace the route to a host IPv6
tracepath                                    # Traces path to a network host discovering MTU along this path
tracepath6                                   # Traces path to a network host discovering MTU along this path IPv6
service                                      # Run a System V init script
service --status-all                         # Display status of all System V managed services
service ssh start                            # Start System V service
service ssh stop                             # Stop System V service
service ssh status                           # Display status of System V service
service ssh restart                          # Restart System V service
systemctl                                    # Control the systemd system and service manager
systemctl list-units                         # List known units
systemctl status sound.target                # Show terse runtime status information about one or more units
systemctl stop   sound.target                # Stop (deactivate) one or more units
systemctl start  sound.target                # Start (activate) one or more units
systemctl enable multi-user.target           # Enable one or more unit files or unit file instances
systemctl set-default multi-user.target      # Set the default target to boot into.
systemctl set-default graphical.target       # Set the default target to boot into.
systemctl isolate multi-user.target          # Start the unit specified and stop all others
ifconfig -a                                  # Display all network interfaces, even if down
ifconfig eth0 up                             # Bring a network interface up
ifconfig eth0 down                           # Bring a network interface down
ifup                                         # Bring a network interface up
ifdown                                       # Take a network interface down
route                                        # Show / manipulate the IP routing table
route -n                                     # Show numerical addresses instead of trying to determine symbolic host names
route add <> netmask <> gw <>                # Add a new route with a netmask and a gateway
route del                                    # Delete a route
ip a, ip addr, ip address                    # Display network interface info
ip link                                      # Display link info
ip route show                                # Show Routing Table entries
ip route add <>/<> broadcast <> via <> eth0  # Add Routing Table entry
netstat -r                                   # Display the kernel routing tables
netstat -at                                  # Display listening and non-listening sockets
lsof                                         # List open files
lsof /tmp                                    # List open files
iptables -L                                  # List all NAT rules
iwlist ens33 auth                            # Get wireless information from a wireless interface
netcat -l 12345                              # Opens arbitrary TCP and UDP connections and listens
netcat 192.168.0.12 12345                    # Sends input to netcat location
nc -l 12345                                  # Same as netcat
nc 192.168.0.12 12345                        # Same as netcat
nmap localhost                               # Network exploration tool and security / port scanner
dpkg -l                                      # Package manager for Debian - list packages
dpkg -i                                      # Package manager for Debian - install package
dpkg --purge                                 # Purge an installed or removed package, removes everything including conffiles
dpkg-reconfigure                             # Reconfigure an already installed package
apt-get update                               # APT package handling utility - update packages from sources in /etc/apt/sources.list
apt-get dist-upgrade                         # upgrade + attempt to upgrade the most important packages at the expense of less important ones
apt-get install                              # Install package and dependencies from sources in /etc/apt/sources.list
apt-get remove                               # Remove package. Leave config files
apt-get purge                                # Remove package. Delete config files
apt-get autoremove                           # Remove packages that are no longer needed
apt-cache pkgnames                           # Prints the name of each package APT knows
apt-cache search                             # Text search on all available package lists
apt-cache depends                            # Shows a listing of each dependency a package has
aptitude                                     # Interface to the Debian GNU/Linux package system - APT
rpm -i                                       # RPM Package Manager - install package
rpm2cpio                                     # Extract cpio archive from RPM Package Manager (RPM) package
cpio -idmv                                   # Tool for creating and extracting archives
yum update                                   # Interactive, rpm based, package manager
yum install                                  # Install package and dependencies
yum install --downloadonly --downloaddir=/tmp # Download the package to directory but do not install
yum update                                   # Update packages from sources
yum remove                                   # Remove package
yumdownloader                                # Download RPM packages from Yum repositories
wget                                         # Utility for non-interactive download of files from the Web
ldconfig                                     # Creates links and cache to shared libraries found in /etc/ld.so.conf, /lib, and /usr/lib
ldconfig -p                                  # Lists of directories and candidate libraries stored in the current cache
ldd /bin/ls                                  # Prints the shared libraries required by the program
ps                                           # Snapshot of the current processes
ps -A                                        # Select all processes
ps -e                                        # Identical to -A
ps aux                                       # See every process on the system using standard syntax
top                                          # Dynamic real-time view of processes running on the system.
kill                                         # Send a signal to a process. Default  signal for kill is TERM
kill -SIGINT 78929
kill -SIGKILL 78929
pkill ping                                   # Send a signal to list of process matching a pattern
killall ping                                 # Kill processes by name
nice -12 large-job                           # Run a program with modified scheduling priority
renice -5 -p 1575                            # Alter priority of running processes
nohup <> &                                   # Run a command immune to hangups, with output to a non-tty. & runs in background
bg                                           # Make suspended command to execute in background
jobs                                         # List background jobs
fg                                           # Bring most recent job to the foreground
fg %1                                        # Bring a certain job to the foreground
kill %2                                      # Kill background job
tail -n 5 /var/log/syslog                    # Output the last 5 lines of file
tail -f /var/log/syslog                      # Output the last 10 lines of file and continue to display new events
grep                                         # Print lines matching a pattern
grep -E                                      # grep with --extended-regexp
egrep                                        # Same as grep -E
grep -F                                      # grep with --fixed-strings
fgrep                                        # Same as grep -F
rsync                                        # Remote (and local) file-copying tool
echo                                         # Display a line of text
echo -e                                      # echo + enable interpretation of backslash escapes
./                                           # Execute the content of the file passed as argument, in the current shell
source                                       # Execute the content of the file passed as argument, in the current shell
.                                            # Execute the content of the file passed as argument, in the current shell
chmod                                        # Change permissions for file or folder
chmod +x script.sh                           # Everyone gets execute permissions
chmod -R 754 myfiledir                       # Change permissions of folders and files recursively
chown -R daniel:group myfiledir              # Change user ownership of folders and files recursively
chgrp -R group myfiledir                     # Change group ownership of folders and files recursively
useradd                                      # Create a locked new user
useradd -u 1000 -g 500 daniel -G group dans  # Create a locked new user in a group
userdel --force --remove daniel              # Delete a user
usermod                                      # Modify a user account
usermod -L david                             # Lock a user's password
passwd                                       # Change a user's password
pwconv                                       # Convert and update user's passwords from passwd to shadow
grpconv                                      # Convert and update groups' passwords from passwd to shadow
groupadd                                     # Create a new group
groupdel                                     # Delete a group
groupmod                                     # Modify a group
gpasswd                                      # Modify a group's password
chage --list daniel                          # Show account aging information
chage -d 0 daniel                            # Force immediate password expiration
chage -E "2009-05-31" daniel                 # Set user password expiry information
umask                                        # Display umask - file permission mask for newly created files
umask -S                                     # Display umask in text
getent hosts                                 # Get entries from Name Service Switch libraries Databases
su = su root                                 # Change user ID or become superuser - overtake session
su daniel                                    # Change user ID or become superuser - overtake session
su - = su - root                             # Change user ID or become superuser - new session
su - daniel                                  # Change user ID or become superuser - new session
sudo su                                      # Using sudo to invoke su, so to use the sudo password
last                                         # Show a listing of last logged in users
wall                                         # Write a message to all users
visudo                                       # Edit the sudoers file
ulimit -a                                    # Show and change all system limits
ulimit -u                                    # Show and change system limits for max user processes
set                                          # Set or unset values of shell options and positional parameters
set -o noclobber                             # Prevent > from overwrite file
set -x                                       # Print commands and their arguments as they are executed
set +x                                       # Disable printing commands and their arguments as they are executed
cat                                          # Concatenate files and print on the standard output
cat -vet                                     # Convert tabs to spaces
expand                                       # Convert tabs to spaces
unexpand                                     # Convert spaces to tabs
wc                                           # Print newline, word, and byte counts for each file
fmt                                          # Reformat each paragraph in the file writing to standard output
pr                                           # Convert text files for printing
join                                         # Join lines of two files on a common field
paste                                        # Write lines from each file side by side, separated by TABs, to standard output
nl                                           # Number lines of files
>                                            # Redirects output to a file, overwriting the file
>>                                           # Redirects output to a file appending the redirected output at the end
<                                            # Feeds file (right) to command (left). sort < /etc/passwd
<<                                           # Feeds file from input until stop character (right) to command (left). sort << END
2>                                           # Redirects standard error to file
&>                                           # Redirects standard output and standard error to file
ls /tmp/hello > error.log 2>&1               # Redirects the standard error to the standard output, and both to file
2>&1                                         # Redirects the standard error to the standard output
logger                                       # Enter messages into the system log
tee                                          # Read from standard input and write to standard output and files
sort                                         # Sort lines of text files
sort -k 3                                    # Sort lines of text files by field
sort << END                                  # Sort lines of input string until keyword appears
tr -s ' ' < file.txt                         # Translate or delete characters. Squeeze repeats
tr -d 'to_remove' < file.txt                 # Delete character in set wherever found
sed -e s/Nick/John file.txt                  # Edit -replace as script input
sed 's/Nick/John/g' file.txt
cut -c3 names                                # Cut character vertically
cut -c3-10 names                             # Cut range of characters vertically
cut -d: -f1-2 names                          # Use delimited to separate into fields, and select specified fields
cut -f 1 -d " " names
cut -f 2 -d " " names
cut -f 2 -d " " names | paste names -
cut -f 2 -d " " names | paste names - | sort -k 3 | cut -f 1
uniq                                         # Report or omit repeated lines
split file.txt header_text_for_files         # Split a file into pieces
iconv -f utf-8 -t ISO_8895-15 < file1.txt > file2.txt # Convert text from one character encoding to another
xargs                                        # Build and execute command lines from standard input
ls name* | xargs paste
pwd                                          # Print name of current/working directory
ls                                           # List directory contents
ls -i                                        # + include inodes
ls -lrt                                      # + include reverse, long format, time ordering (modification)
la                                           # + include hidden . files
alias ls="ls -al"                            # Create an alias for a compound command
cd                                           # Change directory
mv                                           # Move (rename) files
cp                                           # Copy files and directories
rm                                           # Remove files or directories
scp                                          # Secure copy (remote file copy program)
scp -i                                       # + include private key
tar -zcvf to.tar.gz files_to_compress        # Archiving utility.  -z : Compress.   -c : Create.  -v : Verbose. -f : File to Save.
tar -zxvf to.tar.gz files_to_compress        # Archiving utility.  -z : Decompress. -x : Extract. -v : Verbose. -f : File to Save.
tar -cvf to.tar files_to_compress            #
gzip to.tar >> to.tar.gz                     # Compress files
gzip -d to.tar.gz >> to.tar                  # Expand files. -d: decompress
find . -name "protocols"                     # Search for files in current directory by name
find ./ -name "protocols"                    # Search for files in current directory by name
find / -name "protocols"                     # Search for files in / directory by name
find / -inum 129698                          # Search for files in / directory by inode number
find /etc -type f -mtime +30                 # Search for files by type and mod time by day-hour
find /etc -type f -size +1M                  # + add greater than for size
find /usr -type f -size -1M                  # + add less than for size
find /usr -maxdepth 2 -type f -size +1M      # + look up to two directies deep
find /var/log -mmin -60                      # + last modified n minutes ago
locate                                       # Find files/databases by name. Built by updatedb
updatedb                                     # Update a database for mlocate, locate command
ln file1 file2                               # Make hard link between files
ln -s                                        # Make soft link between files
df                                           # Report file system disk space usage
df -h                                        # + human readable sizes
df -T                                        # + partition type
du                                           # Estimate file space usage
du -h                                        # + human readable sizes
lsblk                                        # Info on block devices. Reads the sysfs filesystem and udev db
lsblk -f                                     # + filesystems
fdisk /dev/sda                               # Create disk partition table - MBR
fdisk -l /dev/sda                            # List disk partition table - MBR
gdisk /dev/sda                               # Create GUID partition table (GPT)
gdisk -l /dev/sda                            # List GUID partition table (GPT)
parted                                       # Create GUID partition table (GPT)
mkfs /dev/sdb1                               # Build a Linux filesystem on a hard disk partition
mkfs -t ext3 /dev/sdb1                       # + filesystem type
mkfs.ext3 /dev/sdb1                          # + dot notation. Recommended way to call mkfs
mkfs.xfs -f /dev/sdb1                        # + force overwrite
mount /dev/sdb1 /mnt/Photos                  # Mount a filesystem to the file tree
umount /mnt/Photos                           # Unmount a filesystem
mkswap /dev/sdb2                             # Sets up a Linux swap area on a device or in a file
swapon /dev/sdb2                             # Enable/disable devices and files for paging and swapping
swapoff /dev/sdb2                            # Enable/disable devices and files for paging and swapping
fsck /dev/sda1                               # Check and repair a Linux filesystem
e2fsck /dev/sda1                             # Check and repair a Linux ext2/ext3/ext4 file system
dumpe2fs -h /dev/sda1                        # Dump ext2/ext3/ext4 filesystem information + only display the superblock info
tune2fs -l /dev/sda1                         # List the contents of the filesystem superblock
tune2fs -L Photos /dev/sda1                  # Set the volume label of the filesystem
tune2fs -c 10 /dev/sda1                      # Adjust the number of mounts after which the filesystem will be checked by e2fsck
fuser /tmp                                   # Identify processes using files or sockets
/etc/fstab                                   # To configure quotas, edit and add usrquota and grpquota to filesystem, reboot
quotacheck -avug                             # Initial quota check on filesystem. Create a aquota file for user and group
quota -u daniel testuser                     # Display disk usage and limits for user
quota -g group testuser                      # Display disk usage and limits for group
edquota -u daniel                            # Edit user quotas
edquota -g group                             # Edit group quotas
repquota /mnt/Photos                         # Display disc usage and quotas for a filesystem
quotaon /mnt/Photos                          # Enable filesystem quotas
quotaoff /mnt/Photos                         # Disable filesystem quotas
dd if=/dev/sda of=bootloader.bak bs=446 count=1 # Copy and convert file. if - input file, of = output file, bs - bytes
xxd bootloader.bak                           # Make a hexdump or do the reverse
od                                           # Dump files in octal and other formats
grub-probe --version                         # Probe device information for GRUB
grub-probe --target=fs /boot/grub            #
grub-probe --target=drive --device /dev/sda  #
grub-install /dev/sda                        # Install GRUB to a device
grub-mkconfig -o /boot/grub/grub.cfg         # Generate a GRUB configuration file
update-grub                                  # Same as: grub-mkconfig -o /boot/grub/grub.cfg
init 3                                       # Change systemd runlevel to 3
telinit 3                                    # Change SysV runlevel to 3
screen -ls                                   # List available screens
screen -r 1499.screen_name                   # Reattach to a particular screen id
screen                                       # Create a new screen session with a default id
screen -S screen_name                        # Create a new screen session - Press CTRL-A + d to detach
apt-get -y install xorg                      # Install X11 - X Server Window system
startx                                       # Initialize an X session
apt-get -y install openbox                   # Install Extensible Window Manager
startx                                       # Initialize an X session with a Window Manager
apt-get -y install lightdm gnome             # Install Display Managers
export DISPLAY=:1                            # Export displays for us to connect to
xterm                                        # Open another terminal
xwininfo                                     # Get info about my screen
xdpyinfo                                     # Get technical info about x server
xhost +                                      # Allow anyone to connect to server
xhost -                                      # Allow only authorised clients to connect to server
journalctl -b -1                             # Query the systemd journal - Show messages from a specific boot
journalctl --since "2 days ago"              # Show messages from 2 days ago
mutt                                         # Text based program for reading and sending email
mail -s "Hello World" someone@example.com
mail -s "This is the subject" somebody@example.com <<< 'This is the message'
mailq                                        # List the mail queue
newaliases                                   # Initialize the alias database
lpq                                          # Show printer queue status
lpc                                          # Cancel Printer Job
lpr                                          # Print file
cupsenable printer_name                      # Stop/start printers and classes
cupsdisable printer_name                     # Stop/start printers and classes
ssh-keygen                                   # Generates, manages and converts authentication keys for ssh
chmod 700 ~/.ssh/                            # Permissions best practices for ssh keys
chmod 644 ~/.ssh/id_rsa.pub                  # Permissions best practices for ssh keys
chmod 600 ~/.ssh/id_rsa                      # Permissions best practices for ssh keys
eval `ssh-agent`                             # ssh-agent is a background program that handles passwords for SSH private keys
ssh-add                                      # Prompts the user for a private key password and adds it to the list maintained by ssh-agent
touch file1.txt                              # Creates file
rngd -r /dev/urandom                         # Creates some entropy to be able to use gpg
gpg --gen-key                                # Generate a new key pair using the current default parameters
gpg --gen-revoke your_email@address.com      # Generate a revocation certificate for the complete key
gpg --keyserver pgp.mit.edu --search-keys params # Set a preferred keyserver for the specified user ID, search for key
gpg --list-keys                              # List all keys from the public keyrings
gpg --encrypt --recipient user file1.txt     # Encrypt data
la -la text1.txt.gpg
gpg --decrypt file1.txt.gpg > file1.txt      # Decrypt data
```


### Recommended Reading List

**Books:**

1. [How Linux Works What Every Superuser Should Know, Brian Ward, _2nd Edition, No Starch Press_.](https://www.amazon.com/How-Linux-Works-2nd-Superuser/dp/1593275676).
2. [Linux Command Line and Shell Scripting Bible, R. Blum and C. Bresnahan, _3rd Edition, Wiley_.](https://www.amazon.com/Command-Scripting-Christine-Bresnahan-2015-01-20/dp/B01JNWWSZA)
3. [Linux Bible, Christopher Negus, _9th Edition, Wiley_.](https://www.amazon.com/Linux-Bible-Christopher-Negus/dp/1119578884/)

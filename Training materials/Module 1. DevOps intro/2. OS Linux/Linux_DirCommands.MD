# Linux Directories Explained (Filesystem Hierarchy Overview)

This document provides a clear overview of essential Linux directories, their purpose, and what they contain.  
It follows the **FHS – Filesystem Hierarchy Standard**.

---

## **/** — Root Directory  
The top-level directory of the entire filesystem. Everything starts here.

---

## **/bin — Essential User Binaries**  
Contains basic commands needed for all users, even in single‑user mode.  
Examples: `ls`, `cp`, `mv`, `rm`, `cat`

---

## **/sbin — System Binaries**  
System administration tools, usually requiring root.  
Examples: `reboot`, `fdisk`, `iptables`

---

## **/boot — Boot Loader Files**  
Stores kernel, initramfs, GRUB, and related bootloader files.  
Without this directory, the OS cannot start.

---

## **/dev — Device Files**  
Special files representing hardware devices.  
Examples:  
- `/dev/sda` — hard drive  
- `/dev/tty` — terminal  
- `/dev/null`, `/dev/zero` — virtual devices

---

## **/etc — Configuration Files**  
System‑wide configuration files for services and applications.  
Examples:  
- `/etc/ssh/sshd_config`  
- `/etc/fstab`  
- `/etc/nginx/nginx.conf`

---

## **/home — User Home Directories**  
Personal files and settings for each user.  
Examples:  
- `/home/student`  
- `/home/admin`

(macOS equivalent: `/Users/<name>`)

---

## **/root — Root User Home Directory**  
Home directory of the **root** superuser.

---

## **/lib, /lib64 — System Libraries**  
Shared libraries required by programs in `/bin` and `/sbin`.  
Linux equivalent of Windows `.dll` files.

---

## **/media — Removable Media Mount Points**  
Automatically used for:  
- USB drives  
- DVDs  
- SD cards

Example: `/media/user/USB_DRIVE`

---

## **/mnt — Temporary Mount Point**  
Used manually by admins for mounting filesystems during maintenance or recovery.

---

## **/opt — Optional Application Software**  
Third‑party or optional software packages not included in the base system.  
Example: `/opt/google/chrome`

---

## **/proc — Virtual Kernel & Process Information**  
Dynamic filesystem containing kernel and process information.  
Important files:  
- `/proc/cpuinfo`  
- `/proc/meminfo`  
- `/proc/<PID>` — per‑process info

---

## **/run — Runtime Data**  
Temporary runtime files created after boot:  
- PID files  
- sockets  
- runtime states  

Cleared on reboot.

---

## **/srv — Service Data**  
Data served by system services (e.g., web, FTP).  
Example: `/srv/www`

---

## **/sys — Kernel & Device Information**  
Virtual filesystem used by the kernel and udev for device management.

---

## **/tmp — Temporary Files**  
Used for temporary storage by applications.  
Often cleared upon reboot.

---

## **/usr — User Applications & Utilities**  
Contains the majority of user‑level software and libraries.

### **/usr/bin**  
Most user commands (`python`, `git`, etc.)

### **/usr/sbin**  
Non‑essential system admin tools.

### **/usr/lib**  
Libraries for programs under `/usr/bin` and `/usr/sbin`.

### **/usr/local**  
Locally compiled or manually installed software.

---

## **/var — Variable Data**  
Data that changes frequently:  
- logs  
- caches  
- mail  
- databases  

### **/var/log**  
Contains all system logs:  
- `syslog`  
- `auth.log`  
- web server logs  
- application logs

---

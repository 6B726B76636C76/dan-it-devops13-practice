# Linux Command Essentials — Cross-Platform Guide (Ubuntu, CentOS, macOS)

This document contains the essential Linux/UNIX commands that work the same or nearly the same across:
- **Ubuntu / Debian**
- **CentOS / RHEL**
- **macOS (Unix-based)**

It also includes system-level commands and official documentation links.

---

## 📘 Official Linux Command References

### **Primary official manual pages (man-pages)**
- https://man7.org/linux/man-pages/

### **GNU Coreutils (official)**
- https://www.gnu.org/software/coreutils/manual/

### **POSIX Commands Standard**
- https://pubs.opengroup.org/onlinepubs/9699919799/

---

# 1. Navigation Commands

### `pwd`
Show the current working directory.

### `ls`
List files and directories.  
Common flags:
- `ls -l` – long format  
- `ls -a` – include hidden files  
- `ls -lh` – human-readable sizes  

### `cd`
Change directory.
- `cd ..` – go up one level  
- `cd` – go to home directory  

---

# 2. File & Directory Operations

### `touch <file>`
Create an empty file or update its timestamp.

### `mkdir <directory>`
Create a directory.  
- `mkdir -p path/to/dir` – create nested directories

### `cp <source> <destination>`
Copy files.
- `cp -r dir1 dir2` – copy a directory recursively

### `mv <source> <destination>`
Move or rename files or directories.

### `rm <file>`
Remove files.  
⚠️ Be careful with:
- `rm -r dir` – remove directory  
- `rm -rf /` – **never run**, destructive

---

# 3. Viewing File Contents

### `cat <file>`
Print entire file.

### `less <file>`
Scroll through file (press `q` to quit).

### `head <file>`
Show first lines (default: 10).

### `tail <file>`
Show last lines.  
- `tail -f file` – follow file in real time

---

# 4. Searching & Filtering

### `grep "pattern" <file>`
Search for text inside files.  
- `grep -r "text" .` – recursive search  
- `grep -i` – ignore case  

### `find <path> -name "*.log"`
Find files by name, type, size, etc.

---

# 5. System Information

### `whoami`
Show current user.

### `uname -a`
Display system and kernel information.

### `df -h`
Disk usage overview.

### `du -sh <dir>`
Size of a directory.

### `free -h` (Linux only)
Show memory usage.

### `top` / `htop`
Real-time process monitor.

### `ps aux`
List all running processes.

---

# 6. Networking Commands

### `ping <host>`
Check connectivity.

### `curl <url>`
Make HTTP requests from CLI.

### `ssh user@host`
Connect to remote server via SSH.

### `scp <file> user@host:/path`
Copy files over SSH.

### `ifconfig` / `ip addr`
View network interfaces.

---

# 7. Archiving & Compression

### `tar`
- `tar -czvf archive.tar.gz dir/` – create  
- `tar -xzvf archive.tar.gz` – extract

### `zip` / `unzip`
Work with ZIP archives.

---

# 8. Permissions & Ownership

### `chmod`
Change permissions.  
Examples:
- `chmod 755 file`
- `chmod u+x script.sh`

### `chown user:group file`
Change file owner.

---

# 9. Package Managers Overview

### Ubuntu / Debian
```
sudo apt update
sudo apt install <package>
sudo apt remove <package>
```

### CentOS / RHEL
```
sudo dnf install <package>
sudo yum install <package>
```

### macOS (Homebrew)
```
brew install <package>
brew update
brew remove <package>
```

---

# 10. Useful Shell Shortcuts

| Shortcut | Action |
|---------|--------|
| `Ctrl + C` | Stop running command |
| `Ctrl + D` | Exit shell |
| `Ctrl + L` | Clear screen |
| `Ctrl + R` | Search command history |

---

# 📚 Additional Recommended Links

### Linux Command for beginers
https://ubuntu.com/tutorials/command-line-for-beginners#4-creating-folders-and-files

### Linux Survival Guide
https://linuxsurvival.com/

### Linux Online Terminal
https://www.terminaltemple.com/

### Linux File System Hierarchy Standard
https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html

---

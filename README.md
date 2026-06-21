# lifebook-lid-workaround
Fujitsu FMV Lifebook Lid open/close problem workaround.

# Details
Certain Fujitsu FMV Lifebook have problem of the lid open close detection when Linux is running. 

This problem is found in :
- Fedora 43
- Fedora 44
- Ubuntu 26.04 LTS

This problem is observed on:
- Lifebook U9311
- Lifebook U9312

This problem is depending on the minor version of the distribution. Newer version may not have this problem. 
# Applying Workaround
To install the workaround, run the following script. 

```sh
./lifebook-lid-workaround.sh
```
This script register `lid-monitor.service` to watch the lid state and put system into suspend when the lid is closed. 

# Testing Status
To test the status of the service, run the following command. 
```sh
sudo systemctl status lid-monitor.service
```
If the service is working well, it is enabled and active. 

```
● lid-monitor.service - Monitor ACPI Lid State and Suspend
     Loaded: loaded (/etc/systemd/system/lid-monitor.service; enabled; preset: enabled)
     Active: active (running) since Sun 2026-06-21 12:57:22 JST; 3min 0s ago
 Invocation: 40f73525f1c0471c80eae8dc67549fb9
   Main PID: 5854 (lid-monitor.sh)
      Tasks: 2 (limit: 8918)
     Memory: 2.4M (peak: 3.3M)
        CPU: 1.376s
     CGroup: /system.slice/lid-monitor.service
             ├─5854 /bin/bash /usr/local/bin/lid-monitor.sh
             └─6697 sleep 1

 6月 21 12:57:22 kubuntu-fmvu3403ap systemd[1]: Started lid-monitor.service - Monitor ACPI Lid State and Suspend.

```

# Stopping service
To stop the service, run the following command:
```sh
sudo systemctl stop --now lid-monitor.service
```
To stop the service, run the following commands:

```sh
sudo systemctl stop --now lid-monitor.service
sudo systemctl disable lid-monitor.service
```
To start the service again, run the following commands:
```sh
sudo systemctl enable lid-monitor.service
sudo systemctl start --now lid-monitor.service
```


# Configuration
By default, the lid-monitor.service puts the system into suspend when the lid is closed. 

If you want to put the system into the hibernate or suspend-then-hibernate, edit the top of the `lifebook-lid-workaround.sh` script. Uncomment the line to choose the desired state : 
```sh
SUSPEND_MODE=suspend
#SUSPEND_MODE=suspend-then-hibernate
#SUSPEND_MODE=hibernate
```
And then, run the following script and command:
```sh
./lifebook-lid-workaround.sh
sudo systemctl restart lid-monitor.service
```

# License
This project is destributed under the [MIT License](LICENSE). 
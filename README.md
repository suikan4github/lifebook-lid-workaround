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

# Testing Status

```sh
sudo systemctl status lid-monitor.service
```
# License
This project is destributed under the [MIT License](LICENSE). 
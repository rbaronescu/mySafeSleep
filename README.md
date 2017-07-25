# mySafeSleep
SafeSleep implementation for Hackintosh 10.10 - 10.12

Use [Power Manager](https://www.dssw.co.uk/powermanager/) to schedule these scripts at sleep, wake and critical battery level(optional).

To use this:
1. Create a new directory called "Projects" in your HOME and clone this repo there.
2. Create a direcotry named "bin" in your HOME, and add this line to your bash_profile:

```
echo "export PATH=$PATH:~/bin" >> ~/.bash_profile
```

3. Copy pmset_10.10 and pmset_10.12 to `~/bin`.
4. Modify sudoers file, such that `sudo pmset_10.10` and `sudo pmset_10.12` can be executed without asking the password:

```
username ALL = (root) NOPASSWD: /Users/"your username"/bin/pmset_10.10
username ALL = (root) NOPASSWD: /Users/"your username"/bin/pmset_10.12
```

## Notes
In case you're on Mac OS X 10.11 or 10.10 you have to substitute pmset_10.12 with pmset in your `/usr/bin/`.

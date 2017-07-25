# mySafeSleep
SafeSleep implementation for Hackintosh 10.10 - 10.12

Use [Power Manager](https://www.dssw.co.uk/powermanager/) to schedule these scripts at sleep, wake and critical battery level (optional).

To use this:
1. Clone this repo in your HOME directory.
2. Create a direcotry named `bin` in your HOME, and execute this command:

```
echo "export PATH=$PATH:~/bin" >> ~/.bash_profile
```

3. Copy pmset_10.10 and pmset_10.12 to `~/bin`.
4. Modify sudoers file, such that `sudo pmset_10.10` and `sudo pmset_10.12` can be executed without asking the password (replace username):

```
username ALL = (root) NOPASSWD: /Users/"your username"/bin/pmset_10.10
username ALL = (root) NOPASSWD: /Users/"your username"/bin/pmset_10.12
```

## Notes

### Earlier version of macOS (Mac OS X)
In case you're on Mac OS X 10.11 or 10.10 you have to substitute pmset_10.12 with pmset in your `/usr/bin/`.

### How to use [Power Manager](https://www.dssw.co.uk/powermanager/)
To add a Before Sleep event, click '+' and select 'Run a script before computer sleeps', leave the script empty, and go till the end of the configuration. Now hold ALT or CMD and double click the event, you can select run an applescript here and copy the before_sleep script.

To add a On Wake event, add a new empty event. After that hold ALT or CMD and double click event, you can set it to run an applescript as before, and on trigger you will have to choose 'When computer powers on'.

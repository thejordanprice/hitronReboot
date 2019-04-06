# hitronReboot

A bash script to reboot certain Hitron modems regularly that become unstable over time using the terminal.

### Intro

My ISP has been giving me upstream issues for a long time. They have been out to fix the issue many times and it was still not resolved. The last time they serviced the equipment and connections at my house, they installed a new modem. The Hitron CODA-4589. With the specs it provides it defintely works as a good modem but with my issue after coninuous usage (1-2 days), it eventually loses telephone connectivity. Then we need to go reboot the modem, after that everything goes smooth again. This is to set and forget an automated reboot schedule as a [cronjob](https://help.ubuntu.com/community/CronHowto) for uninteruppted service. After being aggravted for a long time; this seems to be the only solution.

![term](https://i.imgur.com/xusvjvp.png)
*Screenshot*

### Getting Started

You need a linux flavor with jq and curl installed. Edit the scripts options (username, password, address) inside the file with an editor of your choosing. Execute the script and the modem should reboot.

```
apt update && apt upgrade 
apt install jq curl
git clone https://github.com/thejordanprice/hitronReboot
cd hitronReboot
nano rebootHitron.sh
./rebootHitron.sh
```

### License

MIT
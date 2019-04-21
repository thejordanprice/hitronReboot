# hitronReboot
A bash script to reboot certain Hitron CODA (particularly the 4000 series) modems regularly that become unstable over time using the terminal. 
### Intro
My ISP has been giving me upstream issues for a long time. They have been out to fix the issue many times and it was still not resolved. The last time they serviced the equipment and connections at my house, they installed a new modem. With the specs it provides it defintely works as a good modem but with my issue after coninuous usage (1-2 days), it eventually loses telephone connectivity. Then we need to go reboot the modem, after that everything goes smooth again.
This is to set and forget an automated reboot schedule as a [cronjob](https://help.ubuntu.com/community/CronHowto) for uninteruppted service. After being aggravated for a long time; this seems to be the only solution.
![term](https://i.imgur.com/xusvjvp.png)
*Screenshot*
### Options
You must set the usename, password, and modem ip via setting a few global environment variables. This is really meant to be used for a docker deployment but there is nothing wrong with going old fashioned.
###### Environment Variables
```
MODEM_ADDY=192.168.100.1
MODEM_USER=cusadmin
MODEM_PASS=changeme
```
### Getting Started
You need a linux flavor with jq and curl installed. Set the options (username, password, address) with the correct info as environment variables. Execute the script and the modem should reboot.
```
apt update && apt upgrade 
apt install jq curl
git clone https://github.com/thejordanprice/hitronReboot
cd hitronReboot
nano rebootHitron.sh
./rebootHitron.sh
```
### To-Do
[ ] Working environment variables from docker.
[ ] That should be about it.

### License

MIT
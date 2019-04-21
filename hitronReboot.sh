#!/bin/bash

# Title: hitronReboot.sh
# Dependencies: jq, curl, cut, grep, head
# Description: Bash script to reboot certain hitron modems regularly that become unstable over time.
# Software: 2.0.10.39-SIP
# Hardware: CODA-4589 (1A)

# Possible global variable from docker. If not, load defaults.
if [ -f "/root/env.sh" ] ; then
    source "/root/env.sh";
fi

if [ "$MODEM_PASS" != "" ] ; then
    modem_ip="$MODEM_ADDY";
    username="$MODEM_USER";
    password="$MODEM_PASS";
fi

# Login with credentials, then find userid for cookie in next step.
login_ret=$(curl -i -s -d "user=$username" -d "pwd=$password" http://$modem_ip/goform/login | grep "userid=" | cut -f2 -d=|cut -f1 -d";");

if [ -n "$login_ret" ] ; then
    echo "Logged in. userid: $login_ret";

    # jq is a json parser, it is required to parse the json response containing the csrf token.
    csrf_ret=$(curl -i -s -H "Cookie: userid=$login_ret;" http://$modem_ip/data/getCsrfToken.asp | tail -n 3 | jq -r ".token");
    echo "Token harvested. csrf_token:" $csrf_ret;

    # Send the reboot command with required cookie and csrf token.
    reboot_ret=$(curl -i -s -H "Cookie: userid=$login_ret;" --data "model=%7B%22reboot%22%3A%221%22%7D&csrf_token=$csrf_ret" http://$modem_ip/goform/Reboot | head -1);

    # If the response from the reboot command is 200, everything is good.
    if [ "$reboot_ret" == "HTTP/1.1 200 OK" ] ; then
        echo "Reboot success.";
        # Exit with true.
        exit 1;
    else
        # Error on anything that isn't a 200.
        echo "Reboot failed: $reboot_ret";
    fi
else
    # Login error.
    echo "Failed to login.";
fi

# Exit with false.
exit 0;

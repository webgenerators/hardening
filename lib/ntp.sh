#!/bin/bash

CONFIG_FILE_NTP=/etc/systemd/timesyncd.conf

ntp::name()
{
    echo "NTP"
}

ntp::description()
{
    echo "Network Time Protocol hardening"
}

ntp::help()
{
    echo "check"
    echo "enable"
    echo "disable"
}

ntp::check()
{
    local ntpEnabled=$(timedatectl status | grep -o "NTP enabled.*$" | awk '{print $3}')
    local ntpSynchron=$(timedatectl status | grep -o "NTP synchronized.*$" | awk '{print $3}')

    local isNtpEnabled=$(checkAnswer "$ntpEnabled")
    local isNtpSynchron=$(checkAnswer "$ntpSynchron")

    if [ "$isNtpEnabled" == "1" ];
    then
        echoOK "NTP enabled" $ntpEnabled
    else
        echoNO "NTP enabled" $ntpEnabled
    fi

    if [ "$isNtpSynchron" == "1" ];
    then
        echoOK "NTP synchronized" $ntpSynchron
    else
        echoNO "NTP synchronized" $ntpSynchron
    fi
}

ntp::enable()
{
    ntp::check
}

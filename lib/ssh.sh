#!/bin/bash

CONFIG_FILE_SSH=/etc/ssh/sshd_config

ssh::name()
{
    echo "SSH"
}

ssh::description()
{
    echo "Secure Shell hardening"
}

ssh::help()
{
    echo "check"
    echo "enable"
    echo "disable"
}

ssh::check()
{
#    countStart

#    countOk=0
#    countNo=0
#    countSum=0

    # Port check
    checkNotVerbose "Port" "22" $CONFIG_FILE_SSH
    checkVerbose "Protocol" "2" $CONFIG_FILE_SSH
    checkVerbose "PermitRootLogin" "no" $CONFIG_FILE_SSH
    checkVerbose "PasswordAuthentication" "no" $CONFIG_FILE_SSH
    checkNotVerbose "AllowUsers" "" $CONFIG_FILE_SSH
    checkVerbose "X11Forwarding" "no" $CONFIG_FILE_SSH

#    countStop
#    countOk
#    countNo
#    countSum

#        countOk=$((countOk+1))
#    countSum=$((countOk+countNo))

#    echo "Hardened index: $countOk/$countSum"
}

ssh::enable()
{
    setValue "Port" "22222" $CONFIG_FILE_SSH
    setValue "PermitRootLogin" "no" $CONFIG_FILE_SSH
    setValue "PasswordAuthentication" "no" $CONFIG_FILE_SSH
    setValue "X11Forwarding" "no" $CONFIG_FILE_SSH

    echo $(service ssh restart)

    ssh::check
}



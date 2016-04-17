#!/bin/bash

MEMORYKB=$(cat /proc/meminfo | grep MemTotal | awk '{ print $2 }')
MEMORYMB=$(( ${MEMORYKB%% *} / 1024))
MEMORYGB=$(( ${MEMORYMB%% *} / 1024))
SWAPKB=$(cat /proc/meminfo | grep SwapTotal | awk '{ print $2 }')
SWAPMB=$(( ${SWAPKB%% *} / 1024))

if [ -z "$MEMORYKB" ]; then
    MEMORYKB=0
    MEMORYMB=0
fi

if [ -z "SWAPMB" ]; then
    SWAPKB=0
    SWAPMB=0
fi

swap::name() {
    echo "SWAP"
}

swap::description() {
    echo "SWAP partition manager"
}

swap::help()
{
    echo "check"
    echo "enable"
    echo "disable"
}

swap::check()
{
    echo "Memory size: $MEMORYKB KiB ($MEMORYMB MiB / $MEMORYGB GiB)"
    echo "Swap size:   $SWAPKB KiB ($SWAPMB MiB)"
}

swap::enable()
{
    SWAPDEF=0
    SWAPHIB=0
    SWAPMAX=0

    # https://help.ubuntu.com/community/SwapFaq
    case 1 in
        $(( $MEMORYMB <= 256  )))
            SWAPDEF=256
            SWAPHIB=512
            SWAPMAX=512
        ;;
        $(( $MEMORYMB <= 512  )))
            SWAPDEF=512
            SWAPHIB=1024
            SWAPMAX=1024
        ;;
        $(( $MEMORYMB <= 1024 )))
            SWAPDEF=1024
            SWAPHIB=2048
            SWAPMAX=2048
        ;;
        $(( $MEMORYMB <= 2048 )))
            SWAPDEF=1024
            SWAPHIB=3072
            SWAPMAX=4096
        ;;
        $(( $MEMORYMB <= 3072 )))
            SWAPDEF=2048
            SWAPHIB=5120
            SWAPMAX=6144
        ;;
        $(( $MEMORYMB <= 4096 )))
            SWAPDEF=2048
            SWAPHIB=6144
            SWAPMAX=8192
        ;;
        $(( $MEMORYMB <= 5120 )))
            SWAPDEF=2048
            SWAPHIB=7168
            SWAPMAX=10240
        ;;
        $(( $MEMORYMB <= 6144 )))
            SWAPDEF=2048
            SWAPHIB=8192
            SWAPMAX=12288
        ;;
        $(( $MEMORYMB <= 8192 )))
            SWAPDEF=3072
            SWAPHIB=11264
            SWAPMAX=16384
        ;;
        $(( $MEMORYMB <= 12288 )))
            SWAPDEF=3072
            SWAPHIB=15360
            SWAPMAX=24576
        ;;
        $(( $MEMORYMB <= 16384 )))
            SWAPDEF=4096
            SWAPHIB=20480
            SWAPMAX=32768
        ;;
        $(( $MEMORYMB <= 24576 )))
            SWAPDEF=5120
            SWAPHIB=29696
            SWAPMAX=49152
        ;;
        $(( $MEMORYMB <= 32768 )))
            SWAPDEF=6144
            SWAPHIB=38912
            SWAPMAX=65536
        ;;
        $(( $MEMORYMB <= 65536 )))
            SWAPDEF=8192
            SWAPHIB=72728
            SWAPMAX=131072
        ;;
        $(( $MEMORYMB <= 131072 )))
            SWAPDEF=11264
            SWAPHIB=142336
            SWAPMAX=262144
        ;;
    esac;

    echo "Usage:"
    echo "swap enable def - $SWAPDEF MiB (default)"
    echo "swap enable hib - $SWAPHIB MiB (with hibernation)"
    echo "swap enable max - $SWAPMAX MiB (maximum)"
}

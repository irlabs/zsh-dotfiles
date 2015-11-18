# clear screen on console

# test for vc (linux) 
if [[ $(uname -s) = linux ]]; then
        case "`tty`" in
        /dev/vc/[0-9]) clear
    esac
fi

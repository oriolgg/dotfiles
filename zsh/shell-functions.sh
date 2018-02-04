#!/bin/sh

function ssh_aws {
    session=$1
    environment=$2

    vpn_disconnect_all
    vpn_connect "$1vpn"

    instances=$(aws ec2 describe-instances --profile $session --region eu-west-1 --filter "Name=key-name,Values=$session-$environment" "Name=instance-state-name,Values=running")

    instanceLineNumbers=($((grep -n "\"Instances\"" | cut -d : -f 1) <<< "$instances"))

    total=${#instanceLineNumbers[*]}
    insideTmux=0
    if [ "$TERM" = "screen-256color" ]; then
        insideTmux=1
    fi
    if [ $total -eq 0 ]; then
        echo "There is no instance with the key name $session-$environment running"
    else
        if [ $insideTmux -ne 1 ]; then
            tmux start-server
            tmux new-session -s "ssh-$session-$environment" -n "ssh-$session-$environment" -d
        fi
    fi

    if [ "${instanceLineNumbers[0]}" = "" ]; then
        init=1
    else
        init=0
    fi
    total2=$((total+init))
    for (( i=$init; i<$total2; i++ )) do 
        if [ "${instanceLineNumbers[($i + 1)]}" = "" ]; then
            currentInstance=s$(echo "$instances" | awk 'NR >= '${instanceLineNumbers[$i]})
        else
            currentInstance=s$(echo "$instances" | awk 'NR >= '${instanceLineNumbers[$i]}' && NR <= '${instanceLineNumbers[($i + 1)]})
        fi

        privateIpAddress=$((grep "\"PrivateIpAddress\"" | head -1) <<< "$currentInstance")
        privateIpAddress="$(grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' <<< "$privateIpAddress")"

        instanceType=$((grep "\"InstanceType\"" | sed 's: ::g' | sed 's/,$//' | uniq | head -1 | cut -d ':' -f 2 | sed -e 's/^"//' -e 's/"$//') <<< "$currentInstance")

        imageId=$((grep "\"ImageId\"" | sed 's: ::g' | sed 's/,$//' | uniq | head -1 | cut -d ':' -f 2 | sed -e 's/^"//' -e 's/"$//') <<< "$currentInstance")

        environmentLineNumber=$((grep -n "\"environment\"" | cut -d : -f 1) <<< "$currentInstance")
        instanceEnvironment=$((head -n $((environmentLineNumber + 1)) | tail -n 1 | sed 's: ::g' | sed 's/,$//' | uniq | head -1 | cut -d ':' -f 2 | sed -e 's/^"//' -e 's/"$//') <<< "$currentInstance")

        if [ $(((i - init) % 2)) -eq 0 ]; then
            if [ $insideTmux -eq 1 ] || [ $i -ne $init ]; then
                tmux new-window -n "ssh-$session-$environment"
            fi
        else
            tmux splitw -h
        fi

        tmux send-keys "echo '\n\n\n########################################\nimageId:          $imageId\nenvironment:      $instanceEnvironment\nprivateIpAddress: $privateIpAddress\ninstanceType:     $instanceType\n########################################\n\n\n' ; ssh -i ~/.keys/$session-web-$instanceEnvironment.pem ubuntu@$privateIpAddress" C-m
    done
    if [ $insideTmux -ne 1 ]; then
        tmux attach-session -t "ssh-$session-$environment"
    fi
}

function vpn_connect {
    /usr/bin/env osascript <<-EOF
tell application "System Events"
    tell current location of network preferences
        set VPN to service "$1"
        if exists VPN then connect VPN
        repeat while (current configuration of VPN is not connected)
            delay 1
        end repeat
    end tell
end tell
EOF
}

function vpn_disconnect {
    /usr/bin/env osascript <<-EOF
tell application "System Events"
    tell current location of network preferences
        set VPN to service "$1"
        if exists VPN then disconnect VPN
    end tell
end tell
return
EOF
}

function vpn_disconnect_all {
    /usr/bin/env osascript <<-EOF
set osversion to do shell script "sw_vers 2>/dev/null | awk '/ProductVersion/ { print $2 }' | cut -f 2 -d ."
set osversion to osversion as integer
if osversion is 13 then
	set vpntype to 13
else if osversion is less than 9 then
	set vpntype to 10
else
	set vpntype to 11
end if
tell application "System Events"
	tell current location of network preferences
		set names to get name of every service whose kind is vpntype and active is true
		repeat with name in names
			set myConnection to the service name
			if myConnection is not null then
				if current configuration of myConnection is connected then
					disconnect myConnection
				end if
			end if
		end repeat
	end tell
end tell
return
EOF
}

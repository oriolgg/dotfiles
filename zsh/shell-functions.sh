#!/bin/sh

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

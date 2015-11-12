on run session_name
    tell application "iTerm"
        activate

        repeat with myterm in terminals
            tell myterm
                repeat with mysession in sessions
                    tell mysession
                        set the_name to get name
                        if the_name contains session_name then
                            select myterm
                            select mysession
                            return
                        end if
                    end tell
                end repeat
            end tell
        end repeat
    end tell
end run

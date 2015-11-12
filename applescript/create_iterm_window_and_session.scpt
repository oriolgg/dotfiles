on run session_name

    tell application "iTerm"
        activate

        set myterm to (make new terminal)

        tell myterm     
            launch session "Default Session"
            tell the last session
                write text "ts " & session_name
            end tell
        end tell

    end tell
end run

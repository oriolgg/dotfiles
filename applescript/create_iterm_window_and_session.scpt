on run session_name

    set itExists to false
    set session_script to (path to home folder as text) & "scripts:start:" & session_name
    try
        session_script as alias
        set itExists to true
    end try
    set session_script to POSIX path of session_script

    tell application "iTerm"
        activate

        set myterm to (make new terminal)

        tell myterm     
            launch session "Default Session"
            tell the last session
                if itExists then
                    write text session_script
                else
                    write text "echo \"\\033];" & session_name & "\\007\""
                    write text "tmux new-session -s " & session_name
                end if
            end tell
        end tell

    end tell
end run

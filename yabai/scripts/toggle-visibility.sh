#!/usr/bin/osascript

tell application "$1"
   tell window 1
       if visible then 
           tell application "System Events" to set visible of the first process whose name is "$1" to false
       else 
           tell application "System Events" to set visible of the first process whose name is "$1" to true
       end if
   end tell
end tell

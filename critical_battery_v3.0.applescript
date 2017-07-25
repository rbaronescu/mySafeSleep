-- The path of the Project.
set project_path to "/Users/" & (do shell script "whoami") & "/Projects/mySafeSleep/"

-- Setting _hibernate to true for forced hibernate.
do shell script "echo true > " & project_path & "config_files/_hibernate.conf"

-- Going to hibernate.
tell application "Finder" to sleep
-- The path of the Project.
set project_path to "/Users/" & (do shell script "whoami") & "/Projects/mySafeSleep/"

-- LOG
do shell script "echo \"###############	ON WAKE #####################\" >> " & project_path & "my_safe_sleep.log"

-- Retrieving scheduled wakes.
set wake_schedules to do shell script "pmset -g sched"

-- Cancelling all scheduled wake. It doesn't matter if there were not.
do shell script "sudo " & project_path & "pmset schedule cancelall"

if wake_schedules is not "" then

	-- LOG
	do shell script "echo \"$(date) -- Found scheduled wake.\" >> " & project_path & "my_safe_sleep.log"

	-- User wake, so resetting _hibernate.conf
	do shell script "echo false > " & project_path & "config_files/_hibernate.conf"

	-- LOG
	do shell script "echo \"$(date) -- Changed _hibernate to false.\" >> " & project_path & "my_safe_sleep.log"

	-- LOG
	do shell script "echo \"$(date) -- Cancelled scheduled wake.\" >> " & project_path & "my_safe_sleep.log"

	-- Checking battery status. If too low, going to hibernate.
	set Cap to do shell script "pmset -g batt"

	tell Cap to set currentSource to fourth word of paragraph 1
	if currentSource is "AC" then
		return 0
	end if
	
	tell Cap to set currentCharge to third word of paragraph 2
	if currentCharge - 0 < 2 then
		do shell script "echo true > " & project_path & "config_files/_hibernate.conf"
		
		-- LOG
		do shell script "echo \"$(date) -- On user wake, detected critical low battery, going to hibernate.\" >> " & project_path & "my_safe_sleep.log"

		tell application "Finder" to sleep
	end if

else
	-- LOG
	do shell script "echo \"$(date) -- Found NO scheduled wake.\" >> " & project_path & "my_safe_sleep.log"
end if
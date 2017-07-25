-- The path of the Project.
set project_path to "/Users/" & (do shell script "whoami") & "/Projects/mySafeSleep/"


-- LOG, prepare new entries.
do shell script "echo \"###############	BEFORE SLEEP #################\" >> " & project_path & "my_safe_sleep.log"


-- First, delete all scheduled wakes.
do shell script "sudo " & project_path & "pmset_10.12 schedule cancelall"


-- Getting current hibernatemode.
set tmp_var to do shell script "pmset_10.12 -g | grep hibernatemode"
tell tmp_var to set hibernatemode to second word of paragraph 1
-- LOG
do shell script "echo \"$(date) -- Found hibernatemode on " & hibernatemode & ".\" >> " & project_path & "my_safe_sleep.log"


-- Check for _hibernate, if true, then hibernate.
set _hibernate to do shell script "cat " & project_path & "config_files/_hibernate.conf"
if _hibernate is "true" then
	
	-- Reset _hibernate.
	do shell script "echo false > " & project_path & "config_files/_hibernate.conf"
	
	if hibernatemode is not equal to "29" then
		do shell script "sudo " & project_path & "pmset_10.10 -a hibernatemode 29"
		-- LOG
		do shell script "echo \"$(date) -- Changed hibernatemode to 29, because of _hibernate.\" >> " & project_path & "my_safe_sleep.log"
	end if

	-- LOG
	do shell script "echo \"$(date) -- Going to hibernate.\" >> " & project_path & "my_safe_sleep.log"
	
	-- Exit
	return 0
end if


-- Getting current charge.
set Cap to do shell script "pmset_10.12 -g batt"
tell Cap to set chargeLeft to third word of paragraph 2
-- LOG
do shell script "echo \"$(date) -- Current charge is: " & chargeLeft & ".\" >> " & project_path & "my_safe_sleep.log"


-- If the battery is too low, I'll go directly to hibernate, instead of sleeping.
if chargeLeft - 0 < 8 then
	
	-- LOG
	do shell script "echo \"$(date) -- Charge is < 8.\" >> " & project_path & "my_safe_sleep.log"
	
	if hibernatemode is not equal to "29" then
		do shell script "sudo " & project_path & "pmset_10.10 -a hibernatemode 29"
		-- LOG
		do shell script "echo \"$(date) -- Changed hibernatemode to 29, battery too low.\" >> " & project_path & "my_safe_sleep.log"
	end if
	
	-- LOG
	do shell script "echo \"$(date) -- Going to hibernate.\" >> " & project_path & "my_safe_sleep.log"
	
else
	
	-- LOG
	do shell script "echo \"$(date) -- Charge is >= 8.\" >> " & project_path & "my_safe_sleep.log"
	
	
	if hibernatemode is not equal to "0" then
		do shell script "sudo " & project_path & "pmset_10.12 -a hibernatemode 0"
		-- LOG
		do shell script "echo \"$(date) -- Changed hibernatemode to 0.\" >> " & project_path & "my_safe_sleep.log"
	end if
	
	-- Scheduling next wake.
	set nextWakeTime to do shell script "date -v +3H \"+%m/%d/%Y% %H:%M:%S\""
	do shell script "sudo " & project_path & "pmset_10.12 schedule wake \"" & nextWakeTime & "\""
	-- LOG
	do shell script "echo \"$(date) -- Scheduled wake: " & nextWakeTime & ".\" >> " & project_path & "my_safe_sleep.log"
	
	
	-- Next time, just hibernate.
	do shell script "echo true > " & project_path & "config_files/_hibernate.conf"
	-- LOG
	do shell script "echo \"$(date) -- Changed _hibernate to true, going to sleep.\" >> " & project_path & "my_safe_sleep.log"
end if

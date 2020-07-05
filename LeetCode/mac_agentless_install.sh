#!/bin/sh

# command line args
BASE_DIR=$1
# using current dir this script will be called by installer/updater exe from its current dir so logs will be created at
# callers current dir
LOG_DIR="."
SHOULD_INSTALL=$2
UPDATE_CONF=$3

IS_RESTARTING=0

# log file with full path
LOG_FILE="$LOG_DIR"/AgentlessWrapperScript.log


# current directory of the script 
SCRIPT_DIR="$( dirname "$0" )"

# function to write log with timestamp in a file
write_log(){
date +"%F %T $*">>"$LOG_FILE"
}

#Copy agentless onguard files
copy_agentless_onguard_files()
{
# copy agentless onguard binary
cp "${SCRIPT_DIR}"/AgentlessOnGuard "$BASE_DIR"

if [ "$?" -ne "0" ];
then
    write_log "Could not copy agentless onguard app binary to $BASE_DIR. Error $?"
    exit rercode
fi

#copy opswat lib files
cp "${SCRIPT_DIR}"/*.dylib "$BASE_DIR"
cp "${SCRIPT_DIR}"/*.cfg "$BASE_DIR"

#copy log configuration file
cp "${SCRIPT_DIR}"/mac_onguard_log.xml "$BASE_DIR"


#copy library version file
cp "${SCRIPT_DIR}"/.agent-library-version.prop "$BASE_DIR"

#copy service plist file to /Library/LaunchDaemons
cp "${SCRIPT_DIR}"/com.arubanetworks.agentlessservice.plist /Library/LaunchDaemons

#copy agantless version file
cp "${SCRIPT_DIR}"/.agentless-version.prop "$BASE_DIR"

if [ "$?" -ne "0" ];
then
    write_log "Could not copy agentless onguard service plist file to /Library/LaunchDaemons. Error $?"
    exit rercode
fi

#Give permission to service plist file
chown root /Library/LaunchDaemons/com.arubanetworks.agentlessservice.plist
}


# function to stop the service
stop_service()
{
# check if service is running
is_service_running
if [ $? -eq 1 ]; then
write_log "Stopping the service"
launchctl unload /Library/LaunchDaemons/com.arubanetworks.agentlessservice.plist
fi
RET=$?
if [ $RET -ne 0 ]; then
write_log "Could not stop the service error $RET"
exit 1
fi
}

# function to remove agentless onguard files
remove_agentless_onguard_files()
{

# remove agentless onguard service binary from usr/bin
rm -f /Library/Application\ Support/AgentlessOnGuard/AgentlessOnGuard
RET=$?
if [ $RET -ne 0 ]; then
	write_log "Could not remove agentless onguard service binary from /Library/Application\ Support/AgentlessOnGuard/ error:$RET"
	exit 1
fi

write_log "Removed agentless onguard service binary from /Library/Application\ Support/AgentlessOnGuard/"

# remove daemon from /Lib
rm -f /Library/LaunchDaemons/com.arubanetworks.agentlessservice.plist
RET=$?
if [ $RET -ne 0 ]; then
	write_log "Could not remove agentless onguard daemon script file from /Library/LaunchDaemons/ error:$RET"
	exit 1
fi

write_log "Removed agentless onguard daemon script file from /Library/LaunchDaemons/"

# remove all the files from agentless onguard directory $BASE_DIR opswat library files , config files , agentless config files
rm -f BASE_DIR/*.dylib* BASE_DIR/*.cfg BASE_DIR/*.xml BASE_DIR/*.prop
RET=$?
if [ $RET -ne 0 ]; then
	write_log "Could not remove agentless onguard files from $BASE_DIR error:$RET"
	exit 1
fi

write_log "Removed agentless onguard files from $BASE_DIR"

}


# install Agentless OnGuard Service
install_service()
{
#stop_service ,  copy_files , copy service files, register service for auto launch on boot, start_service
stop_service
remove_agentless_onguard_files
copy_agentless_onguard_files
start_service
# wait few seconds before chacking the status
sleep 5
is_service_running
if [ $? -eq 0 ]; then
	write_log "retry start service with wait"
	wait_start_Service
else
	write_log "service started"	
fi
}

# function to start Agentless OnGuard Service
start_service()
{
write_log "start_Service called.."
# start the service
launchctl load /Library/LaunchDaemons/com.arubanetworks.agentlessservice.plist
RET=$?
if [ $RET -ne 0 ]; then
	write_log "Could not start the service error:$RET"
	return 1
fi
write_log "started the Service"
return 0
}

#Check if service is running
wait_start_Service()
{
# in case of service restart , service takes time to start after stop , seems stop is taking more time , as a workaround for now check if service is started if not retry
# every 30 seconds for few times
write_log "wait_start_Service called.."
RETRY_CNT=6
while [ $RETRY_CNT != 0 ]; do
	is_service_running
	if [ $? -eq 1 ]; then
		break;
	else
		write_log "wait before starting the service"
		sleep 30
		start_service
		if [ $? -eq 0 ]; then
			break;
		fi
	fi		
	RETRY_CNT=$((RETRY_CNT-1))
	write_log "retry starting the service"
done
}

is_service_running()
{
#check if service is running
launchctl list | grep com.arubanetworks.agentlessservice.plist
proc_count=$(launchctl list | grep com.arubanetworks.agentlessservice.plist | wc -l)
if [ $proc_count -ne 0 ]; then
	write_log  "Service is running"
	return 1
else
	write_log "Service is not running"
	return 0
fi
}

# function to update agent conf file and restarts the service to reflect the conf file changes  
update_agent_conf()
{
stop_service
start_service
# wait before cheking the status
sleep 5
is_service_running
if [ $? -eq 0 ]; then
	write_log "retry start service with wait"
	wait_start_Service
else
	write_log "service started"
fi

}

# check cmd line args
check_args()
{

 write_log "Agentless OnGuard Dir : $BASE_DIR"
 write_log "Wrapper Log Dir : $LOG_DIR"
 write_log "Should Install : $SHOULD_INSTALL"
 write_log "Should Update Config : $UPDATE_CONF"

 
 if [ "$SHOULD_INSTALL" -eq 0 -a "$UPDATE_CONF" -eq 0 ]; then
 write_log "No operation required exiting "
 exit 0
 fi

 
}

# script starts here
write_log "Number of parameters : $#"
if [ $# -lt 3 ]; then
	write_log "Invalid number of parameters . Exiting"
	exit 1
fi
check_args
if [ $SHOULD_INSTALL -eq  1 ]; then
	write_log "Installing service"
	install_service
	write_log "Finished installing service"
else
	if [ $UPDATE_CONF -eq 1 ]; then
		write_log "Updating agent configuration file"
		update_agent_conf
		write_log "Finished updating agent configuration file"
	fi
fi



#End of script
#-------------------------------

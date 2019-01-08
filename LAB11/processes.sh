#!/bin/bash


# FUNCTIONS

# Z11.0
proc () 
{
	required=1
	provided=$#

	if [ $required -ne $provided ]; then
		printf "Required arguments: $required  | Provided args: $provided \n"
		exit 1
	elif [ $1 -le 0 ]; then
		printf "Number must be greater than 0 \n"
		exit 1	
	fi

	printf "Process $1 starts at $(date) \n"
	sleep $(( ( RANDOM % 101 ) )) 
	printf "Process $1 finishes at $(date) \n"
	exit 0
}

# Z11.1
runner ()
{
	required=1
	provided=$#

	if [ $required -ne $provided ]; then
		printf "Required arguments: $required  | Provided args: $provided \n"
		exit 1
	elif [ $1 -le 0 ]; then
		printf "Number must be greater than 0 \n"
		exit 1	
	fi
	
	for i in `seq 1 $1`
	do
		proc $i &
		pids[${i}]=$!
	done
	
	# ---------------------------------------
	# Killer test
	killer $2 "${pids[@]}"
	# --------------------------------------

	# Wait for all processes to finish	
	for pid in ${pids[*]}
	do
		wait $pid
	done
	printf "Runner finished \n"
}
# Z11.2
killer () 
{
	required=2
	provided=$#
	if [ $provided -lt $required ]; then
		printf "Required arguments: $required  | Provided args: $provided \n"
		exit 1
	fi
	processes=( "$@" )
	
	printf "All processes ${processes[@]}\n"

	for process in ${processes[@]}
	do
		printf "Killing $process\n"
	#	pkill -u $1 $process 
	done
}

# MAIN

#proc $1
runner $1


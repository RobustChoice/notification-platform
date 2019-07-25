#!/bin/bash

# This shell script is an optional tool to simplify
# the installation and usage of laradock with docker-sync.

# Make sure that the DOCKER_SYNC_STRATEGY is set in the .env
# DOCKER_SYNC_STRATEGY=native_osx # osx
# DOCKER_SYNC_STRATEGY=unison # windows

# To run, make sure to add permissions to this file:
# chmod 755 sync.sh

# USAGE EXAMPLE:
# Install docker-sync: ./sync.sh install
# Start sync and services with nginx and mysql: ./sync.sh up nginx mysql
# Stop containers and sync: ./sync.sh down

# prints colored text
print_style () {

    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options:\n";
    print_style "   up" "success"; printf "\t\t\t Runs docker compose with mysql,nginx and phpmyadmin.\n"
    print_style "   up:dev [services]" "success"; printf "\t Runs docker compose with services that you need them.\n"
    print_style "   down" "success"; printf "\t\t\t Stops containers.\n"
    print_style "   bash" "success"; printf "\t\t\t Opens bash on the workspace.\n"
    print_style "   restart" "info"; printf "\t\t Restart containers.\n"
}

initializing_info(){
    print_style "May take a long time (20min+) on the first run\n" "info"
    print_style "Initializing Docker Compose\n" "info"
}

if [[ $# -eq 0 ]] ; then
    print_style "Missing arguments.\n" "danger"
    display_options
    exit 1
fi

if [ "$1" == "up:dev" ] ; then
   initializing_info
    
    shift # removing first argument
    
    docker-compose up -d ${@}

elif [ "$1" == "down" ]; then
    print_style "Stopping Docker Compose\n" "info"
    docker-compose stop

elif [ "$1" == "bash" ]; then
    docker-compose exec workspace bash

elif [ "$1" == "up" ]; then
  initializing_info
    
  docker-compose up -d mysql nginx phpmyadmin

elif [ "$1" == "restart" ]; then
    print_style "Restart Docker Compose\n" "info"
    docker-compose restart

else
    print_style "Invalid arguments.\n" "danger"
    display_options
    exit 1
fi
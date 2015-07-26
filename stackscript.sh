#!/bin/bash

# Oh look at the pretty colors!
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0m' # No Color

case "$1" in
        start)
                echo -e "\nStarting Openstack Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i openstack | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl status $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "inactive" ]; then
                                echo "Starting:" $i
                                systemctl start $i ;
                                echo -e "${green}Started:${NC}" $i
                        elif [ "$status" = "active" ]; then
                                echo -e "Service" $i  "${green} already running${NC}"
                        fi
                done
                echo -e "\nStarting Neutron Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i neutron | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl status $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "inactive" ]; then
                                echo "Starting:" $i
                                systemctl start $i ;
                                echo -e "${green}Started:${NC}" $i
                        elif [ "$status" = "active" ]; then
                                echo -e "Service" $i  "${green} already running${NC}"
                        fi
                done
                ;;
        stop)
                echo -e "\nStopping Openstack Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i openstack | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl stop $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "active" ]; then
                                echo "Stopping:" $i
                                systemctl stop $i ;
                        fi
                done
                echo -e "\nStopping Neutron Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i neutron | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl stop $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "active" ]; then
                                echo "Stopping:" $i
                                systemctl stop $i ;
                        fi
                done
                ;;
        restart)
                echo -e "\nRestarting Openstack Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i openstack | grep -i enabled | awk '{print $1}'`;
                        do
                                echo "Restarting:" $i
                                systemctl restart $i ;
                done
                echo -e "\nRestarting Neutron Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i neutron | grep -i enabled | awk '{print $1}'`;
                        do
                                echo "Restarting:" $i
                                systemctl restart $i ;
                done
                ;;
        status)
                echo -e "\nMain Openstack Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i openstack | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl status $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "active" ]; then
                                echo -e "${green}Active:${NC}" $i
                        elif [ "$status" = "inactive" ]; then
                                 echo -e "${red}Inactive:${NC}" $i
                        fi
                done
                echo -e "\nNeutron Services..\n"
                for i in `systemctl list-unit-files --type=service | grep -i neutron | grep -i enabled | awk '{print $1}'`;
                        do
                        status=$(systemctl status $i | awk 'FNR == 3 {print $2}' 2>&1)
                        if [ "$status" = "active" ]; then
                                echo -e "${green}Active:${NC}" $i
                        elif [ "$status" = "inactive" ]; then
                                echo -e "${red}Inactive:${NC}" $i
                fi
                done
                echo
                ;;

        *)
                echo "Usage: $0 start|stop|restart|status"
                exit 1
esac
exit 0


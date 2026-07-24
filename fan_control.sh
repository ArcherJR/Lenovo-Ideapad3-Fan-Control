#!/bin/bash

#                     Lenovo-Ideapad-Fan-Control                        #
#               by ArcherJR: https://github.com/ArcherJR                #
#                     Lenovo-Ideapad-Fan-Control                        #
#        https://github.com/ArcherJR/Lenovo-Ideapad3-Fan-Control        #
#                                                                       #
# Copyright (C) 2026 <ArcherJR>                                         #
# This program is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by  #
# the Free Software Foundation, either version 3 of the License, or     #
# (at your option) any later version.                                   #



# Fan mode path
FAN_MODE="/sys/bus/acpi/devices/VPC2004:00/physical_node/fan_mode"

# safe exit
cleanup() {
    echo -e "\nbye bye, fan setted to NORMAL mode (0) ..."
    echo 0 | sudo tee "$FAN_MODE" > /dev/null
    exit 0
}

# catch get out signals
trap cleanup SIGINT SIGTERM

echo "Fan Running..."
echo "To stop press 'Ctrl + C' "

while true; do
    # 1. Set Mode to FAST (1)
    echo 1 | sudo tee "$FAN_MODE" > /dev/null
    
    # max speed turn time
    sleep 8.965 #8.970
    
    # 3. Set Mode to NORMAL (0)
    echo 0 | sudo tee "$FAN_MODE" > /dev/null
    
    # waiting ec's seeing normal mode 
    sleep 0.05
done

#!/bin/bash

source config
echo $ntp_client_subnet
source ./prerequisit/ntp-controller.sh $ntp0 $ntp1 $ntp2 $ntp3 $ntp_client_subnet $subnet_mask

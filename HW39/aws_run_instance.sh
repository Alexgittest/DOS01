#!/bin/bash

aws ec2 run-instances --image-id ami-03d315ad33b9d49c4 --count 1 --instance-type t2.micro --key-name HW39 --security-group-ids sg-076329954bcf52d1a



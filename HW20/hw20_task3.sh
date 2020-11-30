#!/bin/bash

for var in *.c 
 do
  string_length=${#var}
  echo ${var:0:string_length-2}
done

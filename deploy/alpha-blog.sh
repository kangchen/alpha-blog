#!/bin/bash
# @echo off
echo "You started with $# parameters " $1
clear
date
ip="34.218.223.210"
echo
echo "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
echo "LLL ----- ALPHA-BLOG FULL DEPLOYMENT ----- LLL"
echo "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
echo

if [ $# = 0 ]; then
	scp -r -i ~/Documents/pem/ruby-on-rails.pem ../* ubuntu@$ip:/usr/share/nginx/html
else
	for d in "$@"
		do
			scp -i ~/Documents/pem/ruby-on-rails.pem $PWD/$d ubuntu@$ip:/usr/share/nginx/html
	done
fi

echo
echo "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
echo "LLL ------ DEPLOYMENT COMPLETED ------ LLL"
echo "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"
echo
date
echo

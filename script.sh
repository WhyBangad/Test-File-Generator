#!/bin/bash

echo "All directories named input/output will be overwritten. Do you want to proceed ?"
echo "Press (Y/n) to continue or exit"
read choice

if [ "$choice" == "n" ] || [ "$choice" == "N" ]
	then
	exit 1
fi

input=$(ls -a | grep input)
output=$(ls -a | grep output)

#creating the directories
#add feature to detect if input directory is present and overwrite it
if [ ! -z"$input" ] || [ ! -d"$input" ]
	then
	mkdir input
fi

#add feature to detect if output directory is present and overwrite it
if [ ! -z"$output" ] || [ ! -d"$output" ]
	then
	mkdir output
fi

#input of number of test files
echo "Number of test files to be created : "
read files

#taking input for the generation file
echo "Test generation file name with the extension (eg : generate.cpp) : "
read generationFile

#input for source code file
echo "Source code file name with the extension (eg : source.cpp) : "
read sourceFile

#checking if it is present LATER
#found = ls -a | grep -c $generationFile
#if [ $found -e 0 ]
#	then
#	echo "Test generation file does not exist..."
#	#terminate here
#fi

g++ $generationFile

#creating the test files
for i in $(seq 1 $files)
do
	if [ $i -lt 10 ]
	then
		 ./a.out > input/input0"$i".txt
	else
		./a.out > input/input"$i".txt
	fi
	echo "Created input file $i..."
done

#assuming source code file is there
echo "Running source code file..."

g++ $sourceFile

for i in $(seq 1 $1)
do
	if [ $i -lt 10 ]
	then
		./a.out < input/input0"$i".txt > output/output0"$i".txt
	else
		./a.out < input/input"$i".txt > output/output"$i".txt
	fi
	echo "Created output file $i..."
done

echo "Created all testcases..."

		



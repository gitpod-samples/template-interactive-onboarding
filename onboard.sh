#!/usr/bin/bash env

# Basic input reading
read -rp ">> Enter your name: " name;
echo "++ Your name is ${name}";

# Basic input reading with placeholder text
			# PROMPT		# PLACEHOLDER_TEXT		# VAR
read -rp   ">> Today is: "		-ei "Friday" 		day;
echo "++ Today is ${day}";

# Pre-defined multiple choices
PS3="Select your fav pet: " # PROMPT

select choice in "Dog" "Cat"; do
	case "${choice}" in
		"Dog")
			echo "You selected Dog, Woof Woof!!";
			break;
		;;
		"Cat")
			echo "You got a Cat, Meww mewww!!";
			break;
		;;
	esac
done
#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Ctrl_C Function
function ctrl_c(){
	echo -e "\n\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} 💥 ${redColour}Forzando Salida...${endColour} 💥\n"
	tput cnorm; exit 1
}

#Ctrl_C
trap ctrl_c INT

#Global Variables
main_url="https://htbmachines.github.io/"

#Message Panel
function messagePanel(){

	echo -e "\n/////////////////////////////////////////////////////////////////////////////////////////////////\n"
	echo -e "\nHola y bienvenido al htbmachines personalizado por ${blueColour}ILUNATIC${endColour}"
	echo -e "Porfavor haga un ${yellowColour}'-h'${endColour} despues de ejecutar la herramienta para entrar en el panel de ayuda ${greenColour};)${endColour}\n"
	echo -e "\n/////////////////////////////////////////////////////////////////////////////////////////////////\n"

}

#Help Panel
function helpPanel(){

	echo -e "\n//////////////////////////////////////////////////////////////////"
	echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour}${turquoiseColour} Uso:${endColour}\n"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} h) ${endColour}${grayColour}Desplegar este panel de ayuda${endColour} 💡"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} m) ${endColour}${grayColour}Buscar por el nombre de alguna máquina${endColour} 💻"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} u) ${endColour}${grayColour}Descargar u obtener actualizaciones necesarias${endColour} 🔧"
	echo -e "\n//////////////////////////////////////////////////////////////////\n"

}

function updateDownloadfiles(){

	if [ ! -f bundle.js ]; then

		tput civis
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} ❌ ${redColour}El archivo no existe${endColour} ❌\n"
		sleep 2
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 💾 ${grayColour}Descargando el archivo necesario...${endColour} 💾\n"
		sleep 2
		curl -s https://htbmachines.github.io/bundle.js > bundle.js
		js-beautify bundle.js | sponge bundle.js
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ✅ ${greenColour}El archivo necesario ha sido descargado:${endColour}${grayColour} bundle.js${endColour} ✅\n"
		echo -e "\n${greenColour}//////////////////////////////////////////////////////////////${endColour}\n$(ls -la | grep "bundle.js")\n${redColour}/////////////////////////////////////////////////////////////${endColour}\n"
		tput cnorm

	else

		tput civis
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 📁 ${greenColour}El Archivo Ya Existe${endColour} 📁\n"
		echo -e "\n${greenColour}///////////////////////////////////////////////////////////////${endColour}\n$(ls -la | grep "bundle.js")\n${redColour}//////////////////////////////////////////////////////////////${endColour}\n"
		sleep 1
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 🔎 ${grayColour}Comprobando por actualizaciones...${endColour} 🔎\n"
		sleep 4
		tput cnorm

	fi
	

}

#Search Machine
function searchMachine(){

	machineName="$1"

	echo -e "\n[+] $machineName\n"

}

#Indicators
declare -i parameter_counter=0

#Arguments
while getopts "uhm:" arg; do
	case $arg in
		h) let parameter_counter+=1;;
		m) machineName="$OPTARG"; let parameter_counter+=2;;
		u) let parameter_counter+=3;;
	esac
done

if [ $parameter_counter -eq 1 ]; then
	helpPanel
elif [ $parameter_counter -eq 2 ]; then
	searchMachine $machineName
elif [ $parameter_counter -eq 3 ]; then
	updateDownloadfiles
else
	messagePanel
fi

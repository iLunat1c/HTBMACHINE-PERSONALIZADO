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
main_url="https://htbmachines.github.io/bundle.js"

#Message Panel
function messagePanel(){

	clear
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
	echo -e "\nHola y bienvenido al htbmachines personalizado por ${blueColour}ILUNATIC${endColour}"
	echo -e "Porfavor haga un ${yellowColour}'-h'${endColour} despues de ejecutar la herramienta para entrar en el panel de ayuda ${greenColour};)${endColour}\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
}

#Help Panel
function helpPanel(){

	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"	
	echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour}${turquoiseColour} Uso:${endColour}\n"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} h) ${endColour}${grayColour}Desplegar este panel de ayuda${endColour} 💡"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} m) ${endColour}${grayColour}Buscar por el nombre de alguna máquina${endColour} 💻"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} u) ${endColour}${grayColour}Descargar u obtener actualizaciones necesarias${endColour} 🔧"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	

}

function updateDownloadfiles(){

	if [ ! -f bundle.js ]; then

		tput civis
		clear
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} ❌ ${redColour}El archivo no existe${endColour} ❌\n"
		sleep 1
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 💾 ${grayColour}Descargando el archivo necesario...${endColour} 💾\n"
		sleep 1
		curl -s $main_url > bundle.js
		js-beautify bundle.js | sponge bundle.js
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ✅ ${greenColour}El archivo necesario ha sido descargado:${endColour}${grayColour} bundle.js${endColour} ✅\n"
		echo -e "\n${greenColour}//////////////////////////////////////////////////////////////${endColour}\n$(ls -la | grep "bundle.js")\n${redColour}/////////////////////////////////////////////////////////////${endColour}\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		tput cnorm

	else
		tput civis
		clear
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 📁 ${greenColour}El Archivo Ya Existe${endColour} 📁\n"
		echo -e "\n${greenColour}///////////////////////////////////////////////////////////////${endColour}\n$(ls -la | grep "bundle.js")\n${redColour}//////////////////////////////////////////////////////////////${endColour}\n"
		sleep 1
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 🔎 ${grayColour}Comprobando por actualizaciones...${endColour} 🔎\n"
		sleep 2
		curl -s $main_url > bundle_temp.js
		js-beautify bundle_temp.js | sponge bundle_temp.js

		md5sum_bundle_js_original="$(md5sum bundle.js | awk '{print $1}')"
		md5sum_bundle_js_temp="$(md5sum bundle_temp.js | awk '{print $1}')"

		if [ "$md5sum_bundle_js_original" == "$md5sum_bundle_js_temp" ]; then
			echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}] ${endColour}${greenColour}✅ No hay actualizaciones pendientes${endColour} ✅\n"
			rm bundle_temp.js
		else
			echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} 🛑 ${redColour}Hay actualizaciones pendientes${endColour} 🛑\n"
			sleep 1
			echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 📡 ${grayColour}Actualizando...${endColour} 📡\n"
			sleep 2
			rm bundle.js
			mv bundle_temp.js bundle.js
			echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} 🔧 ${greenColour}Se ha actualizado el archivo correctamente${endColour} 🔧\n"
		fi
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		tput cnorm

	fi
	

}

#Search Machine
function searchMachine(){

	machineName="$1"
	machineName="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta: /" | grep -vE "id: |sku: |resuelta: " | tr -d '"' | tr -d ',' | sed 's/^ */[+] /')"

	if [ "$machineName" ]; then
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n$machineName"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	else
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} 🚫 ${redColour}La maquina seleccionada no existe${endColour} 🚫\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
	fi
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

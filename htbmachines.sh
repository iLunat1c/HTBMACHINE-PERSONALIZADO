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
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} i) ${endColour}${grayColour}Obtener el nombre de la maquina por su direccion IP 🌐${endColour}"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} o) ${endColour}${grayColour}Obtener el sistema operativo de las maquinas 🖥️${endColour}"
	echo -e "\t${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${purpleColour} y) ${endColour}${grayColour}Obtener el tutorial de la máquina 🎥${endColour}"
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
		sleep 3
		clear
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
		sleep 3
		clear
		tput cnorm

	fi
	

}

#Search Machine
function searchMachine(){

	ipAddress_name=machineName
	machineName="$1"
	machineName="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta: /" | grep -vE "id: |sku: |resuelta: " | tr -d '"' | tr -d ',' | sed 's/^ */[+] /')"

	if [ "$machineName" ]; then
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n$machineName"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	else
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} 🚫 ${redColour}La maquina seleccionada no existe${endColour} 🚫\n"
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour}${grayColour} Asegurate de haber puesto bien las mayusculas y minusculas, si no sabes el nombre de ninguna maquina... recomendamos buscar por os${endColour}\n"
	echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"	
	fi
}

#IP SEARCH
function ipSearch(){
	ipAddress="$1"
	ipAddress_name="$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 4 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',')"

	if [ $ipAddress_name ]; then
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ${grayColour}El nombre de la máquina de la dirreccion ip${endColour}${blueColour} $ipAddress${endColour} ${grayColour}es:${endColour}${redColour} $ipAddress_name${endColour}\n"
		searchMachine $ipAddress_name
		echo -e "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	else
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} ${grayColour}No se encontro esa dirreccion IP${endColour}\n"
		echo -e "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	fi
}

#OS Search
function osSearch(){
	os="$1"
	os_names="$(cat bundle.js | grep "so: \"$os\"" -B 4 | grep "name: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',' | column)"

	if [ "$os_names" ]; then
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ${grayColour}Los sistemas operativos de${endColour} $os${grayColour} son:${endColour} \n\n$os_names\n"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

	else
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} 🚫 ${redColour}No existe el sistema operativo, pusiste bien las mayusculas y minusculas?${endColour} 🚫\n"
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ${grayColour}Solo existen sistemas operativos Linux y Windows${endColour}\n"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	fi
}

#Youtube Links
function youtubeTutorials(){
	machineName="$1"
	machineyoutube="$(cat bundle.js | grep "name: \"$machineName\"" -A 10 | grep "youtube: " | awk 'NF{print $NF}' | tr -d '"' | tr -d ',')"

	if [ "$machineyoutube" ]; then
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${greenColour}+${endColour}${yellowColour}]${endColour} ${grayColour}El link de youtube para la maquina${endColour} ${blueColour}$machineName${endColour} ${grayColour}es:${endColour} ${blueColour}$machineyoutube${endColour}\n"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	else
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo -e "\n${yellowColour}[${endColour}${redColour}!${endColour}${yellowColour}]${endColour} ${redColour}No se encontro la maquina proporcionada${endColour}\n"
		echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	fi
}

#Indicators
declare -i parameter_counter=0

#Arguments
while getopts "uhm:i:o:y:" arg; do
	case $arg in
		h) let parameter_counter+=1;;
		m) machineName="$OPTARG"; let parameter_counter+=2;;
		u) let parameter_counter+=3;;
		i) ipAddress="$OPTARG"; let parameter_counter+=4;;
		o) os="$OPTARG"; let parameter_counter+=5;;
		y) machineName="$OPTARG"; let parameter_counter+=6;;
	esac
done

if [ $parameter_counter -eq 1 ]; then
	helpPanel
elif [ $parameter_counter -eq 2 ]; then
	searchMachine $machineName
elif [ $parameter_counter -eq 3 ]; then
	updateDownloadfiles
elif [ $parameter_counter -eq 4 ]; then
	ipSearch $ipAddress
elif [ $parameter_counter -eq 5 ]; then
	osSearch $os
elif [ $parameter_counter -eq 6 ]; then
	youtubeTutorials $machineName
else
	messagePanel
fi

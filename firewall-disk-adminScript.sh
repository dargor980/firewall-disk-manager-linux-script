#! /bin/bash

while true; do
	clear
	echo "---------------- Administracion de Sistema Operativo ----------------"
	echo ""
	echo "1) Gestionar Tareas de firewalld"
	echo "2) Gestionar Particiones de disco"
	echo "3) Gestionar volumenes logicos"
	echo "9) Salir"
	echo ""
	read -p "Seleccione una opcion: " opt
	case $opt in 
		1)
			task=""
			while [[ ! $task =~ ^([qQ])$ ]];
			do
				clear
				echo "---------- Gestionar Tareas de firewalld ----------"
				echo ""
				echo "1) Crear zona de firewall"
				echo "2) Modificar zona por defecto"
				echo "3) Agregar/Remover servicios a las zonas activas"
				echo "4) Crear reglas enriquecidas (rich rules)"
				echo "5) Modificar interfaz de red a distintas zonas (add-remove-change)"
				echo "Q) Volver al menú principal"
				echo ""
				read -p "Seleccione una tarea: " task
				case $task in 
					1)
						clear
						echo "---------- Crear zona de firewall ----------"
						echo ""
						read -p "Ingrese el nombre de la nueva zona de firewall: " zone
						res=$(firewall-cmd --get-default-zone)
						if [ "$res" = "$zone" ];
						then
							echo "La zona $zone ya existe"
						else
							firewall-cmd --permanent --new-zone=$zone && echo "La zona $zone ha sido creada." || echo "Error al crear la zona $zone"
						fi
						read -p "Presione Enter para volver..."
						;;
					2)
						clear
						echo "---------- Modificar zona por defecto ----------"
						echo ""
						read -p "Ingrese la zona: " defaultzone
						res=$(firewall-cmd --get-default-zone)
						if [ "$res" = "$defaultzone" ];
						then
							echo "La zona $defaultzone ya es una zona por defecto"
						else
							firewall-cmd --set-default-zone=$defaultzone && echo "La zona $defaultzone ha sido establecida por defecto." || echo "Error al establecer por defecto la zona $defaultzone"
						fi
						read -p "Presione Enter para volver..."
						;;
					3)
						suboption=""
						while [[ ! $suboption =~ ^([qQ])$ ]];
						do
							clear
							echo "---------- Agregar/Remover servicios a las zonas activas ----------"
							echo ""
							echo "1) Agregar Servicio"
							echo "2) Remover Servicio"
							echo "q) Volver"
							echo ""
							read -p "Seleccione una opción: " suboption
							case $suboption in 
								1)
									clear
									echo "---------- Agregar servicio a zona activa ----------"
									echo ""
									read -p "Ingrese la zona a la que desea agregar el servicio: " zone
									read -p "Ingrese el serivicio a agregar: " service
									firewall-cmd --permanent --zone=$zone --add-service=$service && echo "El servicio $service ha sido agregado a la zona $zone ."
									read -p "Presione Enter para volver..."
									;;
								2)
									clear
									echo "---------- Remover servicio de zona activa ---------"
									echo ""
									read -p "Ingrese la zona en la que desea remover el servicio: " zone
									read -p "Ingrese el serivicio a remover: " service
									firewall-cmd --permanent --zone=$zone --remove-service=$service && echo "El servicio $service ha sido removido de la zona $zone ."
									read -p "Presione Enter para volver..."
									;;
								"q")
									clear
									;;
								"Q")
									clear
									;;
								*)
									clear
									echo "Opción inválida..."
									sleep 1
									;;
							esac
						done
						;;
					4)
						clear
						echo "---------- Crear reglas enriquecidas (rich rules) ----------"
						echo ""
						read -p "Ingrese la zona: " zone
						firewall-cmd --zone=$zone --add-rich-rule && echo "Se agregó la regla enriquecida a la zona $zone" || echo "Error al agregar la regla enriquecida a la zona $zone"
						read -p "Presione Enter para volver..."
						;;
					5)
						suboption=""
						while [[ ! $suboption =~ ^([qQ])$ ]];
						do
							clear
							echo "---------- Modificar interfaz de red a distintas zonas (add-remove-change) ----------"
							echo ""
							echo "1) Agregar interfaz de red"
							echo "2) Remover interfaz de red"
							echo "3) Cambiar interfaz de red"
							echo "Q) Volver"
							echo ""
							read -p "Seleccione una opción: " suboption
							case $suboption in
								1)
									clear
									echo "---------- Agregar interfaz de red ----------"
									echo ""
									read -p "Ingrese la zona: " zone
									read -p "Ingrese la interfaz a agregar: " interface
									firewall-cmd --zone=$zone --add-interface=$interface && echo "La interfaz $interface ha sido agregada a la zona $zone " || echo "No se ha podido agregar la interfaz $interface a la zona $zone"
									read -p "Presione Enter para volver..."
									;;
								2)
									clear
									echo "---------- Remover interfaz de red ----------"
									echo ""
									read -p "Ingrese la zona: " zone
									read -p "Ingrese la interfaz a remover: " interface
									firewall-cmd --zone=$zone --remove-interface=$interface && echo "La interfaz $interface ha sido removida de la zona $zone " || echo "No se ha podido remover la interfaz $interface de la zona $zone ."
									read -p "Presione Enter para volver..."
									;;
								3)
									clear
									echo "---------- Cambiar interfaz de red ----------"
									echo ""
									read -p "Ingrese la zona: " zone
									read -p "Ingrese la interfaz a cambiar: " interface
									firewall-cmd --zone=$zone --change-interface=$interface && echo "La interfaz $interface ha sido cambiada a la zona $zone " || echo "No se ha podido cambiar la interfaz $interface a la zona $zone "
									read -p "Presione Enter para volver..."
									;;
								"q")
									clear
									;;
								"Q")
									clear
									;;
								*)
									clear
									echo "Opción inválida"
									sleep 1
									;;
							esac
						done
						;;
					"q")
						clear
						;;
					"Q")
						clear
						;;
					*)
						clear
						echo "Opción inválida"
						;;
					
				esac
			done
			;;
		2)
			clear
			echo "---------- Gestionar Particiones de disco ----------"
			;;
		3)
			clear
			echo "---------- Gestionar volumenes logicos ----------"
			;;
		9)
			clear
			break
			;;
		*)
			clear
			echo "Opción invalida"
			sleep 1
			;;
	esac
done
		
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
									read -p "Ingrese el servicio a agregar: " service
									firewall-cmd --permanent --zone=$zone --add-service=$service && echo "El servicio $service ha sido agregado a la zona $zone ." || echo "Error al agregar el servicio $service a la zona $zone ."
									read -p "Presione Enter para volver..."
									;;
								2)
									clear
									echo "---------- Remover servicio de zona activa ---------"
									echo ""
									read -p "Ingrese la zona en la que desea remover el servicio: " zone
									read -p "Ingrese el servicio a remover: " service
									firewall-cmd --permanent --zone=$zone --remove-service=$service && echo "El servicio $service ha sido removido de la zona $zone ." || echo "Error al remover el servicio $service de la zona $zone ."
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
						read -p "Ingrese la regla (ejemplo: rule family=\"ipv4\" source address=\"192.168.0.102\" accept): " rule
						firewall-cmd --zone=$zone --add-rich-rule="$rule" && echo "Se agregó la regla enriquecida a la zona $zone" || echo "Error al agregar la regla enriquecida a la zona $zone"
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
						sleep 1
						;;
					
				esac
			done
			;;
		2)
			task=""
			while [[ ! $task =~ ^([qQ])$ ]];
			do
				clear
				echo "---------- Gestionar Particiones de disco ----------"
				echo ""
				echo "1) Listar discos"
				echo "2) Crear Partición de disco"
				echo "3) Crear tabla de particiones de disco"
				echo "4) Redimensionar Particiones de disco"
				echo "5) Eliminar Partición de disco"
				echo "6) Montar partición"
				echo "7) Desmontar partición"
				echo "Q) Volver al menú principal"
				echo ""
				read -p"Seleccione una tarea: " task
				case $task in
					1)
						clear
						echo "---------- Listado de discos ----------"
						echo ""
						fdisk -l
						read -p "Presione Enter para volver..."
						;;
					2)
						clear
						echo "---------- Crear Partición de disco ---------"
						echo ""
						read -p "Ingrese la unidad (ejemplo: /dev/sda): " unit
						echo "Seleccione tipo de partición: "
						echo "1) Primaria"
						echo "2) Extendida"
						
						read -p "Seleccione opción: " partType
						case $partType in
							1)
								echo "sistema de archivos: "
								echo "1) ext4"
								echo "2) fat32"
								read -p "Seleccione opción: " filesystem
								case $filesystem in
									1)
										read -p "Ingrese inicio de la partición: " start
										read -p "Ingrese final de la partición: " end
										parted $unit mkpart primary ext4 $start $end && echo "La partición ha sido creada exitosamente." || echo "Error al crear la partición"
										read -p "Presione Enter para volver..."
										;;
				
									2)
										read -p "Ingrese inicio de la partición: " start
										read -p "Ingrese final de la partición: " end
										parted $unit mkpart primary fat32 $start $end && echo "La partición ha sido creada exitosamente." || echo "Error al crear la partición"
										read -p "Presione Enter para volver..."
										;;
									
									*)
										echo "Opción inválida"
										sleep 1
										clear
										;;
								esac 
		
								
								;;
							2)
								read -p "Ingrese inicio de la partición: " start
								read -p "Ingrese final de la partición: " end
								parted $unit extended $start $end && echo "La partición ha sido creada exitosamente." || echo "Error al crear la partición"
								;;
							*)
								echo "Opción inválida"
								sleep 1
								clear
								;;
						esac 

						parted $unit mkpart $partType $start $end && echo "La partición ha sido creada exitosamente." || echo "Error al crear la partición"
						
						;;
					3)
						suboption=""
						while [[ ! $suboption =~ ^([qQ])$ ]];
						do	
							clear					
							echo "---------- Crear tabla de particiones de disco ----------"
							echo ""
							echo "1) Crear tabla GPT"
							echo "2) Crear tabla MBR"
							echo "Q) Volver"
							echo ""
							read -p "Selecciona una opción: " suboption
							case $suboption in
								1)
									clear
									echo "---------- Crear tabla de particiones GPT ----------"
									echo ""
									fdisk -l 
									read -p "Ingrese disco (ejemplo /dev/sda): " disk
									parted $disk mklabel gpt && echo "Tabla de particiones GPT creada correctamente en $disk" || echo "No se pudo crear la tabla de particiones en $disk"
									read -p "Presione Enter para volver... "
									;;
								2)
									clear
									echo "---------- Crear tabla de particiones MBR ----------"
									echo ""
									fdisk -l
									read -p "Ingrese disco (ejemplo /dev/sda): " disk
									parted $disk mklabel msdos && echo "Tabla de particiones MBR creada correctamente en $disk" || echo "No se pudo crear la tabla de particiones MBR en $disk"
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
					4)
						suboption=""
						while [[ ! $suboption =~ ^([qQ])$ ]];
						do
							clear
							echo "---------- Redimensionar Particiones de disco ----------"
							echo ""
							echo "1) Extender Particiones"
							echo "2) Reducir Particiones"
							echo "Q) Volver"
							echo ""
							read -p "Seleccione una opción: " suboption
							case $suboption in

								1)
									clear
									echo "---------- Extender Particiones ----------"
									echo ""
									read -p "Ingrese la unidad de disco (ejemplo: /dev/sda): " unit
									parted $unit print
									read -p "Seleccione partición (ingrese el número de partición):" partition
									read -p "Ingrese final de partición  (debe ser mayor al anterior): " end
									parted $unit resizepart $partition $end && echo "La partición se extendió exitosamente" || echo "Error en extender partición"
									read -p "Presione Enter para volver..."
									;;
								2)
									clear
									echo "---------- Reducir Particiones ----------"
									echo ""
									read -p "Ingrese la unidad de disco (ejemplo: /dev/sda): " unit
									parted $unit print
									read -p "Seleccione partición (ingrese el número de partición): " partition
									read -p "Ingrese final de partición (debe ser menor al anterior): " end
									parted $unit resizepart $partition $end && echo "La partición se redujo con éxito" || echo "Error al reducir la partición."
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
					5)
						clear
						echo "---------- Eliminar Partición de disco ----------"
						echo ""
						read -p "Ingrese la unidad de disco (ejemplo: /dev/sda): " unit
						parted $unit print
						read -p "Ingrese el número de partición que desea eliminar: " partition
						read -p "Advertencia: Acción destructiva. Está seguro que desea eliminar la partición? [S/N] " option
						case $option in
							"S")
								clear
								parted $unit rm $partition && echo "la partición $partition de la unidad $unit ha sido eliminada correctamente" || echo "No se ha podido eliminar la partición $partition del disco $unit "
								read -p "Presione Enter para volver..."
								;;
							"s")
								clear
								parted $unit rm $partition && echo "la partición $partition de la unidad $unit ha sido eliminada correctamente" || echo "No se ha podido eliminar la partición $partition del disco $unit "
								read -p "Presione Enter para volver..."
								;;
							"N")
								clear
								read -p "Presione Enter para volver..."
								;;
							"n")
								clear
								read -p "Presione Enter para volver..."
								;;
							*) 
								clear
								echo "Opción inválida."
								sleep 1
								;;
						esac
						
						;;
					6)
						clear
						echo "---------- Montar Partición de disco ----------"
						echo ""
						read -p "Ingrese la unidad de disco (ejemplo: /dev/sda): " unit
						parted $unit print
						read -p "Ingrese el número de la partición que desea montar: " partition
						if [[ $(mkdir /media/sdb$partition) -eq 0 ]];
						then
							echo "/dev/sdb$partition /media/sdb$partition ext4 auto, rw,users,unmask=000 0 0" >> /etc/fstab
						mount $unit$partition && echo "se ha montado la partición $partition del disco $unit correctamente." || echo "No se ha podido montar la partición $partition del disco $unit"
						fi
						read -p "Presione Enter para Volver..."
						;;
					7)
						clear
						echo "---------- Desmontar Partición de disco ----------"
						echo ""
						read -p "Ingrese la unidad de disco (ejemplo: /dev/sda): " unit
						parted $unit print
						read -p "Ingrese el número de la partición que desea desmontar: " partition
						umount $unit$partition && echo "Se ha desmontado la partición $partition del disco $unit correctamente." || echo " No se ha podido desmontar la partición $partition del disco $unit"
						read -p "Presione Enter para volver..."
						;;
					"q")
						clear
						;;
					"Q")
						clear
						;;
					*)
						echo "Opción inválida"
						sleep 1
						;;
 
				esac			
			done

			;;
		3)
			task=""
			while [[ ! $task =~ ^([qQ])$ ]];
			do
				clear
				echo "---------- Gestionar volúmenes logicos ----------"
				echo ""
				echo "1) Escanear dispositivos"
				echo "2) Crear volumen lógico"
				echo "3) Listar volúmenes lógicos"
				echo "4) Crear grupo de volúmenes lógicos"
				echo "5) Seguimiento de volúmenes lógicos"
				echo "6) Eliminar volumen lógico"
				echo "Q) Volver al menú principal"
				echo ""
				read -p "Seleccione una opción: " task
				case $task in
 					1)
						clear
						echo "---------- Escanear dispositivos ----------"
						echo ""
						lvmdiskscan
						read -p "Presione Enter para volver... "
						;;
					2)
						clear
						echo "---------- Crear volumen Físico ----------"
						echo ""
						read -p "Ingrese el disco en donde creará el volumen físico (ejemplo: /dev/sda) : " device
						pvcreate $device && echo "Se creó el volumen físico en $device " || echo "Error al crear volumen físico en $device"
						read -p "Presione Enter para volver..."
						;;
					3)
						clear
						echo "--------- Listar volúmenes físicos ----------"
						echo ""
						pvdisplay
						read -p "Presione Enter para volver..."
						;;
					4)
						clear
						echo "---------- Crear grupo de volúmenes lógicos ----------"
						echo ""
						read -p "Ingrese el disco donde se creará el grupo de volúmenes lógicos (ejemplo: /dev/sda) : " device
						read -p "Ingrese el nombre del grupo de volúmenes lógicos: " group
						if [[ $(vgcreate $group $device) -eq 0 ]];
						then
							read -p "Desea agregar más volúmenes físicos al grupo? [S/N]: " option
							case $option in
								"S")
									read -p "Ingrese el nombre del volumen físico (ejemplo: /dev/sda3): " volume
									vgextend $group $volume && echo "Se agregó el volumen físico  $volume al grupo de volúmenes $group" || echo "No se pudo agregar el volumen físico $volume al grupo de volúmenes $group"
									read -p "Desea crear un volumen lógico en el grupo? [S/N]: " option
									case $option in
										"S")
											clear
											read -p "Ingrese el nombre del volumen lógico: " name
											read -p "Ingrese el tamaño del volumen lógico (ejemplo: 2G): " size
											lvcreate -L $size $group -n $name && echo "Se creó el volumen lógico $name en el grupo $group . Punto de montaje: /dev/$group/$name" || echo " No se pudo crear el volumen lógico $name en el grupo $group"
											echo ""
											echo "Montando volumen lógico..."
											read -p "Ingrese el sistema de archivos del volumen (ejemplo: ext4) : " filesystem
											mkfs.$filesystem /dev/$group/$name
											mount /dev/$group/$name /home && echo "se ha montado el volumen /dev/$group/$name " || echo "Error al montar volumen /dev/$group/$volume"
											read -p "Presione Enter para volver..."
					
											;;											
										"s")
											clear
											read -p "Ingrese el nombre del volumen lógico: " name
											read -p "Ingrese el tamaño del volumen lógico (ejemplo: 2G): " size
											lvcreate -L $size $group -n $name && echo "Se creó el volumen lógico $name en el grupo $group . Punto de montaje: /dev/$group/$name" || echo " No se pudo crear el volumen lógico $name en el grupo $group"
											echo ""
											echo "Montando volumen lógico..."
											read -p "Ingrese el sistema de archivos del volumen (ejemplo: ext4) : " filesystem
											mkfs.$filesystem /dev/$group/$name
											mount /dev/$group/$name /home && echo "se ha montado el volumen /dev/$group/$name " || echo "Error al montar volumen /dev/$group/$volume"
											read -p "Presione Enter para volver..."
											;;
										"N")
											clear
											;;
										"n")
											clear
											;;
										*) 
											clear
											echo "Opción inválida."
											sleep 1
											;;
									esac
									read -p "Presione Enter para volver..."
									;;
								"s")
									read -p "Ingrese el nombre del volumen físico (ejemplo: /dev/sda3): " volume
									vgextend $group $volume && echo "Se agregó el volumen físico  $volume al grupo de volúmenes $group" || echo "No se pudo agregar el volumen físico $volume al grupo de volúmenes $group"
									read -p "Presione Enter para volver..."
									;;
								"N")
									clear
									;;
								"n") 
									clear
									;;
								*)
									echo "Opción inválida."
									sleep 1
									;;
							esac
						fi
						
						;;
					5)
						clear
						echo "---------- Seguimiento de volúmenes lógicos ----------"
						echo ""
						lvdisplay
						read -p "Presione Enter para volver..."
						;;
					6)
						clear
						echo "---------- Eliminar volumen lógico ----------"
						echo ""
						lvs
						lsblk
						echo ""
						read -p "Ingrese punto de montaje del volumen lógico (ejemplo: /home): " volume
						umount $volume
						read -p "Ingrese el nombre del grupo de volúmenes al que pertenece el volumen: " group
						read -p "Ingrese el nombre del volumen a eliminar: " name
						read -p "Advertencia: Acción destructiva. Está seguro de que quiere eliminar el volumen $group/$name ? [S/N] " option
						case $option in
							"S")
								clear
								lvremove $group/$name && echo "Se ha eliminado el volumen $name del grupo $group" || echo "No se ha podido eliminar el volumen $name del grupo $group"
								read -p "Presione Enter para volver..."
								;;
							"s")
								lvremove $group/$name && echo "Se ha eliminado el volumen $name del grupo $group" || echo "No se ha podido eliminar el volumen $name del grupo $group"
								read -p "Presione Enter para volver..."
								clear
								;;
							"n")
								clear
								;;
							"N")
								clear
								;;
							*) 
								clear
								echo "Opción inválida."
								sleep 1
								;;
						esac
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
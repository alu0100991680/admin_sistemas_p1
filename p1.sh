echo " ------------ "
echo "| PRÁCTICA 1 |"
echo " ------------ "
echo ""
echo "[PACKAGE QUOTA] INSTALL"
yum install ­y quota
yum install ­y acl
echo "[del -r] LIMPIAR USUARIOS PREVIOS Y SUS DIRECTORIOS HOME"
userdel -r usu1 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r usu2 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r usu3 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r usu4 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r usu5 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r usu6 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r ejec1 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
userdel -r ejec2 # Eliminará todo lo que pueda menos el directorio HOME ya que más abajo cambiamos el propietario a root
echo "··Eliminamos directorios personales que userdel -r no puede por permisos"
rm -rf /home/usu1 # Ahora eliminamos lo que en el paso anterior no pudimos
rm -rf /home/usu2
rm -rf /home/usu3
rm -rf /home/usu4
rm -rf /home/usu5
rm -rf /home/usu6
rm -rf /home/ejec1
rm -rf /home/ejec2
echo "[rm -rf /export as root] ELINAMOS TODO LO QUE TIENE QUE VER CON LOS PROYECTOS"
rm -rf /export # Eliminamos todo el arbol de la práctica /export/...
echo "[groupdel] ELIMINAMOS LOS GRUPOS"
groupdel Aeropuerto # Eliminamos todos los grupos creados para la práctica
groupdel CentroComercial
groupdel Parque
groupdel Eaeropuerto
groupdel Ecentrocomercial
groupdel Eparque
groupdel Comun
echo ""
echo " ------------------ "
echo "| MONTANDO ESQUEMA |"
echo " ------------------ "
echo "Practica 1: Test de comandos"
echo "[useradd+chown+chmod] CREAR USUARIOS BLOQUEANDO QUE PUEDAN CAMBIAR SUS PROPIOS PERMISOS"
# Adduser es un wrapper en PERL de useradd. Adduser, es mas friendly
useradd -m -d /home/usu1 usu1
useradd -m -d /home/usu2 usu2
useradd -m -d /home/usu3 usu3
useradd -m -d /home/usu4 usu4
useradd -m -d /home/usu5 usu5
useradd -m -d /home/usu6 usu6
useradd -m -d /home/ejec1 ejec1
useradd -m -d /home/ejec2 ejec2
echo "··Ahora bloqueamos que el usurio por si mismo no pueda cambiar sus permisos"
chown root:usu1 /home/usu1
chown root:usu2 /home/usu2
chown root:usu3 /home/usu3
chown root:usu4 /home/usu4
chown root:usu5 /home/usu5
chown root:usu6 /home/usu6
chown root:ejec1 /home/ejec1
chown root:ejec2 /home/ejec2
echo "··Cambiamos los permios para que si se pueda acceder"
chmod 070 /home/usu1
chmod 070 /home/usu2
chmod 070 /home/usu3
chmod 070 /home/usu4
chmod 070 /home/usu5
chmod 070 /home/usu6
chmod 070 /home/ejec1
chmod 070 /home/ejec2
echo "[chage] CADUCIDAD EN PASSWORD PARA 3 MESES"
# La herramienta chage modifica el número de días entre
# cambios de contraseña y la fecha del último cambio de contraseña.
# Esta información es utilizada por el sistema para determinar
# cuando un usuario debe cambiar su contraseña.
# ---
# Cambiar la password cada 90 dias. Si pasan dos dias sin
# cambiarse la cuenta es bloqueda. Un dia antes de la fecha
# limite se avisa del cambio de la password
chage -M 90 -I 2 -W 1 usu1
chage -M 90 -I 2 -W 1 usu2
chage -M 90 -I 2 -W 1 usu3
chage -M 90 -I 2 -W 1 usu4
chage -M 90 -I 2 -W 1 usu5
chage -M 90 -I 2 -W 1 usu6
echo "[chage -l] LISTAR LAS CONDICIONES DE CUENTA"
echo "··Ejemplo"
chage -l usu1
echo "[passwd] CAMBIAR PASSWORD A CADA USUARIO"
# En la practica manual usamos el comando passwd
# passwd usu1
# <wizzard>
printf "usu1\nusu1" | sudo passwd usu1
printf "usu2\nusu2" | sudo passwd usu2
printf "usu3\nusu3" | sudo passwd usu3
printf "usu4\nusu4" | sudo passwd usu4
printf "usu5\nusu5" | sudo passwd usu5
printf "usu6\nusu6" | sudo passwd usu6
printf "ejec1\nejec1" | sudo passwd ejec1
printf "ejec2\nejec2" | sudo passwd ejec2
echo " -------------------------------------------------------------- "
echo "| QUOTAS DE DISCO. SOLO APLICABLE EN LA IMAGEN CENTOS7 DE IAAS |"
echo " -------------------------------------------------------------- "
echo "[fstab+mount] CREAMOS LAS CUOTAS DE ESPACIO"
echo "··NOTA: RECUERDA EDITAR /etc/fstab añadiendo -usrquota- dentras de default en la partición /home"
echo "··      /dev/mapper/sistema-home /home    ext4    defaults, usrquota   1   2"
mount -o remount /home
echo "··Desactivando servicio previo"
quotaoff /home
echo "··Creamos el sistema de archivos"
quotacheck -ugmv /home
echo "··¿Existe config-file?"
ls /home/aquota.user
echo "··Activando el servicio"
quotaon -ugv /home
echo "··Añadimos los limites a cada usuario"
setquota -u usu1 51200 60000 0 0 /home
setquota -u usu2 51200 60000 0 0 /home
setquota -u usu3 51200 60000 0 0 /home
setquota -u usu4 51200 60000 0 0 /home
setquota -u usu5 51200 60000 0 0 /home
setquota -u usu6 51200 60000 0 0 /home
echo "··Establecimiento de tiempo de gracia"
echo "··NOTA: Editar mediante edquota -t para globales. Ejemplo 2days 2days"
echo "        Editar mediante edquota -u <usuario> -t para usuario concreto. Ejemplo 2days 2days"
echo "        /dev/mapper/sistema-home     2days    2days"
echo " -------------------------------- "
echo "| CREANDO ESPACIO PARA PROYECTOS |"
echo " -------------------------------- "
echo "[mkdir] CREAMOS DIRECTORIOS PARA LOS PROYECTOS"
mkdir /export
mkdir /export/proyectos
mkdir /export/proyectos/Aeropuerto
mkdir /export/proyectos/CentroComercial
mkdir /export/proyectos/Parque
mkdir /export/proyectos/Comun
echo "[groupadd] CREAMOS LOS GRUPOS PARA CADA PROYECTO"
groupadd Aeropuerto
groupadd CentroComercial
groupadd Parque
groupadd Comun
echo "[groupadd] CREAMOS LOS GRUPOS PARA LOS EJECUTIVOS"
groupadd Eaeropuerto
groupadd Ecentrocomercial
groupadd Eparque
echo "[chgrp] ASIGNAMOS/CAMBIAMOS LOS GRUPOS A LOS DIRECTORIOS QUE CREAMOS PARA CADA PROYECTO"
chgrp Aeropuerto /export/proyectos/Aeropuerto
chgrp CentroComercial /export/proyectos/CentroComercial
chgrp Parque /export/proyectos/Parque
chgrp Comun /export/proyectos/Comun
echo "[usermod] ASIGNAMOS A CADA USUARIO SU GRUPO"
usermod -a -G Aeropuerto usu2
usermod -a -G Aeropuerto usu3
usermod -a -G Aeropuerto usu4
usermod -a -G Aeropuerto usu5
usermod -a -G CentroComercial usu1
usermod -a -G CentroComercial usu3
usermod -a -G CentroComercial usu4
usermod -a -G CentroComercial usu5
usermod -a -G Parque usu5
usermod -a -G Parque usu6
echo "[usermod] ASIGNAMOS A CADA EJECUTIVO SU GRUPO"
usermod -a -G Eaeropuerto ejec1
usermod -a -G Eaeropuerto ejec2
usermod -a -G Ecentrocomercial ejec2
usermod -a -G Eparque ejec1
echo "[usermod] ASIGNAMOS LOS USUARIOS A LA CARPETA COMUN"
usermod -a -G Comun usu1
usermod -a -G Comun usu2
usermod -a -G Comun usu3
usermod -a -G Comun usu4
usermod -a -G Comun usu5
usermod -a -G Comun usu6
echo "[setGID] AÑADIMOS SETGID(SUID PARA CARPETAS) AL GRUPO"
chmod 2770 /export/proyectos/Aeropuerto
chmod 2770 /export/proyectos/CentroComercial
chmod 2770 /export/proyectos/Parque
echo "[setUID a otros] SOLO PERMITIMOS QUE EL PROPIETARIO PUEDA ELIMINAR SUS PROPIOS CONTENIDOS DENTROS DE COMUN"
chmod 770 /export/proyectos/Comun # Cuidado con el orden en que se definen los permisos en conjunto con StickyBit
chmod o+t /export/proyectos/Comun # o chmod 1770... (lo mismo pero en una sola linea)
echo " ------------ "
echo "| EJECUTIVOS |"
echo " ------------ "
echo "[ACL+setfacl] LIMPIAMOS ACL"
setfacl -b -k -R /export/proyectos/Aeropuerto
setfacl -b -k -R /export/proyectos/CentroComercial
setfacl -b -k -R /export/proyectos/Parque
echo "[ACL+setfacl] ASOCIAMOS ACL CON LOS NUEVOS GRUPOS PARA EJECUTIVOS"
setfacl -m g:EjecutivoAeropuerto:x­/export/proyectos/Aeropuerto
setfacl -m g:EjecutivoCentroComercial:x­/export/proyectos/CentroComercial
setfacl -m g:EjecutivoParque:x­/export/proyectos/Parque
echo "[cp ls] COPIAMOS ls PARA CADA UNO DE LOS DELEGADOS"
cp /bin/ls /usr/local/bin/ls_aeropuerto
cp /bin/ls /usr/local/bin/ls_centrocomercial
cp /bin/ls /usr/local/bin/ls_parque
echo "[chgrp] CAMBIAMOS LOS GRUPOS PARA ls"
chgrp Eaeropuerto /usr/local/bin/ls_areopuerto
chgrp Ecentrocomercial /usr/local/bin/ls_centrocomercial
chgrp Eparque /usr/local/bin/ls_parque
echo "[ACL+ls] AÑADIMOS LOS PERMISOS NECESARIOS A LOS ls por medio de ACL"
setfacl -m g:Eaeropuerto:x /usr/local/bin/ls_aeropuerto
setfacl -m g:Ecentrocomercial:x /usr/local/bin/ls_centrocomercial
setfacl -m g:Eparque:x /usr/local/bin/ls_parque

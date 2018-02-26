echo "[PACKAGE QUOTA] INSTALL"
yum install ­y quota
yum install ­y acl
echo "[del -r] LIMPIAR USUARIOS PREVIOS Y SUS DIRECTORIOS HOME"
userdel -r usu1
userdel -r usu2
userdel -r usu3
userdel -r usu4
userdel -r usu5
userdel -r ejec1
userdel -r ejec2
echo "[rm -rf /export as root] ELINAMOS TODO LO QUE TIENE QUE VER CON LOS PROYECTOS"
rm -rf /export
echo "[groupdel] ELIMINAMOS LOS GRUPOS"
groupdel Aeropuerto
groupdel CentroComercial
groupdel Parque
groupdel Comun
echo ""
echo " ----------------- "
echo "| MONTANDO ESQUEMA|"
echo " ----------------- "
echo "Practica 1: Test de comandos"
echo "[useradd] CREAR USUARIOS"
# Adduser es un wrapper en PERL de useradd. Adduser, es mas friendly
useradd -m -d /home/usu1 usu1
useradd -m -d /home/usu2 usu2
useradd -m -d /home/usu3 usu3
useradd -m -d /home/usu4 usu4
useradd -m -d /home/usu5 usu5
useradd -m -d /home/ejec1 ejec1
useradd -m -d /home/ejec2 ejec2
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
echo "[chmod 700. uid=xrd]"
chmod u=rwx /home/usu1  # chmod 700
chmod g= /home/usu1
chmod o= /home/usu1
chmod u=rwx /home/usu2
chmod g= /home/usu2
chmod o= /home/usu2
chmod u=rwx /home/usu3
chmod g= /home/usu3
chmod o= /home/usu3
chmod u=rwx /home/usu4
chmod g= /home/usu4
chmod o= /home/usu4
chmod u=rwx /home/usu5
chmod g= /home/usu5
chmod o= /home/usu5
chmod u=rwx /home/usu6
chmod g= /home/usu6
chmod o= /home/usu6
chmod u=rwx /home/ejec1
chmod g= /home/ejec1
chmod o= /home/ejec1
chmod u=rwx /home/ejec2
chmod g= /home/ejec2
chmod o= /home/ejec2
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
echo "[chmod] LIMITAMOS EL ACCESO ENTRE GRUPOS PARA ESOS DIRECTORIOS"
chmod u=rwx /export/proyectos/Aeropuerto
chmod g=rwx /export/proyectos/Aeropuerto
chmod o= /export/proyectos/Aeropuerto
chmod u=rwx /export/proyectos/CentroComercial
chmod g=rwx /export/proyectos/CentroComercial
chmod o= /export/proyectos/CentroComercial
chmod u=rwx /export/proyectos/Parque
chmod g=rwx /export/proyectos/Parque
chmod o= /export/proyectos/Parque
chmod u=rwx /export/proyectos/Comun
chmod g=rwx /export/proyectos/Comun
chmod o= /export/proyectos/Comun
echo "[usermod] ASIGNAMOS LOS USUARIOS A LA CARPETA COMUN"
usermod -a -G Comun usu1
usermod -a -G Comun usu2
usermod -a -G Comun usu3
usermod -a -G Comun usu4
usermod -a -G Comun usu5
usermod -a -G Comun usu6
#echo "[groups] REPARTO DE GRUPOS"
#groups root
#groups usu1
#groups usu2
#groups usu3
#groups usu4
#groups usu5
#groups usu6
echo "[fstab+mount] CREAMOS LAS CUOTAS DE ESPACIO"
echo "··NOTA: RECUERDA EDITAR /etc/fstab añadiendo -usrquota- dentras de default en la partición /home"
echo "··      /dev/mapper/sistema-home /home    ext4    defaults, usrquota   1   2"
mount -o remount /home
echo "··Desactivando servicio previo"
quotaoff /home
echo "··Checking..."
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
echo "[chmod+sticky] SOLO PERMITIMOS QUE EL PROPIETARIO PUEDA ELIMINAR SUS PROPIOS CONTENIDOS DENTROS DE COMUN"
chmod o+t /export/proyectos/Comun
echo "[setGID] ????"
chmod 2770 /export/proyectos/Aeropuerto
chmod 2770 /export/proyectos/CentroComercial
chmod 2770 /export/proyectos/Parque
echo "[ACL+setfacl] LIMPIAMOS ACL"
setfacl -b -k -R /export/proyectos/Areopuerto
setfacl -b -k -R /export/proyectos/CentroComercial
setfacl -b -k -R /export/proyectos/Parque
echo "[ACL+setfacl] ASOCIAMOS ACL CON LOS NUEVOS GRUPOS PARA EJECUTIVOS"
setfacl -m g:EjectutivoAreopuerto:---­/export/proyectos/Areopuerto
setfacl -m g:EjectutivoCentroComercial:---­/export/proyectos/CentroComercial
setfacl -m g:EjectutivoParque:---­/export/proyectos/Parque
echo "[cp ls] COPIAMOS ls PARA CADA UNO DE LOS DELEGADOS"
cp /bin/ls /bin/ls_areopuerto
cp /bin/ls /bin/ls_centrocomercial
cp /bin/ls /bin/ls_parque
echo "[]CAMBIAMOS LOS GRUPOS PARA ls"

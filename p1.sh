echo "[del -r] LIMPIAR USUARIOS PREVIOS Y SUS DIRECTORIOS HOME"
userdel -r usu1
userdel -r usu2
userdel -r usu3
userdel -r usu4
userdel -r usu5
userdel -r usu6
echo "Practica 1: Test de comandos"
echo "[useradd] CREAR USUARIOS"
# Adduser es un wrapper en PERL de useradd. Adduser, es mas friendly
useradd -m -d /home/usu1 usu1
useradd -m -d /home/usu2 usu2
useradd -m -d /home/usu3 usu3
useradd -m -d /home/usu4 usu4
useradd -m -d /home/usu5 usu5
useradd -m -d /home/usu6 usu6
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


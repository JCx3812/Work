#!/bin/bash

apt-get install whois
apt-get install acl


echo -n " ajout du/des groupe(s) secondaire  (entrer pour arreter (vide) : "



read N
while [ ! -z "$N" ]
do 
    groupadd $N
    echo -n "nouveau groupe (entrer pour arreter) : "
    read N
done 

echo -n " creation groupe d'utilisateur enter stop :  " 

read U

while [ ! -z "$U" ]
do 
    echo -n " le groupe principal : "
    read G 
    echo -n " le mot de passe : "
    read MDP 
    useradd -m -d /home/$U -g $G -p `mkpasswd $MDP` -s /bin/bash $U 
    echo -n "nouveaux utilisateurs : "
    read U
done

echo -n " assignation de groupe à utlisateur  (entrer pour arreter separer avec , pour plusieur groupe) : "
read G

while [ ! -z "$G" ]
do 
    echo -n " utlisateur : "
    read U
    usermod -a -G $G $U
    echo -n " pour dautre ajout : "
    read G 
done 

echo -n " Creation de dossier "
read D
while [ ! -z "$D" ]
do 
    mkdir $D
    echo -n "Pour d autre dossier : "
    read D
done 

echo -n " droit par acl nom de dossier / fichier : " 
read ACL
while [ ! -z "$ACL" ]
do 
    chown root:root $ACL
    chmod 770 $ACL
    setfacl -b $ACL
    echo -n " choix pour group user other mask : "
    read CHOIX
    while [ ! -z "$CHOIX" ]
    do
    echo -n " Nom d'utilisateur ou groupe " 
    read GU
    echo -n " droit pour le choix (r w x | - pour rien) : "
    read DROIT
    setfacl -m $CHOIX:$GU:$DROIT $ACL
    echo -n " Pour changer le choix (group , user , other mask "
    read CHOIX
    done
    echo -n " Pour d autre fichier dossier : "
    read ACL
done

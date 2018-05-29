#!/bin/bash

rm ../Bin/attributs.rc
echo ""
echo "[+] Modification des informations d'assemblage"
echo ""

touch ../Bin/attributs.rc

echo "[+] Choisir le type de template applicatif à utiliser :"
echo "	[1] Certmgr.msc"
echo "	[2] -----------"
echo "	[3] -----------"
echo "	[4] -----------"
echo ""
read template

if [ $template = "1" ]
then
	cat ../Bin/template-rc-1 >> ../Bin/attributs.rc
	echo "[+] Template generé correctement ..."
else
    echo "[-] Saisie non valide ..."
    exit 1
fi

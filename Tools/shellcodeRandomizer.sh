#!/bin/bash

verbose=0

#Test argument null
if [ $# -eq 0 ]
  then
    echo "Paramètres manquants."
    exit 1
fi

#Test ordre argument 1 -o
if [ $1 = "-o" ]
then
    echo "Merci de respecter l'ordre des arguments."
    exit 1
fi

#Test ordre argument 1 -k
if [ $1 = "-k" ]
then
    echo "Merci de respecter l'ordre des arguments."
    exit 1
fi

#Test ordre argument 1 -v
if [ $1 = "-v" ]
then
    echo "Merci de respecter l'ordre des arguments."
    exit 1
fi

#Tests argument [-f] [fichier]
if [ $1 = "-f" ]
then
    #Test argument [fichier] existe
    if [ -z "$2" ]
    then
    echo "Paramètres [Input] manquants."
    exit 1
    else 
        #Tests si fichier de l'argument 2 existe
        if [ -f $2 ]
        then
        shellcode=$2
        else
        echo "Le fichier d'entrée n'existe pas ou le chemin pour y accéder est erroné."
        exit 1
        fi
    fi
fi

#Affiche l'aide
if [ $1 = "-h" ]
then
    exit 1
fi

#Trop d'arguments
if [ $# -gt 9 ]
then
    echo "Trop d'arguments."
    exit 1
fi



#Tests argument [-k] [Output keys]
if [ $5 = "-k" ]
then
    #Test argument [Output keys] existe
    if [ -z "$6" ]
    then
    echo "Paramètre [Output keys] manquants"
    exit 1
    else 
    finalK=$6
    fi
else
echo "Argument [-k] manquant."
exit 1
fi

#test argument verbosité
#if [ $7 = "-v" ]
#then
#verbose=1
#fi

#Retourne le code hexa brute
# /!\ A OPTIMISER /!\
touch output
sed -e 's/"//g' $shellcode > output
touch output1
sed -e 's/;//g' output > output1
sed -e 's/x//g' output1 > output
rm output1
sed 's@\\@@g' output > output1
rm output
sed '1d' output1 > output2
sed ':a;N;$!ba;s/\n//g' output2 > rawHexa
cp rawHexa rawHexaBak
rm output1
rm output2

#Récupère longueur de la chaine rawHexa + initialisation compteur 
lenghtRaw=$(wc -c rawHexa | cut -c -3)
lenght=$(($lenghtRaw/2))
n=0

#Prépare le fichier qui va contenir le shellcode modifié
touch finalShellCode
echo "{" >> keys
echo \" > finalShellCode

#Boucle
while [ $n != $lenght ]
do

#Avancement
#if [ $verbose = "0" ]
#then
#    pourcent1=$(($n*100))
#    pourcent=$(($pourcent1/$lenght)) 
#    clear
#    echo $okegreen " "
#    echo " • Traitement des données : $pourcent% \r\c"
#    echo $RESET " "
#fi

#Récupère deux premiers caractères shellcode brute, soit la première valeure hexa
hex=$(head -n 1 rawHexa | cut -c -2)

#Convertion de la valeure hexa en décimal
deci=$((0x${hex}))

#Génère nombre aléatoire entre 1 et 9 avec urandom
alea=$(grep -m1 -ao '[1-9]' /dev/urandom | sed s/0/9/ | head -n1)

#Additionne la valeur aléatoire avec le résultat de la conversion héxa
result=$(($deci + $alea))
if [ $result -ge 255 ]
then
    result=$deci
    alea=0
fi

#Stock le nombre aléatoire dans un fichier de clés
touch keys
echo $alea >> keys
if [ $n != $lenght ]
then
    echo "," >> keys
fi
	
#Suppression des sauts de lignes keys
tr -d '\n' < keys >> finalKeys
rm keys

#Conversion de la nouvelle valeur décimal en héxa + ajout dans le fichier final
finalHex=$(printf '%x\n' $result)
echo "\\x" >> finalShellCode
echo $finalHex >> finalShellCode

#Suppression des sauts de lignes output
tr -d '\n' < finalShellCode >> final
rm finalShellCode


#Supprime 2 premiers caractères de la chaine rawHexa
supp=$(cat rawHexa | cut  -b 3-)
echo $supp > rawHexa

#Incrémente compteur
n=$(($n+1))

#Verbosité activée
if [ $verbose = "1" ]
then
    echo ""
    echo "DEBUG : lenght = $lenght"
    echo "DEBUG : lenghtRaw = $lenghtRaw"
    echo "DEBUG : Boucle n°$n"
    echo "DEBUG : hex = $hex"
    echo "DEBUG : decimal = $deci"
    echo "DEBUG : aléatoire = $alea"
    echo "DEBUG : résultat addition en décimal = $result"
    echo "DEBUG : résultat addition en héxa = $finalHex"
    echo "DEBUG : résultat final =" && cat final
    echo ""
    echo "DEBUG : rawHexa =" && cat rawHexa
    echo ""
fi

#Fin Boucle
done

#Ajout synthaxe c buf[]
echo -n \" >> final
echo -n ";" >> final
sup=$(sed '$ s/.$//' finalKeys)
echo $sup > finalKeys


#Affichage final
#echo "Phase 1 en cours ..."
#echo "Nombre de caractères convertis : $lenght"
#echo "Clés de déchiffrement : "
#cat finalKeys
cp finalKeys $finalK
rm finalKeys

#DEBUG
rm rawHexa
rm rawHexaBak

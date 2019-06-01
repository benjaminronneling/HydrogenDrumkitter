@echo off 

setlocal EnableDelayedExpansion


echo This app creates drumpads from your samples to use in Hydrogen drum machine. 
echo Copy this file in the same directory that samples exist. The folder name will be the drumpads name in Hydrogen. Choose the type of files, type flac or wav. Type wav for wav-files and flac for flac-files.
  

set /p filetype=Which type of files are there in this folder? type flac or wav:
  
for %%I in (.) do set CurrDirName=%%~nxI 

set header= "<drumkit_info><name>%CurrDirName%</name><author>benji</author><info>sound</info><licence>GPL</licence><instrumentList>"
 
set result=!header:"=% %! 
echo !result! >> drumkit.xml
  
SET count=0 
 for /f "eol=: delims=" %%G in ('dir /b *.wav') DO (
 set newinstrument= "<instrument><id>!count!</id><filename>%%G</filename><name>%%~nG</name><volume>1</volume><isMuted>false</isMuted><pan_L>1</pan_L><pan_R>0.88</pan_R><exclude /></instrument>"
 
set result=!newinstrument:"=% %!
 
echo. >> drumkit.xml
echo !result! >> drumkit.xml

 set /a count+=1 )
   


set footer=  "</instrumentList></drumkit_info>" 
 
 
set result=!footer:"=% %!
 
echo !result! >> drumkit.xml



echo drumkit.xml was created successfully.  
echo Now move the whole folder to this location: C:\Users\Admin\.hydrogen\data\drumkits
echo Then open Hydrogen and the drumpad should be in Sound library (middle right of the screen).
  
pause
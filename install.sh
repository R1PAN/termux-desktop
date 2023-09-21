
#vncserver
termux-setup-storage
sleep 1
clear 
yes | pkg update
cd $HOME

pkg upgrade
pkg install wget -y
yes | pkg update
pkg upgrade
yes | pkg install x11-repo -y
yes | pkg install tur-repo -y
pkg install xfce4 tigervnc xfce4-goodies firefox -y

rm -rf .vnc
mkdir .vnc
echo -e 'xfce4-session &\nxhost + &' >> .vnc/xstartup
chmod +x .vnc/xstartup
#echo 'geometry=1050x2150' >> .vnc/config
mkdir Desktop 
mkdir Downloads 
mkdir Templates 
mkdir Public 
mkdir Documents 
mkdir Pictures 
mkdir Videos 

rm $PREFIX/bin/s &> /dev/null
rm $PREFIX/bin/p &> /dev/null
DEFr=$PREFIX/bin/p
        cat > $DEFr <<- EOF
vncserver -SecurityTypes None -localhost no &> /dev/null
list_result=\$(vncserver -list 2>&1)
if [[ "\$list_result" == *"TigerVNC server sessions:"* ]]; then
  sessions=\$(echo "\$list_result" | grep -Eo ':[0-9]+')
  for session in \$sessions; do
    echo -e "\e[1;91m[\e[32m◉\e[1;91m]\e[0m\e[1;92m localhost\$session\e[0m"
  done
else
  echo "Tidak ada sesi VNC yang berjalan."
fi
EOF


DEF=$PREFIX/bin/s
        cat > $DEF <<- EOF
list_result=\$(vncserver -list 2>&1)

# Memeriksa apakah ada sesi VNC yang sedang berjalan
if [[ "\$list_result" == *"TigerVNC server sessions:"* ]]; then
    # Menampilkan daftar sesi VNC beserta host (X DISPLAY)
    sessions=\$(echo "\$list_result" | grep -Eo ':[0-9]+' | sed 's/://')
    for session in \$sessions; do
        vncserver -kill :\$session &> /dev/null
printf "\033[1;31m☠️ Kill-LocalHost : \$session\n"
rm ~/.vnc/*\$session.log &> /dev/null
rm ~/.vnc/*\$session.pid &> /dev/null
rm -rf /data/data/com.termux/files/usr/tmp/dbus* &> /dev/null
    done
fi
        if [ -z "\$sessions" ]; then
    echo -e "\033[5;31mGa_Ada_Sesi"
fi
EOF


chmod +x $PREFIX/bin/s
chmod +x $PREFIX/bin/p

downloader(){
	path="$1"
	[[ -e "$path" ]] && rm -rf "$path"
	printf "\033[5m"
	curl --progress-bar --insecure --fail \
		 --retry-connrefused --retry 3 --retry-delay 2 \
		  --location --output ${path} "$2"
printf "\033[0m"
}
rm -rf $HOME/.config &> /dev/null
rm -rf $PREFIX/share/backgrounds &> /dev/null
rm -rf $PREFIX/share/icons &> /dev/null
rm -rf $PREFIX/share/themes &> /dev/null
downloader "backgrounds.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/backgrounds.zip"
downloader "config.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/config.zip"
downloader "icons.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/icons.zip"
downloader "themes.zip" "https://github.com/R1PAN/termux-desktop/releases/download/v1.0.0/themes.zip"
unzip -o backgrounds.zip
unzip -o config.zip
unzip -o icons.zip
unzip -o themes.zip
mv backgrounds $PREFIX/share/
mv .config $HOME/
mv icons $PREFIX/share/
mv themes $PREFIX/share/
rm -rf backgrounds.zip config.zip icons.zip themes.zip

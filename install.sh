termux-setup-storage
sleep 1
clear 
yes | pkg update
cd

pkg upgrade
pkg install wget -y
rm $PREFIX/etc/apt/sources.list.d/termux-desktop-xfce.list
wget -P $PREFIX/etc/apt/sources.list.d https://raw.githubusercontent.com/Yisus7u7/termux-desktop-xfce/gh-pages/termux-desktop-xfce.list
yes | pkg update
pkg upgrade
pkg install x11-repo -y
pkg install xfce4 tigervnc xfce4-goodies termux-desktop-xfce ttf-microsoft-cascadia pavucontrol-qt firefox -y

rm -rf .vnc
mkdir .vnc
echo -e 'xfce4-session &\nxhost + &' >> .vnc/xstartup
chmod +x .vnc/xstartup

mkdir Desktop 
mkdir Downloads 
mkdir Templates 
mkdir Public 
mkdir Documents 
mkdir Pictures 
mkdir Videos 
wget https://github.com/R1PAN/termux-desktop/raw/r/con.zip

unzip -o con.zip

rm $PREFIX/bin/s &> /dev/null
rm $PREFIX/bin/p &> /dev/null
echo "vncserver" > $PREFIX/bin/p
echo -e 'printf "\033[5;31mokeh🙋\\n"\nvncserver -kill :1 &> /dev/null\nvncserver -kill :2 &> /dev/null\nrm ~/.vnc/*.log &> /dev/null\nrm ~/.vnc/*.pid &> /dev/null' >> $PREFIX/bin/s
chmod +x $PREFIX/bin/s
chmod +x $PREFIX/bin/p


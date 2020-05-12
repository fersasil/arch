if [[ -z ${1+x} ]]; 
then #not set, so read the input from user
    printf "Digite: \n[0] - instalar i3\n[1] - instalar xfce4: "
    read op
    echo "Digite o nome do usuário"
    read user
else #get from arguments
    op=$1
    user=$2
fi

install_i3() {
    pacman -Sy i3 i3blocks polybar --noconfirm
    mkdir ~/.config/polybar/
    
    printf "#!/bin/bash

    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    # Launch Polybar, using default config location ~/.config/polybar/config
    polybar mybar &

    echo "Polybar launched..."
    " > ~/.config/polybar/launch.sh

    echo "exec_always --no-startup-id $HOME/.config/polybar/launch.sh"

    fc-cache -fv    
    i3-msg restart
}


sudo pacman -Sy go lightdm git --noconfirm

# mkdir tmp
# chmod 777 -R /arch
# cd tmp/yay

# git clone https://aur.archlinux.org/yay.git

su $user -c "cd;git clone https://aur.archlinux.org/yay.git;cd yay;makepkg"

cd /home/g/yay

for i in $(ls); 
do 
if [[ $i == *"yay"* ]]; then
    if [[ $i == *"pkg"* ]]; then
        yay="$i"
    fi
fi
done; 

pacman -U $yay --noconfirm

cd .. 
rm -rf yay
cd /arch

su $user -c "k1k2k3k4 | yay -S google-chrome"


# git clone https://aur.archlinux.org/lightdm-webkit-theme-aether

# # su $user << END
# cd lightdm-webkit-theme-aether
# # echo k1k2k3k4 | sudo makepkg -si --noconfirm
# # cd ..
# exit

# END


# cd /.cache/trizen/some-package && makepkg -i



rm -rf lightdm-webkit-theme-aether

sudo sed -i -e 's/greeter-session=/greeter-session=lightdm-webkit-theme-aether/g' /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm.service

# if [[ "$op" = "0" ]]
# then 
# fi
install_i3()
# elif [[ "$op" = "1" ]]

printf "Digite: \n[0] - instalar i3\n[1] - instalar xfce4: "
read op

install_i3() {
    pacman -S i3 i3blocks polybar --noconfirm
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


sudo pacman -S lightdm git --noconfirm
git clone https://aur.archlinux.org/lightdm-webkit-theme-aether
cd (cd lightdm-webkit-theme-aether && sudo makepkg -si --noconfirm)

sudo sed -i -e 's/greeter-session=/greeter-session=lightdm-webkit-theme-aether/g' /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm.service

if [$op = "0"]
then
    install_i3()
elif [$op = "1"]
then


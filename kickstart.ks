# Minimal Disk Image
#
# Firewall configuration
firewall --enabled
# Use network installation
url --url="http://dl.fedoraproject.org/pub/fedora/linux/releases/30/Everything/x86_64/os/"
# Network information
network  --bootproto=dhcp --device=link --activate

selinux --enforcing
# System keyboard
keyboard --xlayouts=gb --vckeymap=gb
# System language
lang en_GB.UTF-8
# SELinux configuration
selinux --enforcing
# Installation logging level
logging --level=info
# Shutdown after installation
shutdown
# System timezone
timezone  US/Eastern
# System bootloader configuration
bootloader --location=mbr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
autopart

xconfig --defaultdesktop=i3

%post
# Remove root password
passwd -d root > /dev/null

# Remove random-seed
rm /var/lib/systemd/random-seed

echo "FoxOS 1" > /etc/fedora-release
echo "NAME=FoxOS
VERSION=\"1\"
ID=FoxOS
VERSION_ID=1
VERSION_CODENAME=\"\"
PLATFORM_ID=\"platform:f1\"
PRETTY_NAME=\"FoxOS 1\"
ANSI_COLOR=\"0;34\"" > /etc/os.release.d/os-release-fedora

echo "Welcome to FoxOS 1" > /root/welcomehome

# Setup i3
echo "[gregw-i3desktop]
name=Copr repo for i3desktop owned by gregw
baseurl=https://copr-be.cloud.fedoraproject.org/results/gregw/i3desktop/fedora-30-x86_64/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/gregw/i3desktop/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1" > /etc/yum.repos.d/copr.repo

dnf install -y --allowerasing i3-gaps

echo "[Greeter]
theme-name=Adwaita-dark
icon-theme-name=Adwaita
background=/usr/share/backgrounds/default.png" > /etc/lightdm/slick-greeter.conf

git clone https://github.com/pnfox/lab-configs.git /tmp/custom-configs
cd /tmp/custom-configs
./setup.sh --global

for d in $(ls -d /home/*); do
if [ $d = "/home/lost+found" ]
then
    continue
fi
echo "[xin_-1]
file=/usr/share/backgrounds/default.png
mode=0
bgcolor=#000000" > $d/.config/nitrogen/bg-saved.png
done


%end

%packages --timeout=120 --retries=20
@base-x
@system-tools
@core
authconfig
system-config-firewall-base
@Standard
@Fonts
@hardware-support
kernel
# Make sure that DNF doesn't pull in debug kernel to satisfy kmod() requires
kernel-modules
kernel-modules-extra

memtest86+
grub2-efi
grub2
shim
syslinux
-dracut-config-rescue
python3
git

# dracut needs these included
dracut-network
tar

# applications
rxvt-unicode
sakura
firefox
vi
git
htop
screenfetch
nitrogen
lxappearance
lightdm-settings
adwaita-gtk2-theme
adwaita-icon-theme
papirus-icon-theme
conky
compton
tint2
dunst

-openbox
-awesome
-ratpoison
-qtile

%end

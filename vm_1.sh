sudo sed -i '10c\GRUB_CMDLINE_LINUX_DEFAULT="modprobe.blacklist=btrfs mem_encrypt=on kvm_amd.sev=1"' /etc/default/grub
sudo update-grub
sudo reboot
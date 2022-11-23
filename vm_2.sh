sudo apt update
sudo apt install libvirt-daemon-system virtinst qemu-utils cloud-image-utils
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qemu-img resize focal-server-cloudimg-amd64.img 40G
sudo qemu-img convert focal-server-cloudimg-amd64.img /var/lib/libvirt/images/sev-guest.img

cat >cloud-config <<EOF
#cloud-config

password: 1234
chpasswd: { expire: False }
ssh_pwauth: False
EOF

sudo cloud-localds /var/lib/libvirt/images/sev-guest-cloud-config.iso cloud-config

sudo virt-install \
              --name sev-guest \
              --memory 4096 \
              --memtune hard_limit=4563402 \
              --boot uefi \
              --disk /var/lib/libvirt/images/sev-guest.img,device=disk,bus=scsi \
              --disk /var/lib/libvirt/images/sev-guest-cloud-config.iso,device=cdrom \
              --os-type linux \
              --os-variant ubuntu20.04 \
              --import \
              --controller type=scsi,model=virtio-scsi,driver.iommu=on \
              --controller type=virtio-serial,driver.iommu=on \
              --network network=default,model=virtio,driver.iommu=on \
              --memballoon driver.iommu=on \
              --graphics none \
              --launchSecurity sev
#!/bin/sh

# install: qemu virt-manager libvirt ebtables dnsmasq bridge-utils

# sudo systemctl start libvirtd
# sudo systemctl start dnsmasq

# /etc/network/interfaces
# auto eth0
# iface eth0 inet dhcp
# sudo systemctl restart networking

# iptables -N VM_NETWORK
# iptables -A VM_NETWORK -i virbr0 -j DROP
# iptables -A VM_NETWORK -o virbr0 -j DROP
# iptables -I INPUT -j VM_NETWORK
# iptables -I FORWARD -j VM_NETWORK
# iptables -I OUTPUT -j VM_NETWORK

vm_name="vmtmp"

vm_image_path="<path>/*.(qcow2,iso)"

vm_memory="4096"

vm_cpus="5"

if ! id -nG "$(id -un)" | grep -qw "libvirt"; then
  echo "sudo usermod -aG libvirt $(whoami)"
  exit 1
fi

start_vm() {
  if ! virsh list --all | grep -q "$vm_name"; then
    echo "Starting: $vm_name"

    sudo ip link add name br0 type bridge
    sudo ip link set enp0s3 master br0

    sudo systemctl stop dhcpcd.service
    sudo systemctl disable dhcpcd.service
    sudo systemctl enable systemd-networkd.service
    sudo systemctl start systemd-networkd.service
    sudo systemctl enable systemd-resolved.service
    sudo systemctl start systemd-resolved.service
    sudo systemctl restart libvirtd

    virsh net-define <(echo "<network><name>vm_network</name><bridge name='virbr0'/></network>")
    virsh net-start vm_network

    virt-install \
      --name "$vm_name" \
      --ram "$vm_memory" \
      --vcpus "$vm_cpus" \
      --os-type linux \
      --os-variant debian10 \
      --network network=vm_network,mac=52:54:00:00:01:01 \
      --graphics none \
      --video qxl \
      --console pty,target_type=serial \
      --import \
      --cdrom $vm_image_path \ # enable for ISO boot
      --boot cdrom \ # enable for ISO boot
      #--disk "$vm_image_path" # enable for qcow2 boot
  else
    echo "The $vm_name exists. Starting...."
    virsh start "$vm_name"
  fi
}

shutdown_vm() {
  virsh shutdown "$vm_name"
}

list_vms() {
  virsh list --all
}

get_vm_status() {
  virsh dominfo "$vm_name" | grep State
}

remove_network() {
  virsh net-destroy vm_network
  virsh net-undefine vm_network
}

delete_vm() {
  virsh destroy "$vm_name"
  virsh undefine "$vm_name"
  remove_network
  rm -rf $vm_image_path
}

if [ "$#" -ne 1 ]; then
  echo "Use: $0 {start|shutdown|list|status|delete}"
  exit 1
fi

case $1 in
  start)
    start_vm
    ;;
  shutdown)
    shutdown_vm
    ;;
  list)
    list_vms
    ;;
  status)
    get_vm_status
    ;;
  delete)
    delete_vm
    ;;
  *)
    echo "Invalid action. Use 'start', 'shutdown', 'list', 'status' or 'delete'."
    exit 1
    ;;
esac

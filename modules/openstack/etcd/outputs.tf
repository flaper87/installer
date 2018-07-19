output "ip_addresses" {
  value = "${openstack_instance.etcd_node.*.private_ip}"
}

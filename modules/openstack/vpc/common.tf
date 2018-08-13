locals {
  worker_subnet_ids   = ["${coalescelist(openstack_networking_port_v2.workers.*.id,var.external_worker_subnet_ids)}"]
  master_subnet_ids   = ["${coalescelist(openstack_networking_port_v2.masters.*.id,var.external_master_subnet_ids)}"]
  etcd_subnet_ids     = ["${openstack_networking_port_v2.etcds.*.id}"]

  master_port_ips     = ["${flatten(openstack_networking_port_v2.masters.*.all_fixed_ips)}"]
  worker_port_ips     = ["${flatten(openstack_networking_port_v2.workers.*.all_fixed_ips)}"]
  etcd_port_ips       = ["${flatten(openstack_networking_port_v2.etcds.*.all_fixed_ips)}"]
}

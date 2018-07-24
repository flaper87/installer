locals {
  worker_subnet_ids   = ["${coalescelist(openstack_networking_port_v2.workers.*.id,var.external_worker_subnet_ids)}"]
  master_subnet_ids   = ["${coalescelist(openstack_networking_port_v2.masters.*.id,var.external_master_subnet_ids)}"]
  etcd_subnet_ids     = ["${openstack_networking_port_v2.etcds.*.id}"]
}

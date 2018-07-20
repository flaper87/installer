output "openstack_compute_instance_v2" {
  value = "${openstack_compute_instance_v2.etcd_conf.*.id}"
}

output "subnet_ids" {
  value = "${var.subnet_ids}"
}

output "openstack_lbs" {
  value = "${var.openstack_lbs}"
}

output "cluster_id" {
  value = "${var.cluster_id}"
}

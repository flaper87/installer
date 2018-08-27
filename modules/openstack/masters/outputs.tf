output "cluster_id" {
  value = "${var.cluster_id}"
}

output "openstack_compute_instance_v2" {
  value = "${openstack_compute_instance_v2.master_conf.*.id}"
}

output "openstack_lbs" {
  value = "${var.openstack_lbs}"
}

output "subnet_ids" {
  value = "${var.subnet_ids}"
}

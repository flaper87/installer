output "cluster_id" {
  value = "${var.cluster_id}"
}

output "openstack_compute_instance_v2" {
  value = "${openstack_compute_instance_v2.worker_conf.*.id}"
}

output "subnet_ids" {
  value = "${var.subnet_ids}"
}

//output "etcd_sg_id" {
//  value = "${element(concat(openstack_networking_secgroup_v2.etcd.*.id, list("")), 0)}"
//}

output "master_sg_id" {
  value = "${openstack_networking_secgroup_v2.master.id}"
}

output "worker_sg_id" {
  value = "${openstack_networking_secgroup_v2.worker.id}"
}

output "api_sg_id" {
  value = "${openstack_networking_secgroup_v2.api.id}"
}

output "console_sg_id" {
  value = "${openstack_networking_secgroup_v2.console.id}"
}

output "master_subnet_ids" {
  value = "${local.master_subnet_ids}"
}

output "worker_subnet_ids" {
  value = "${local.worker_subnet_ids}"
}

output "etcd_subnet_ids" {
  value = "${local.etcd_subnet_ids}"
}

output "master_port_ips" {
  value = "${local.master_port_ips}"
}

output "worker_port_ips" {
  value = "${local.worker_port_ips}"
}

output "etcd_port_ips" {
  value = "${local.etcd_port_ips}"
}

output "master_internal_lb_ip" {
  value = "${local.new_master_lb_ip}"
}

/*
# We have to do this join() & split() 'trick' because null_data_source and
# the ternary operator can't output lists or maps
output "master_subnet_ids" {
  value = "${local.master_subnet_ids}"
}

output "worker_subnet_ids" {
  value = "${local.worker_subnet_ids}"
}


output "openstack_elb_api_external_id" {
  value = "${openstack_elb.api_external.*.id}"
}

output "openstack_elb_internal_id" {
  value = "${openstack_elb.api_internal.*.id}"
}

output "openstack_elb_console_id" {
  value = "${openstack_elb.console.id}"
}

output "openstack_lbs" {
  value = ["${compact(concat(openstack_elb.api_internal.*.id, list(openstack_elb.console.id), openstack_elb.api_external.*.id, openstack_elb.tnc.*.id))}"]
}

output "openstack_api_external_dns_name" {
  value = "${element(concat(openstack_elb.api_external.*.dns_name, list("")), 0)}"
}

output "openstack_elb_api_external_zone_id" {
  value = "${element(concat(openstack_elb.api_external.*.zone_id, list("")), 0)}"
}

output "openstack_api_internal_dns_name" {
  value = "${element(concat(openstack_elb.api_internal.*.dns_name, list("")), 0)}"
}

output "openstack_elb_api_internal_zone_id" {
  value = "${element(concat(openstack_elb.api_internal.*.zone_id, list("")), 0)}"
}

output "openstack_console_dns_name" {
  value = "${openstack_elb.console.dns_name}"
}

output "openstack_elb_console_zone_id" {
  value = "${openstack_elb.console.zone_id}"
}

output "openstack_elb_tnc_dns_name" {
  value = "${element(concat(openstack_elb.tnc.*.dns_name, list("")), 0)}"
}

output "openstack_elb_tnc_zone_id" {
  value = "${element(concat(openstack_elb.tnc.*.zone_id, list("")), 0)}"
}*/

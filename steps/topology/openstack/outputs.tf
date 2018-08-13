// Mock values for now
output "openstack_lbs" {
  value = []
}

output "master_sg_id" {
  value = "default"
}

output "subnet_ids_masters" {
  value = "${data.terraform_remote_state.assets.subnet_ids_masters}"
}

# Etcd
output "subnet_ids_etcd" {
  value = "${data.terraform_remote_state.assets.subnet_ids_etcd}"
}

output "etcd_sg_id" {
  value = "default"
}

# Workers
output "subnet_ids_workers" {
  value = "${data.terraform_remote_state.assets.subnet_ids_workers}"
}

output "worker_sg_id" {
  value = "default"
}

output "ignition_bootstrap" {
  value = "${data.ignition_config.bootstrap.rendered}"
}

/*# Etcd
output "etcd_sg_id" {
  value = "${module.vpc.etcd_sg_id}"
}

# Masters
output "subnet_ids_masters" {
  value = "${data.terraform_remote_state.assets.master_subnet_id}"
}

output "aws_lbs" {
  value = "${module.vpc.aws_lbs}"
}

output "master_sg_id" {
  value = "${module.vpc.master_sg_id}"
}

# Workers
output "subnet_ids_workers" {
  value = "${module.vpc.worker_subnet_ids}"
}

output "worker_sg_id" {
  value = "${module.vpc.worker_sg_id}"
}

# TNC
output "private_zone_id" {
  value = "${join("", aws_route53_zone.tectonic_int.*.zone_id)}"
}

output "tnc_elb_dns_name" {
  value = "${module.vpc.aws_elb_tnc_dns_name}"
}

output "tnc_elb_zone_id" {
  value = "${module.vpc.aws_elb_tnc_zone_id}"
}

output "tnc_s3_bucket_domain_name" {
  value = "${aws_s3_bucket.tectonic.bucket_domain_name}"
}*/

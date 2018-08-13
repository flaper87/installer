output "ignition_bootstrap" {
  value = "${data.ignition_config.bootstrap.rendered}"
}

output "ignition_etcd" {
  value = "${module.assets_base.ignition_etcd}"
}

output "subnet_ids_masters" {
  value = "${module.vpc.master_subnet_ids}"
}

# Etcd
output "subnet_ids_etcd" {
  value = "${module.vpc.etcd_subnet_ids}"
}

# Workers
output "subnet_ids_workers" {
  value = "${module.vpc.worker_subnet_ids}"
}

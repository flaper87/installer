provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  profile = "${var.tectonic_openstack_profile}"
  version = "1.6.0"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "workers" {
  source = "../../../modules/openstack/worker-asg"

  cluster_id                   = "${var.tectonic_cluster_id}"
  cluster_name                 = "${var.tectonic_cluster_name}"
  container_linux_channel      = "${var.tectonic_container_linux_channel}"
  container_linux_version      = "${module.container_linux.version}"
  flavor_name                  = "${var.tectonic_openstack_worker_flavor_name}"
  extra_tags                   = "${var.tectonic_openstack_extra_tags}"
  instance_count               = "${var.tectonic_worker_count}"
  load_balancers               = "${var.tectonic_openstack_worker_load_balancers}"
  root_volume_iops             = "${var.tectonic_openstack_worker_root_volume_iops}"
  root_volume_size             = "${var.tectonic_openstack_worker_root_volume_size}"
  root_volume_type             = "${var.tectonic_openstack_worker_root_volume_type}"
  sg_ids                       = "${concat(var.tectonic_openstack_worker_extra_sg_ids, list(local.sg_id))}"
  ssh_key                      = "${var.tectonic_openstack_ssh_key}"
  subnet_ids                   = "${local.subnet_ids}"
  worker_iam_role              = "${var.tectonic_openstack_worker_iam_role_name}"
  base_domain                  = "${var.tectonic_base_domain}"
  user_data_ign                = "${file("${path.cwd}/${var.tectonic_ignition_worker}")}"
}

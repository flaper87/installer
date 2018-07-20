locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  version = "1.6.0"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "workers" {
  source = "../../../modules/openstack/worker-asg"

  base_domain                  = "${var.tectonic_base_domain}"
  base_image                   = "${var.tectonic_openstack_base_image}"
  cluster_id                   = "${var.tectonic_cluster_id}"
  cluster_name                 = "${var.tectonic_cluster_name}"
  container_images             = "${var.tectonic_container_images}"
  flavor_name                  = "${var.tectonic_openstack_worker_flavor_name}"
  extra_tags                   = "${var.tectonic_openstack_extra_tags}"
  instance_count               = "${var.tectonic_worker_count}"
  worker_sg_ids                = "${concat(var.tectonic_openstack_worker_extra_sg_ids, list(local.sg_id))}"
  private_endpoints            = "${local.private_endpoints}"
  public_endpoints             = "${local.public_endpoints}"
  root_volume_iops             = "${var.tectonic_openstack_worker_root_volume_iops}"
  root_volume_size             = "${var.tectonic_openstack_worker_root_volume_size}"
  root_volume_type             = "${var.tectonic_openstack_worker_root_volume_type}"
  ssh_key                      = "${var.tectonic_openstack_ssh_key}"
  subnet_ids                   = "${local.subnet_ids}"
  user_data_ign                = "${file("${path.cwd}/${var.tectonic_ignition_worker}")}"
}

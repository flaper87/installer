locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "masters" {
  source = "../../../modules/openstack/masters"

  base_domain       = "${var.tectonic_base_domain}"
  base_image        = "${var.tectonic_openstack_base_image}"
  cluster_id        = "${var.tectonic_cluster_id}"
  cluster_name      = "${var.tectonic_cluster_name}"
  container_images  = "${var.tectonic_container_images}"
  extra_tags        = "${var.tectonic_openstack_extra_tags}"
  flavor_name       = "${var.tectonic_openstack_master_flavor_name}"
  instance_count    = "${var.tectonic_bootstrap == "true" ? 1 : var.tectonic_master_count}"
  key_pair            = "${var.tectonic_openstack_key_pair}"
  master_sg_ids     = "${concat(var.tectonic_openstack_master_extra_sg_ids, list(local.sg_id))}"
  openstack_lbs     = "${local.openstack_lbs}"
  private_endpoints = "${local.private_endpoints}"
  public_endpoints  = "${local.public_endpoints}"
  root_volume_iops  = "${var.tectonic_openstack_master_root_volume_iops}"
  root_volume_size  = "${var.tectonic_openstack_master_root_volume_size}"
  root_volume_type  = "${var.tectonic_openstack_master_root_volume_type}"
  subnet_ids        = "${local.subnet_ids}"
  user_data_ign     = "${local.ignition_bootstrap}"
}

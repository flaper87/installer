locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  version = ">=1.6.0"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "workers" {
  source = "../../../modules/openstack/workers"

  auth_url            = "${var.tectonic_openstack_credentials_auth_url}"
  base_domain         = "${var.tectonic_base_domain}"
  base_image          = "${var.tectonic_openstack_base_image}"
  cacert_file         = "${var.tectonic_openstack_credentials_cacert_file}"
  cert                = "${var.tectonic_openstack_credentials_cert}"
  cloud               = "${var.tectonic_openstack_credentials_cloud}"
  cluster_id          = "${var.tectonic_cluster_id}"
  cluster_name        = "${var.tectonic_cluster_name}"
  container_images    = "${var.tectonic_container_images}"
  domain_id           = "${var.tectonic_openstack_credentials_domain_id}"
  domain_name         = "${var.tectonic_openstack_credentials_domain_name}"
  endpoint_type       = "${var.tectonic_openstack_credentials_endpoint_type}"
  extra_tags          = "${var.tectonic_openstack_extra_tags}"
  flavor_name         = "${var.tectonic_openstack_worker_flavor_name}"
  insecure            = "${var.tectonic_openstack_credentials_insecure}"
  instance_count      = "${var.tectonic_worker_count}"
  key                 = "${var.tectonic_openstack_credentials_key}"
  key_pair            = "${var.tectonic_openstack_key_pair}"
  password            = "${var.tectonic_openstack_credentials_password}"
  private_endpoints   = "${local.private_endpoints}"
  project_domain_id   = "${var.tectonic_openstack_credentials_project_domain_id}"
  project_domain_name = "${var.tectonic_openstack_credentials_project_domain_name}"
  public_endpoints    = "${local.public_endpoints}"
  region              = "${var.tectonic_openstack_credentials_region}"
  root_volume_iops    = "${var.tectonic_openstack_worker_root_volume_iops}"
  root_volume_size    = "${var.tectonic_openstack_worker_root_volume_size}"
  root_volume_type    = "${var.tectonic_openstack_worker_root_volume_type}"
  subnet_ids          = "${local.subnet_ids}"
  swauth              = "${var.tectonic_openstack_credentials_swauth}"
  tenant_id           = "${var.tectonic_openstack_credentials_tenant_id}"
  tenant_name         = "${var.tectonic_openstack_credentials_tenant_name}"
  token               = "${var.tectonic_openstack_credentials_token}"
  use_octavia         = "${var.tectonic_openstack_credentials_use_octavia}"
  #user_data_ign       = "${file("${path.cwd}/${var.tectonic_ignition_worker}")}"
  user_data_ign       = "${local.ignition_bootstrap}"
  user_domain_id      = "${var.tectonic_openstack_credentials_user_domain_id}"
  user_domain_name    = "${var.tectonic_openstack_credentials_user_domain_name}"
  user_id             = "${var.tectonic_openstack_credentials_user_id}"
  user_name           = "${var.tectonic_openstack_credentials_user_name}"
  worker_sg_ids       = "${concat(var.tectonic_openstack_worker_extra_sg_ids, list(local.sg_id))}"
}

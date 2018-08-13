locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

module "vpc" {
  source = "../../../modules/openstack/vpc"

  auth_url = "${var.tectonic_openstack_credentials_auth_url}"
  cloud = "${var.tectonic_openstack_credentials_cloud}"
  region = "${var.tectonic_openstack_credentials_region}"
  user_name = "${var.tectonic_openstack_credentials_user_name}"
  user_id = "${var.tectonic_openstack_credentials_user_id}"
  tenant_id = "${var.tectonic_openstack_credentials_tenant_id}"
  tenant_name = "${var.tectonic_openstack_credentials_tenant_name}"
  password = "${var.tectonic_openstack_credentials_password}"
  token = "${var.tectonic_openstack_credentials_token}"
  user_domain_name = "${var.tectonic_openstack_credentials_user_domain_name}"
  user_domain_id = "${var.tectonic_openstack_credentials_user_domain_id}"
  project_domain_name = "${var.tectonic_openstack_credentials_project_domain_name}"
  project_domain_id = "${var.tectonic_openstack_credentials_project_domain_id}"
  domain_id = "${var.tectonic_openstack_credentials_domain_id}"
  domain_name = "${var.tectonic_openstack_credentials_domain_name}"
  insecure = "${var.tectonic_openstack_credentials_insecure}"
  cacert_file = "${var.tectonic_openstack_credentials_cacert_file}"
  cert = "${var.tectonic_openstack_credentials_cert}"
  key = "${var.tectonic_openstack_credentials_key}"
  endpoint_type = "${var.tectonic_openstack_credentials_endpoint_type}"
  swauth = "${var.tectonic_openstack_credentials_swauth}"
  use_octavia = "${var.tectonic_openstack_credentials_use_octavia}"

  base_domain     = "${var.tectonic_base_domain}"
  cidr_block      = "${var.tectonic_openstack_vpc_cidr_block}"
  cluster_id      = "${var.tectonic_cluster_id}"
  cluster_name    = "${var.tectonic_cluster_name}"
  external_vpc_id = "${var.tectonic_openstack_external_vpc_id}"

  masters_count   = "${var.tectonic_master_count}"
  workers_count   = "${var.tectonic_worker_count}"
  etcd_count      = "${var.tectonic_etcd_count}"

  external_master_subnet_ids = "${compact(var.tectonic_openstack_external_master_subnet_ids)}"
  external_worker_subnet_ids = "${compact(var.tectonic_openstack_external_worker_subnet_ids)}"
  extra_tags                 = "${var.tectonic_openstack_extra_tags}"

  // empty map subnet_configs will have the vpc module creating subnets in all availabile AZs
  new_master_subnet_configs = "${var.tectonic_openstack_master_custom_subnets}"
  new_worker_subnet_configs = "${var.tectonic_openstack_worker_custom_subnets}"

  private_master_endpoints = "${local.private_endpoints}"
  public_master_endpoints  = "${local.public_endpoints}"
}

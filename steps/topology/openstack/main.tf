locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  version = ">=1.6.0"

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
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
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

/*
# TNC
resource "openstack_route53_zone" "tectonic_int" {
  count         = "${local.private_endpoints ? "${var.tectonic_openstack_external_private_zone == "" ? 1 : 0 }" : 0}"
  vpc_id        = "${module.vpc.vpc_id}"
  name          = "${var.tectonic_base_domain}"
  force_destroy = true

  tags = "${merge(map(
      "Name", "${var.tectonic_cluster_name}_tectonic_int",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}


module "dns" {
  source = "../../../modules/dns/route53"

  api_external_elb_dns_name = "${module.vpc.openstack_api_external_dns_name}"
  api_external_elb_zone_id  = "${module.vpc.openstack_elb_api_external_zone_id}"
  api_internal_elb_dns_name = "${module.vpc.openstack_api_internal_dns_name}"
  api_internal_elb_zone_id  = "${module.vpc.openstack_elb_api_internal_zone_id}"
  api_ip_addresses          = "${module.vpc.openstack_lbs}"
  base_domain               = "${var.tectonic_base_domain}"
  cluster_id                = "${var.tectonic_cluster_id}"
  cluster_name              = "${var.tectonic_cluster_name}"
  console_elb_dns_name      = "${module.vpc.openstack_console_dns_name}"
  console_elb_zone_id       = "${module.vpc.openstack_elb_console_zone_id}"
  elb_alias_enabled         = true
  master_count              = "${var.tectonic_master_count}"
  private_zone_id           = "${var.tectonic_openstack_external_private_zone != "" ? var.tectonic_openstack_external_private_zone : join("", openstack_route53_zone.tectonic_int.*.zone_id)}"
  external_vpc_id           = "${module.vpc.vpc_id}"
  extra_tags                = "${var.tectonic_openstack_extra_tags}"
  private_endpoints         = "${local.private_endpoints}"
  public_endpoints          = "${local.public_endpoints}"
}*/

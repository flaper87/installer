locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "vpc" {
  source = "../../../modules/openstack/topology"

  base_domain                = "${var.tectonic_base_domain}"
  cidr_block                 = "${var.tectonic_openstack_vpc_cidr_block}"
  cluster_id                 = "${var.tectonic_cluster_id}"
  cluster_name               = "${var.tectonic_cluster_name}"
  etcd_count                 = "${var.tectonic_etcd_count}"
  external_master_subnet_ids = "${compact(var.tectonic_openstack_external_master_subnet_ids)}"
  external_network           = "${var.tectonic_openstack_external_network}"
  external_vpc_id            = "${var.tectonic_openstack_external_vpc_id}"
  external_worker_subnet_ids = "${compact(var.tectonic_openstack_external_worker_subnet_ids)}"
  extra_tags                 = "${var.tectonic_openstack_extra_tags}"
  masters_count              = "${var.tectonic_master_count}"

  // empty map subnet_configs will have the vpc module creating subnets in all availabile AZs
  new_master_subnet_configs = "${var.tectonic_openstack_master_custom_subnets}"
  new_worker_subnet_configs = "${var.tectonic_openstack_worker_custom_subnets}"
  private_master_endpoints  = "${local.private_endpoints}"
  public_master_endpoints   = "${local.public_endpoints}"
  workers_count             = "${var.tectonic_worker_count}"
}

/*
# TNC
resource "openstack_route53_zone" "tectonic_int" {
  count         = "${local.private_endpoints ? "${var.tectonic_openstack_external_private_zone == "" ? 1 : 0 }" : 0}"
  name          = "${var.tectonic_base_domain}"

  force_destroy = true
  vpc_id        = "${module.vpc.vpc_id}"

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
  external_vpc_id           = "${module.vpc.vpc_id}"
  extra_tags                = "${var.tectonic_openstack_extra_tags}"
  master_count              = "${var.tectonic_master_count}"
  private_endpoints         = "${local.private_endpoints}"
  private_zone_id           = "${var.tectonic_openstack_external_private_zone != "" ? var.tectonic_openstack_external_private_zone : join("", openstack_route53_zone.tectonic_int.*.zone_id)}"
  public_endpoints          = "${local.public_endpoints}"
}*/


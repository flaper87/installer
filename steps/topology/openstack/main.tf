locals {
  private_endpoints = "${var.tectonic_openstack_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_openstack_endpoints == "private" ? false : true}"
}


module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
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

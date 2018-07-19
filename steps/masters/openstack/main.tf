locals {
  private_endpoints = "${var.tectonic_aws_endpoints == "public" ? false : true}"
  public_endpoints  = "${var.tectonic_aws_endpoints == "private" ? false : true}"
}

provider "openstack" {
  region  = "${var.tectonic_openstack_region}"
  version = "1.8.0"
}

module "container_linux" {
  source = "../../../modules/container_linux"

  release_channel = "${var.tectonic_container_linux_channel}"
  release_version = "${var.tectonic_container_linux_version}"
}

module "masters" {
  source = "../../../modules/openstack/master-asg"
}

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

/* TODO(shadower): use this instead of the simplified version below once we handle AZS:
data "aws_availability_zones" "azs" {}

data "template_file" "etcd_hostname_list" {
  count    = "${var.tectonic_etcd_count > 0 ? var.tectonic_etcd_count : length(data.aws_availability_zones.azs.names) == 5 ? 5 : 3}"
  template = "${var.tectonic_cluster_name}-etcd-${count.index}.${var.tectonic_base_domain}"
}

*/

data "template_file" "etcd_hostname_list" {
  count    = "${var.tectonic_etcd_count}"
  template = "${var.tectonic_cluster_name}-etcd-${count.index}.${var.tectonic_base_domain}"
}


/* TODO(shadower): figure out what is AWS using S3 for here and add the same
(possibly with Swift) if needed. Note that Swift may not be available in all
OpenStack deployments though.

resource "aws_s3_bucket_object" "ignition_etcd" {
  count   = "${length(data.template_file.etcd_hostname_list.*.id)}"
  bucket  = "${local.s3_bucket}"
  key     = "ignition_etcd_${count.index}.json"
  content = "${local.ignition[count.index]}"
  acl     = "private"

  server_side_encryption = "AES256"

  tags = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-etcd-${count.index}",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_aws_extra_tags)}"
}
*/


module "etcd" {
  source = "../../../modules/openstack/etcd"

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

  openstack_lbs                = "${local.openstack_lbs}"
  base_domain                  = "${var.tectonic_base_domain}"
  base_image                   = "${var.tectonic_openstack_base_image}"
  cluster_id                   = "${var.tectonic_cluster_id}"
  cluster_name                 = "${var.tectonic_cluster_name}"
  container_images             = "${var.tectonic_container_images}"
  flavor_name                  = "${var.tectonic_openstack_etcd_flavor_name}"
  extra_tags                   = "${var.tectonic_openstack_extra_tags}"
  instance_count               = "${length(data.template_file.etcd_hostname_list.*.id)}"
  etcd_sg_ids                  = "${concat(var.tectonic_openstack_etcd_extra_sg_ids, list(local.sg_id))}"
  private_endpoints            = "${local.private_endpoints}"
  public_endpoints             = "${local.public_endpoints}"
  root_volume_iops             = "${var.tectonic_openstack_etcd_root_volume_iops}"
  root_volume_size             = "${var.tectonic_openstack_etcd_root_volume_size}"
  root_volume_type             = "${var.tectonic_openstack_etcd_root_volume_type}"
  ssh_key                      = "${var.tectonic_openstack_ssh_key}"
  subnet_ids                   = "${local.subnet_ids}"
  user_data_ign                = "${file("${path.cwd}/${var.tectonic_ignition_etcd}")}"
}

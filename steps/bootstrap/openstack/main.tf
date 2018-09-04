locals {
  private_endpoints = "${var.tectonic_openstack_endpoints != "public"}"
  public_endpoints  = "${var.tectonic_openstack_endpoints != "private"}"
}

provider "openstack" {
  auth_url            = "${var.tectonic_openstack_credentials_auth_url}"
  cacert_file         = "${var.tectonic_openstack_credentials_cacert_file}"
  cert                = "${var.tectonic_openstack_credentials_cert}"
  cloud               = "${var.tectonic_openstack_credentials_cloud}"
  domain_id           = "${var.tectonic_openstack_credentials_domain_id}"
  domain_name         = "${var.tectonic_openstack_credentials_domain_name}"
  endpoint_type       = "${var.tectonic_openstack_credentials_endpoint_type}"
  insecure            = "${var.tectonic_openstack_credentials_insecure}"
  key                 = "${var.tectonic_openstack_credentials_key}"
  password            = "${var.tectonic_openstack_credentials_password}"
  project_domain_id   = "${var.tectonic_openstack_credentials_project_domain_id}"
  project_domain_name = "${var.tectonic_openstack_credentials_project_domain_name}"
  region              = "${var.tectonic_openstack_region}"
  region              = "${var.tectonic_openstack_credentials_region}"
  swauth              = "${var.tectonic_openstack_credentials_swauth}"
  tenant_id           = "${var.tectonic_openstack_credentials_tenant_id}"
  tenant_name         = "${var.tectonic_openstack_credentials_tenant_name}"
  token               = "${var.tectonic_openstack_credentials_token}"
  use_octavia         = "${var.tectonic_openstack_credentials_use_octavia}"
  user_domain_id      = "${var.tectonic_openstack_credentials_user_domain_id}"
  user_domain_name    = "${var.tectonic_openstack_credentials_user_domain_name}"
  user_id             = "${var.tectonic_openstack_credentials_user_id}"
  user_name           = "${var.tectonic_openstack_credentials_user_name}"
  version             = ">=1.6.0"
}

# The public ignition object.
resource "openstack_objectstorage_object_v1" "ignition_bootstrap" {
  container_name = "${local.swift_container}"
  name           = "bootstrap.ign"

  content = "${local.ignition_bootstrap}"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

resource "openstack_objectstorage_tempurl_v1" "bootstrap_tmpurl" {
  container = "${local.swift_container}"
  method    = "get"
  object    = "${openstack_objectstorage_object_v1.ignition_bootstrap.name}"
  ttl       = 3600
}

# The public ignition configuration
data "ignition_config" "bootstrap_redirect" {
  replace {
    source = "${openstack_objectstorage_tempurl_v1.bootstrap_tmpurl.url}"
  }
}

data "openstack_images_image_v2" "bootstrap_image" {
  name        = "${var.tectonic_openstack_base_image}"
  most_recent = true
}

data "openstack_compute_flavor_v2" "bootstrap_flavor" {
  name = "${var.tectonic_openstack_master_flavor_name}"
}

resource "openstack_compute_instance_v2" "bootstrap" {
  name = "${var.tectonic_cluster_name}-bootstrap"

  flavor_id = "${data.openstack_compute_flavor_v2.bootstrap_flavor.id}"
  image_id  = "${data.openstack_images_image_v2.bootstrap_image.id}"

  # NOTE(shadower): according to the terraform docs, we should not set a SG here
  # if we plan to attach a port (which we do). Instead, we should set the security
  # groups on the port.
  # https://www.terraform.io/docs/providers/openstack/r/compute_instance_v2.html#security_groups
  #security_groups = ["default"]
  user_data = "${data.ignition_config.bootstrap_redirect.rendered}"

  network {
    port = "${local.bootstrap_port}"
  }

  metadata {
    Name = "${var.tectonic_cluster_name}-bootstrap"

    # "kubernetes.io/cluster/${var.tectonic_cluster_name}" = "owned"
    tectonicClusterID = "${var.tectonic_cluster_id}"
  }
}

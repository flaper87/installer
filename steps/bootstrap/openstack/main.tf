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
  #container_name = "${openstack_objectstorage_container_v1.tectonic.name}"
  container_name = "${local.swift_container}"
  name           = "config/master"

  #content        = "${data.ignition_config.bootstrap_redirect.rendered}"
  content = "${local.ignition_bootstrap}"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

resource "openstack_objectstorage_object_v1" "bootstrap" {
  name = "config/bootstrap"

  #container_name = "${openstack_objectstorage_container_v1.tectonic.name}"
  container_name = "${local.swift_container}"
  content        = "${local.ignition_bootstrap}"
  content_type   = "application/json"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

resource "openstack_objectstorage_tempurl_v1" "bootstrap_tmpurl" {
  #container = "${openstack_objectstorage_container_v1.tectonic.name}"
  container = "${local.swift_container}"
  method    = "get"
  object    = "${openstack_objectstorage_object_v1.bootstrap.name}"
  ttl       = 3600
}

# The public ignition configuration
data "ignition_config" "bootstrap_redirect" {
  replace {
    source = "swift://${local.swift_container}}/config/bootstrap"
  }
}

data "ignition_config" "bootstrap" {
  replace {
    source = "${openstack_objectstorage_tempurl_v1.bootstrap_tmpurl.url}"
  }
}

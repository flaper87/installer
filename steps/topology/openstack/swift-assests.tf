resource "openstack_objectstorage_container_v1" "tectonic" {
  name   = "${lower(var.tectonic_cluster_name)}-tnc.${var.tectonic_base_domain}"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

resource "openstack_objectstorage_object_v1" "bootstrap" {
  container_name = "${openstack_objectstorage_container_v1.tectonic.name}"
  name           = "config/bootstrap"
  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"


  content_type = "application/json"
  content = "${local.ignition_bootstrap}"
}

resource "openstack_objectstorage_tempurl_v1" "bootstrap_tmpurl" {
  container = "${openstack_objectstorage_container_v1.tectonic.name}"
  object = "${openstack_objectstorage_object_v1.bootstrap.name}"
  method = "get"
  ttl = 3600
}

# The public ignition configuration
data "ignition_config" "bootstrap_redirect" {
  replace {
    source = "swift://${openstack_objectstorage_container_v1.tectonic.name}}/config/bootstrap"
  }
}

# The public ignition object.
resource "openstack_objectstorage_object_v1" "ignition_bootstrap" {
  container_name = "${openstack_objectstorage_container_v1.tectonic.name}"
  name     = "config/master"
  content = "${data.ignition_config.bootstrap_redirect.rendered}"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

data "ignition_config" "bootstrap" {
  replace {
    source = "${openstack_objectstorage_tempurl_v1.bootstrap_tmpurl.url}"
  }
}

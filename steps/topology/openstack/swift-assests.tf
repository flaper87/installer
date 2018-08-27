resource "openstack_objectstorage_container_v1" "tectonic" {
  name = "${lower(var.tectonic_cluster_name)}-tnc.${var.tectonic_base_domain}"

  metadata = "${merge(map(
      "Name", "${var.tectonic_cluster_name}-ignition-master",
      "KubernetesCluster", "${var.tectonic_cluster_name}",
      "tectonicClusterID", "${var.tectonic_cluster_id}"
    ), var.tectonic_openstack_extra_tags)}"
}

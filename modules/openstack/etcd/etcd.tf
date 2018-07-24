data "null_data_source" "networks" {
  count = "${length(var.subnet_ids)}"

  inputs = {
    port = "${var.subnet_ids[count.index]}"
  }
}

data "openstack_images_image_v2" "etcd_img" {
  name = "${var.base_image}"
  most_recent = true
}

data "openstack_compute_flavor_v2" "etcd_flavor" {
  name = "${var.flavor_name}"
}

resource "openstack_compute_instance_v2" "etcd_conf" {
  count           = "${var.instance_count}"
  name            = "${var.cluster_name}-etcd-${count.index}"
  image_id        = "${data.openstack_images_image_v2.etcd_img.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.etcd_flavor.id}"
  key_pair        = "${var.ssh_key}"
  security_groups = ["${var.etcd_sg_ids}"]

  metadata {
      Name               = "${var.cluster_name}-etcd"
      owned              = "kubernetes.io/cluster/${var.cluster_name}"
      tectonicClusterID  = "${var.cluster_id}"
  }

  network = ["${data.null_data_source.networks.outputs}"]
}

locals {
}

data "openstack_images_image_v2" "masters_img" {
  name = "${var.base_image}"
  most_recent = true
}

data "openstack_compute_flavor_v2" "masters_flavor" {
  name = "${var.flavor_name}"
}

resource "openstack_compute_instance_v2" "master_conf" {
  count           = "${var.instance_count}"
  name            = "${var.cluster_name}-master-${count.index}"
  image_id        = "${data.openstack_images_image_v2.masters_img.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.masters_flavor.id}"
  key_pair        = "${var.ssh_key}"
  security_groups = ["${var.master_sg_ids}"]

  metadata {
      Name               = "${var.cluster_name}-master"
      owned              = "kubernetes.io/cluster/${var.cluster_name}"
      tectonicClusterID  = "${var.cluster_id}"
  }

  network {
    uuid = "${var.subnet_ids[0]}"
  }
}

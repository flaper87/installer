provider "openstack" {
  cloud      = "rdo-cloud"
}

locals {
}

data "openstack_images_image_v2" "workers_img" {
  name = "${var.base_image}"
  most_recent = true
}

data "openstack_compute_flavor_v2" "workers_flavor" {
  name = "${var.flavor_name}"
}

resource "openstack_compute_instance_v2" "worker_conf" {
  count           = "${var.instance_count}"
  name            = "${var.cluster_name}-worker-${count.index}"
  image_id        = "${data.openstack_images_image_v2.workers_img.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.workers_flavor.id}"
  key_pair        = "${var.ssh_key}"
  security_groups = ["${var.worker_sg_ids}"]

  metadata {
      Name               = "${var.cluster_name}-worker"
      owned              = "kubernetes.io/cluster/${var.cluster_name}"
      tectonicClusterID  = "${var.cluster_id}"
  }

  network {
    uuid = "${var.subnet_ids[0]}"
  }
}

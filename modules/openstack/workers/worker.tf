data "null_data_source" "networks" {
  count = "${length(var.subnet_ids)}"

  inputs = {
    port = "${var.subnet_ids[count.index]}"
  }
}

data "openstack_images_image_v2" "workers_img" {
  name        = "${var.base_image}"
  most_recent = true
}

data "openstack_compute_flavor_v2" "workers_flavor" {
  name = "${var.flavor_name}"
}

resource "openstack_compute_instance_v2" "worker_conf" {
  name  = "${var.cluster_name}-worker-${count.index}"
  count = "${var.instance_count}"

  flavor_id       = "${data.openstack_compute_flavor_v2.workers_flavor.id}"
  image_id        = "${data.openstack_images_image_v2.workers_img.id}"
  key_pair        = "${var.key_pair}"
  network         = ["${data.null_data_source.networks.outputs}"]
  security_groups = ["${var.worker_sg_ids}"]
  user_data       = "${var.user_data_ign}"

  metadata {
    Name              = "${var.cluster_name}-worker"
    owned             = "kubernetes.io/cluster/${var.cluster_name}"
    tectonicClusterID = "${var.cluster_id}"
  }
}

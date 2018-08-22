data "openstack_compute_keypair_v2" "openstack_key_pair" {
  name = "${var.tectonic_openstack_key_pair}"
}

# Terraform doesn't support "inheritance"
# So we have to pass all variables down
module assets_base {
  source = "../base"

  cloud_provider = "openstack"
  etcd_count     = "${var.tectonic_etcd_count}"
  ingress_kind   = "haproxy-router"

  tectonic_admin_email             = "${var.tectonic_admin_email}"
  tectonic_admin_password          = "${var.tectonic_admin_password}"
  tectonic_base_domain             = "${var.tectonic_base_domain}"
  tectonic_cluster_cidr            = "${var.tectonic_cluster_cidr}"
  tectonic_cluster_id              = "${var.tectonic_cluster_id}"
  tectonic_cluster_name            = "${var.tectonic_cluster_name}"
  tectonic_container_images        = "${var.tectonic_container_images}"
  tectonic_container_linux_channel = "${var.tectonic_container_linux_channel}"
  tectonic_container_linux_version = "${var.tectonic_container_linux_version}"
  tectonic_image_re                = "${var.tectonic_image_re}"
  tectonic_kubelet_debug_config    = "${var.tectonic_kubelet_debug_config}"
  tectonic_license_path            = "${var.tectonic_license_path}"
  tectonic_networking              = "${var.tectonic_networking}"
  tectonic_platform                = "${var.tectonic_platform}"
  tectonic_pull_secret_path        = "${var.tectonic_pull_secret_path}"
  tectonic_service_cidr            = "${var.tectonic_service_cidr}"
  tectonic_update_channel          = "${var.tectonic_update_channel}"
  tectonic_versions                = "${var.tectonic_versions}"
}

data "ignition_user" "ssh_authorized_key" {
  name                = "core"
  ssh_authorized_keys = ["${data.openstack_compute_keypair_v2.openstack_key_pair.public_key}"]
}

# Removing assets is platform-specific
# But it must be installed in /opt/tectonic/rm-assets.sh
data "template_file" "rm_assets_sh" {
  template = "${file("${path.module}/resources/rm-assets.sh")}"
}

data "ignition_file" "rm_assets_sh" {
  filesystem = "root"
  path       = "/opt/tectonic/rm-assets.sh"
  mode       = "0700"

  content {
    content = "${data.template_file.rm_assets_sh.rendered}"
  }
}

data "ignition_config" "bootstrap" {
  files = ["${flatten(list(
    list(
      data.ignition_file.rm_assets_sh.id,
    ),
    module.assets_base.ignition_bootstrap_files,
  ))}"]

  users = [
    "${data.ignition_user.ssh_authorized_key.id}",
  ]

  systemd = [
    "${module.assets_base.ignition_bootstrap_systemd}",
  ]
}

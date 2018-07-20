resource "openstack_networking_secgroup_v2" "worker" {
  name = "worker"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_icmp" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol    = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  port_range_min   = 0
  port_range_max     = 0
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_ssh" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol    = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  port_range_min   = 22
  port_range_max     = 22
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_http" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol    = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  port_range_min   = 80
  port_range_max     = 80
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_https" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol    = "tcp"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  port_range_min   = 443
  port_range_max     = 443
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_heapster" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "tcp"
  port_range_min = 4194
  port_range_max   = 4194
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_heapster_from_master" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.master.id}"

  protocol  = "tcp"
  port_range_min = 4194
  port_range_max   = 4194
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_flannel" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "udp"
  port_range_min = 4789
  port_range_max   = 4789
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_flannel_from_master" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.master.id}"

  protocol  = "udp"
  port_range_min = 4789
  port_range_max   = 4789
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_node_exporter" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "tcp"
  port_range_min = 9100
  port_range_max   = 9100
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_node_exporter_from_master" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.master.id}"

  protocol  = "tcp"
  port_range_min = 9100
  port_range_max   = 9100
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_kubelet_insecure" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "tcp"
  port_range_min = 10250
  port_range_max   = 10250
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_kubelet_insecure_from_master" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.master.id}"

  protocol  = "tcp"
  port_range_min = 10250
  port_range_max   = 10250
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_kubelet_secure" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "tcp"
  port_range_min = 10255
  port_range_max   = 10255
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_kubelet_secure_from_master" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.master.id}"

  protocol  = "tcp"
  port_range_min = 10255
  port_range_max   = 10255
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_services" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.worker.id}"

  protocol  = "tcp"
  port_range_min = 30000
  port_range_max   = 32767
  ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "worker_ingress_services_from_console" {
  direction                     = "ingress"
  security_group_id        = "${openstack_networking_secgroup_v2.worker.id}"
  remote_group_id = "${openstack_networking_secgroup_v2.console.id}"

  protocol  = "tcp"
  port_range_min = 30000
  port_range_max   = 32767
  ethertype = "IPv4"
}

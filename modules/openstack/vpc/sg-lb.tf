resource "openstack_networking_secgroup_v2" "tnc" {
  name = "tnc"
}

resource "openstack_networking_secgroup_rule_v2" "tnc_egress" {
  direction              = "egress"
  security_group_id = "${openstack_networking_secgroup_v2.tnc.id}"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "tnc_http" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.tnc.id}"

  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  protocol    = "tcp"
  port_range_min   = 80
  port_range_max   = 80
}

resource "openstack_networking_secgroup_rule_v2" "tnc_https" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.tnc.id}"

  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  protocol    = "tcp"
  port_range_min   = 443
  port_range_max   = 443
}

resource "openstack_networking_secgroup_v2" "api" {
  name = "api"
}

resource "openstack_networking_secgroup_rule_v2" "api_egress" {
  direction              = "egress"
  security_group_id = "${openstack_networking_secgroup_v2.api.id}"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "api_https" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.api.id}"

  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  protocol    = "tcp"
  port_range_min   = 6443
  port_range_max   = 6443
}

resource "openstack_networking_secgroup_v2" "console" {
  name = "console"
}

resource "openstack_networking_secgroup_rule_v2" "console_egress" {
  direction              = "egress"
  security_group_id = "${openstack_networking_secgroup_v2.console.id}"
  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "console_http" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.console.id}"

  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  protocol    = "tcp"
  port_range_min   = 80
  port_range_max   = 80
}

resource "openstack_networking_secgroup_rule_v2" "console_https" {
  direction              = "ingress"
  security_group_id = "${openstack_networking_secgroup_v2.console.id}"

  remote_ip_prefix = "0.0.0.0/0"
    ethertype = "IPv4"
  protocol    = "tcp"
  port_range_min   = 443
  port_range_max   = 443
}

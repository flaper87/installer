locals {
  new_master_lb_ip    = "${cidrhost(var.cidr_block, 1)}"
}

resource "openstack_compute_floatingip_v2" "master_floating_ip" {
  pool = "public"
}

/*
resource "openstack_networking_port_v2" "masters_vip" {
  count              = "${var.masters_count}"
  name               = "master-port-${count.index}"
  network_id         = "${openstack_networking_network_v2.openshift-private.id}"
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.master.id}"]

  fixed_ip {
 //   "ip_address" = "${local.new_master_port_ip}"
    "subnet_id"  = "${openstack_networking_subnet_v2.masters.id}"
  }
}*/

resource "openstack_lb_loadbalancer_v2" "masters_lb" {
  vip_subnet_id = "${openstack_networking_subnet_v2.masters.id}"
  vip_address   = "${local.new_master_lb_ip}"
  name          = "master-lb"
}

resource "openstack_lb_pool_v2" "masters_pool" {
  name        = "masters_pool"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.masters_lb.id}"
}

resource "openstack_lb_monitor_v2" "masters_monitor" {
  pool_id        = "${openstack_lb_pool_v2.masters_pool.id}"
  type           = "TCP"
  delay          = 30
  timeout        = 5
  max_retries    = 3
  admin_state_up = "true"
}

/*
resource "openstack_lb_member_v1" "master" {
  pool_id = "${openstack_lb_pool_v1.masters_pool.id}"
  address = "${openstack_compute_instance_v2.instance_1.access_ip_v4}"
  port    = 80
}*/

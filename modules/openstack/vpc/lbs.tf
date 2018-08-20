locals {
  # NOTE(shadower): this must be the first address of the service block,
  # because that's what the TLS certificate uses in `tls.go`:
  new_master_lb_ip    = "${cidrhost(var.cidr_block, 1)}"
}

resource "openstack_compute_floatingip_v2" "master_floating_ip" {
  pool = "public"
}

resource "openstack_lb_loadbalancer_v2" "masters_lb" {
  vip_subnet_id = "${openstack_networking_subnet_v2.masters.id}"
  vip_address   = "${local.new_master_lb_ip}"
  name          = "master-lb"
}

resource "openstack_lb_pool_v2" "masters_pool" {
  name        = "masters_pool"
  protocol    = "HTTPS"
  lb_method   = "ROUND_ROBIN"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.masters_lb.id}"
}

/* TODO(shadower): test this and put sensible values here
resource "openstack_lb_monitor_v2" "masters_monitor" {
  pool_id        = "${openstack_lb_pool_v2.masters_pool.id}"
  type           = "HTTPS"
  delay          = 180
  timeout        = 180
  max_retries    = 30
  admin_state_up = "true"
}
*/

resource "openstack_lb_listener_v2" "masters_listener" {
  protocol        = "HTTPS"
  protocol_port   = 6443
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.masters_lb.id}"
  default_pool_id = "${openstack_lb_pool_v2.masters_pool.id}"
}

resource "openstack_lb_member_v2" "master_member" {
  count         = "${var.masters_count}"
  name          = "${var.cluster_name}-member-${count.index}"
  pool_id       = "${openstack_lb_pool_v2.masters_pool.id}"
  protocol_port = 6443
  address       = "${local.master_port_ips[count.index]}"
}

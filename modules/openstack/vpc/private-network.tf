locals {
  new_worker_cidr_range = "${cidrsubnet(var.cidr_block, 1, 1)}"
  new_master_cidr_range = "${cidrsubnet(var.cidr_block, 1, 0)}"
}

resource "openstack_networking_network_v2" "openshift-private" {
  name           = "openshift"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "masters" {
  name       = "masters"
  network_id = "${openstack_networking_network_v2.openshift-private.id}"
  cidr       = "${local.new_master_cidr_range}"
  gateway_ip = "${cidrhost(local.new_master_cidr_range, 2)}"
  allocation_pools = [{
    # NOTE(shadower): this must start at `3` because the first address is
    # expected to be the IP of the API endpoint (i.e. the load balancer) and
    # the second one is the gateway (which must be outside the pool).
    start = "${cidrhost(local.new_master_cidr_range, 3)}"
    end = "${cidrhost(local.new_master_cidr_range, -2)}"
  }]
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "workers" {
  name       = "worker"
  network_id = "${openstack_networking_network_v2.openshift-private.id}"
  cidr       = "${local.new_worker_cidr_range}"
  ip_version = 4
}

resource "openstack_networking_port_v2" "masters" {
  count              = "${var.masters_count}"
  name               = "master-port-${count.index}"
  network_id         = "${openstack_networking_network_v2.openshift-private.id}"
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.master.id}"]

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.masters.id}"
  }
}

resource "openstack_networking_port_v2" "workers" {
  count              = "${var.workers_count}"
  name               = "worker-port-${count.index}"
  network_id         = "${openstack_networking_network_v2.openshift-private.id}"
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.worker.id}"]

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.workers.id}"
  }
}

resource "openstack_networking_port_v2" "etcds" {
  count              = "${var.workers_count}"
  name               = "etcd-port-${count.index}"
  network_id         = "${openstack_networking_network_v2.openshift-private.id}"
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.worker.id}"]

  fixed_ip {
    "subnet_id"  = "${openstack_networking_subnet_v2.workers.id}"
  }
}

resource "openstack_networking_router_v2" "openshift-external-router" {
  name                = "openshift-external-router"
  admin_state_up      = true
  external_network_id = "${var.external_network}"
}

resource "openstack_networking_router_interface_v2" "masters_router_interface" {
  router_id = "${openstack_networking_router_v2.openshift-external-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.masters.id}"
}

resource "openstack_networking_router_interface_v2" "workers_router_interface" {
  router_id = "${openstack_networking_router_v2.openshift-external-router.id}"
  subnet_id = "${openstack_networking_subnet_v2.workers.id}"
}

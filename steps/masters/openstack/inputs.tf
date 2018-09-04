data "terraform_remote_state" "bootstrap" {
  backend = "local"

  config {
    path = "${path.cwd}/bootstrap.tfstate"
  }
}

data "terraform_remote_state" "topology" {
  backend = "local"

  config {
    path = "${path.cwd}/topology.tfstate"
  }
}

locals {
  openstack_lbs = "${data.terraform_remote_state.topology.openstack_lbs}"
  sg_id         = "${data.terraform_remote_state.topology.master_sg_id}"
  subnet_ids    = "${data.terraform_remote_state.topology.subnet_ids_masters}"
}

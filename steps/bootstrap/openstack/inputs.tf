data "terraform_remote_state" "topology" {
  backend = "local"

  config {
    path = "${path.cwd}/topology.tfstate"
  }
}

data "terraform_remote_state" "assets" {
  backend = "local"

  config {
    path = "${path.cwd}/assets.tfstate"
  }
}

locals {
  subnet_ids         = "${data.terraform_remote_state.topology.subnet_ids_masters}"
  swift_container    = "${data.terraform_remote_state.topology.swift_container}"
  bootstrap_port     = "${data.terraform_remote_state.topology.bootstrap_port_id}"
  ignition_bootstrap = "${data.terraform_remote_state.assets.ignition_bootstrap}"
}

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
  swift_container    = "${data.terraform_remote_state.topology.swift_container}"
  ignition_bootstrap = "${data.terraform_remote_state.assets.ignition_bootstrap}"
}

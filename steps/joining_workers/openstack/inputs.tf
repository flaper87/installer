data "terraform_remote_state" "topology" {
  backend = "local"

  config {
    path = "${path.cwd}/topology.tfstate"
  }
}

locals {
  sg_id      = "${data.terraform_remote_state.topology.worker_sg_id}"
  subnet_ids = "${data.terraform_remote_state.topology.subnet_ids_workers}"
}

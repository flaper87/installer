variable "base_domain" {
  type        = "string"
  description = "Domain on which the Octavia records will be created"
}

variable "base_image" {
  type = "string"
}

variable "cluster_id" {
  type = "string"
}

variable "cluster_name" {
  type = "string"
}

variable "container_images" {
  description = "Container images to use"
  type        = "map"
}

variable "flavor_name" {
  type = "string"
}

variable "extra_tags" {
  description = "Extra AWS tags to be applied to created resources."
  type        = "map"
  default     = {}
}

variable "instance_count" {
  type = "string"
}

variable "master_iam_role" {
  type        = "string"
  default     = ""
  description = "IAM role to use for the instance profiles of master nodes."
}

variable "master_sg_ids" {
  type        = "list"
  default     = ["default"]
  description = "The security group IDs to be applied to the master nodes."
}

variable "private_endpoints" {
  description = "If set to true, private-facing ingress resources are created."
  default     = true
}

variable "public_endpoints" {
  description = "If set to true, public-facing ingress resources are created."
  default     = true
}

variable "aws_lbs" {
  description = "List of aws_lb IDs for the Console & APIs"
  type        = "list"
  default     = []
}

variable "root_volume_iops" {
  type        = "string"
  default     = "100"
  description = "The amount of provisioned IOPS for the root block device."
}

variable "root_volume_size" {
  type        = "string"
  description = "The size of the volume in gigabytes for the root block device."
}

variable "root_volume_type" {
  type        = "string"
  description = "The type of volume for the root block device."
}

variable "ssh_key" {
  type = "string"
}

variable "network_name" {
  type = "string"
}

variable "networks" {
  type = "list"
  default = []
}

variable "dns_server_ip" {
  type    = "string"
  default = ""
}

variable "kubeconfig_content" {
  type    = "string"
  default = ""
}

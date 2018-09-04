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
  type        = "map"
  description = "Container images to use"
}

variable "dns_server_ip" {
  type    = "string"
  default = ""
}

variable "extra_tags" {
  type        = "map"
  description = "Extra AWS tags to be applied to created resources."
  default     = {}
}

variable "flavor_name" {
  type = "string"
}

variable "instance_count" {
  type = "string"
}

variable "kubeconfig_content" {
  type    = "string"
  default = ""
}

variable "master_sg_ids" {
  type        = "list"
  default     = ["default"]
  description = "The security group IDs to be applied to the master nodes."
}

variable "openstack_lbs" {
  type        = "list"
  description = "List of openstack_lb IDs for the Console & APIs"
  default     = []
}

variable "private_endpoints" {
  description = "If set to true, private-facing ingress resources are created."
  default     = true
}

variable "public_endpoints" {
  description = "If set to true, public-facing ingress resources are created."
  default     = true
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

variable "subnet_ids" {
  type = "list"
}

variable "user_data_igns" {
  type = "list"
}

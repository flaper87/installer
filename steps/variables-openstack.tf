variable "tectonic_openstack_credentials_auth_url" {
	type = "string"
	description = <<EOF
required if cloud is not specified) The Identity authentication URL. If omitted, the OS_AUTH_URL environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_cloud" {
	type = "string"
	description = <<EOF
required if auth_url is not specified) An entry in a clouds.yaml file. See the OpenStack os-client-config documentation for more information about clouds.yaml files. If omitted, the OS_CLOUD environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_region" {
	type = "string"
	description = <<EOF
The region of the OpenStack cloud to use. If omitted, the OS_REGION_NAME environment variable is used. If OS_REGION_NAME is not set, then no region will be used. It should be possible to omit the region in single-region OpenStack environments, but this behavior may vary depending on the OpenStack environment being used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_user_name" {
	type = "string"
	description = <<EOF
The Username to login with. If omitted, the OS_USERNAME environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_user_id" {
	type = "string"
	description = <<EOF
The User ID to login with. If omitted, the OS_USER_ID environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_tenant_id" {
	type = "string"
	description = <<EOF
The ID of the Tenant (Identity v2) or Project (Identity v3) to login with. If omitted, the OS_TENANT_ID or OS_PROJECT_ID environment variables are used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_tenant_name" {
	type = "string"
	description = <<EOF
The Name of the Tenant (Identity v2) or Project (Identity v3) to login with. If omitted, the OS_TENANT_NAME or OS_PROJECT_NAME environment variable are used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_password" {
	type = "string"
	description = <<EOF
The Password to login with. If omitted, the OS_PASSWORD environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_token" {
	type = "string"
	description = <<EOF
Required if not using user_name and password) A token is an expiring, temporary means of access issued via the Keystone service. By specifying a token, you do not have to specify a username/password combination, since the token was already created by a username/password out of band of Terraform. If omitted, the OS_TOKEN or OS_AUTH_TOKEN environment variables are used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_user_domain_name" {
	type = "string"
	description = <<EOF
The domain name where the user is located. If omitted, the OS_USER_DOMAIN_NAME environment variable is checked.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_user_domain_id" {
	type = "string"
	description = <<EOF
The domain ID where the user is located. If omitted, the OS_USER_DOMAIN_ID environment variable is checked.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_project_domain_name" {
	type = "string"
	description = <<EOF
The domain name where the project is located. If omitted, the OS_PROJECT_DOMAIN_NAME environment variable is checked.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_project_domain_id" {
	type = "string"
	description = <<EOF
The domain ID where the project is located If omitted, the OS_PROJECT_DOMAIN_ID environment variable is checked.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_domain_id" {
	type = "string"
	description = <<EOF
The ID of the Domain to scope to (Identity v3). If omitted, the OS_DOMAIN_ID environment variable is checked.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_domain_name" {
	type = "string"
	description = <<EOF
The Name of the Domain to scope to (Identity v3). If omitted, the following environment variables are checked (in this order): OS_DOMAIN_NAME, OS_DEFAULT_DOMAIN.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_insecure" {
	description = <<EOF
Trust self-signed SSL certificates. If omitted, the OS_INSECURE environment variable is used.
EOF
    default = false
}

variable "tectonic_openstack_credentials_cacert_file" {
	type = "string"
	description = <<EOF
Specify a custom CA certificate when communicating over SSL. You can specify either a path to the file or the contents of the certificate. If omitted, the OS_CACERT environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_cert" {
	type = "string"
	description = <<EOF
Specify client certificate file for SSL client authentication. You can specify either a path to the file or the contents of the certificate. If omitted the OS_CERT environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_key" {
	type = "string"
	description = <<EOF
Specify client private key file for SSL client authentication. You can specify either a path to the file or the contents of the key. If omitted the OS_KEY environment variable is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_endpoint_type" {
	type = "string"
	description = <<EOF
Specify which type of endpoint to use from the service catalog. It can be set using the OS_ENDPOINT_TYPE environment variable. If not set, public endpoints is used.
EOF
    default = ""
}

variable "tectonic_openstack_credentials_swauth" {
	description = <<EOF
Set to true to authenticate against Swauth, a Swift-native authentication system. If omitted, the OS_SWAUTH environment variable is used. You must also set username to the Swauth/Swift username such as username:project. Set the password to the Swauth/Swift key. Finally, set auth_url as the location of the Swift service. Note that this will only work when used with the OpenStack Object Storage resources.
EOF
    default = false
}

variable "tectonic_openstack_credentials_use_octavia" {
	description = <<EOF
If set to true, API requests will go the Load Balancer service (Octavia) instead of the Networking service (Neutron).
EOF
    default = false
}

variable "tectonic_openstack_config_version" {
  description = <<EOF
(internal) This declares the version of the AWS configuration variables.
It has no impact on generated assets but declares the version contract of the configuration.
EOF

  default = "1.0"
}

variable "tectonic_openstack_profile" {
  description = <<EOF
(optional) This declares the AWS credentials profile to use.
EOF

  type = "string"
}

variable "tectonic_openstack_base_image" {
  type        = "string"
  description = "Name of the base image to use for the nodes."
}

variable "tectonic_openstack_ssh_key" {
  type        = "string"
  description = "Name of an SSH key located within the AWS region. Example: coreos-user."
}

variable "tectonic_openstack_master_flavor_name" {
  type        = "string"
  description = "Instance size for the master node(s). Example: `t2.medium`."
  default     = "t2.medium"
}

variable "tectonic_openstack_worker_flavor_name" {
  type        = "string"
  description = "Instance size for the worker node(s). Example: `t2.medium`."
  default     = "t2.medium"
}

variable "tectonic_openstack_etcd_flavor_name" {
  type = "string"

  description = <<EOF
  Instance size for the etcd node(s). Example: `t2.medium`. Read the [etcd recommended hardware](https://coreos.com/etcd/docs/latest/op-guide/hardware.html) guide for best performance
  EOF

  default = "t2.medium"
}

variable "tectonic_openstack_ec2_ami_override" {
  type        = "string"
  description = "(optional) AMI override for all nodes. Example: `ami-foobar123`."
  default     = ""
}

variable "tectonic_openstack_etcd_extra_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for etcd nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_master_extra_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for master nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_worker_extra_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for worker nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_etcd_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for etcd nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_master_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for master nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_worker_sg_ids" {
  description = <<EOF
(optional) List of additional security group IDs for worker nodes.

Example: `["sg-51530134", "sg-b253d7cc"]`
EOF

  type    = "list"
  default = []
}

variable "tectonic_openstack_vpc_cidr_block" {
  type = "string"

  description = <<EOF
Block of IP addresses used by the VPC.
This should not overlap with any other networks, such as a private datacenter connected via Direct Connect.
EOF
}

variable "tectonic_openstack_external_vpc_id" {
  type = "string"

  description = <<EOF
(optional) ID of an existing VPC to launch nodes into.
If unset a new VPC is created.

Example: `vpc-123456`
EOF

  default = ""
}

variable "tectonic_openstack_endpoints" {
  description = <<EOF
(optional) If set to "all", the default, then both public and private ingress resources (ELB, A-records) will be created.
If set to "private", then only create private-facing ingress resources (ELB, A-records). No public-facing ingress resources will be created.
If set to "public", then only create public-facing ingress resources (ELB, A-records). No private-facing ingress resources will be provisioned and all DNS records will be created in the public Route53 zone.
EOF
}

variable "tectonic_openstack_external_private_zone" {
  default = ""

  description = <<EOF
(optional) If set, the given Route53 zone ID will be used as the internal (private) zone.
This zone will be used to create etcd DNS records as well as internal API and internal Ingress records.
If set, no additional private zone will be created.

Example: `"Z1ILINNUJGTAO1"`
EOF
}

variable "tectonic_openstack_external_master_subnet_ids" {
  type = "list"

  description = <<EOF
(optional) List of subnet IDs within an existing VPC to deploy master nodes into.
Required to use an existing VPC, not applicable otherwise.

Example: `["subnet-111111", "subnet-222222", "subnet-333333"]`
EOF

  default = []
}

variable "tectonic_openstack_external_worker_subnet_ids" {
  type = "list"

  description = <<EOF
(optional) List of subnet IDs within an existing VPC to deploy worker nodes into.
Required to use an existing VPC, not applicable otherwise.

Example: `["subnet-111111", "subnet-222222", "subnet-333333"]`
EOF

  default = []
}

variable "tectonic_openstack_extra_tags" {
  type = "map"

  description = <<EOF
(optional) Extra AWS tags to be applied to created resources.

Example: `{ "key" = "value", "foo" = "bar" }`
EOF

  default = {}
}

variable "tectonic_autoscaling_group_extra_tags" {
  type    = "list"
  default = []

  description = <<EOF
(optional) Extra AWS tags to be applied to created autoscaling group resources.
This is a list of maps having the keys `key`, `value` and `propagate_at_launch`.

Example: `[ { key = "foo", value = "bar", propagate_at_launch = true } ]`
EOF
}

variable "tectonic_openstack_etcd_root_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "The type of volume for the root block device of etcd nodes."
}

variable "tectonic_openstack_etcd_root_volume_size" {
  type        = "string"
  default     = "30"
  description = "The size of the volume in gigabytes for the root block device of etcd nodes."
}

variable "tectonic_openstack_etcd_root_volume_iops" {
  type    = "string"
  default = "100"

  description = <<EOF
The amount of provisioned IOPS for the root block device of etcd nodes.
Ignored if the volume type is not io1.
EOF
}

variable "tectonic_openstack_master_root_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "The type of volume for the root block device of master nodes."
}

variable "tectonic_openstack_master_root_volume_size" {
  type        = "string"
  default     = "30"
  description = "The size of the volume in gigabytes for the root block device of master nodes."
}

variable "tectonic_openstack_master_root_volume_iops" {
  type    = "string"
  default = "100"

  description = <<EOF
The amount of provisioned IOPS for the root block device of master nodes.
Ignored if the volume type is not io1.
EOF
}

variable "tectonic_openstack_worker_root_volume_type" {
  type        = "string"
  default     = "gp2"
  description = "The type of volume for the root block device of worker nodes."
}

variable "tectonic_openstack_worker_root_volume_size" {
  type        = "string"
  default     = "30"
  description = "The size of the volume in gigabytes for the root block device of worker nodes."
}

variable "tectonic_openstack_worker_root_volume_iops" {
  type    = "string"
  default = "100"

  description = <<EOF
The amount of provisioned IOPS for the root block device of worker nodes.
Ignored if the volume type is not io1.
EOF
}

variable "tectonic_openstack_master_custom_subnets" {
  type    = "map"
  default = {}

  description = <<EOF
(optional) This configures master availability zones and their corresponding subnet CIDRs directly.

Example:
`{ eu-west-1a = "10.0.0.0/20", eu-west-1b = "10.0.16.0/20" }`
EOF
}

variable "tectonic_openstack_worker_custom_subnets" {
  type    = "map"
  default = {}

  description = <<EOF
(optional) This configures worker availability zones and their corresponding subnet CIDRs directly.

Example: `{ eu-west-1a = "10.0.64.0/20", eu-west-1b = "10.0.80.0/20" }`
EOF
}

variable "tectonic_openstack_region" {
  type        = "string"
  description = "The target AWS region for the cluster."
}

variable "tectonic_openstack_installer_role" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) Name of IAM role to use to access AWS in order to deploy the Tectonic Cluster.
The name is also the full role's ARN.

Example:
 * Role ARN  = arn:openstack:iam::123456789012:role/tectonic-installer
EOF
}

variable "tectonic_openstack_master_iam_role_name" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) Name of IAM role to use for the instance profiles of master nodes.
The name is also the last part of a role's ARN.

Example:
 * Role ARN  = arn:openstack:iam::123456789012:role/tectonic-installer
 * Role Name = tectonic-installer
EOF
}

variable "tectonic_openstack_worker_iam_role_name" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) Name of IAM role to use for the instance profiles of worker nodes.
The name is also the last part of a role's ARN.

Example:
 * Role ARN  = arn:openstack:iam::123456789012:role/tectonic-installer
 * Role Name = tectonic-installer
EOF
}

variable "tectonic_openstack_etcd_iam_role_name" {
  type    = "string"
  default = ""

  description = <<EOF
(optional) Name of IAM role to use for the instance profiles of etcd nodes.
The name is also the last part of a role's ARN.

Example:
 * Role ARN  = arn:openstack:iam::123456789012:role/tectonic-installer
 * Role Name = tectonic-installer
EOF
}

variable "tectonic_openstack_worker_load_balancers" {
  type    = "list"
  default = []

  description = <<EOF
(optional) List of ELBs to attach all worker instances to.
This is useful for exposing NodePort services via load-balancers managed separately from the cluster.

Example:
 * `["ingress-nginx"]`
EOF
}

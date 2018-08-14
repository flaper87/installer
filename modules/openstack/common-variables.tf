variable "auth_url" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional; required if cloud is not specified) The Identity authentication URL. If omitted, the OS_AUTH_URL environment variable is used.
EOF
}

variable "cacert_file" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) Specify a custom CA certificate when communicating over SSL. You can specify either a path to the file or the contents of the certificate. If omitted, the OS_CACERT environment variable is used.
EOF
}

variable "cert" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) Specify client certificate file for SSL client authentication. You can specify either a path to the file or the contents of the certificate. If omitted the OS_CERT environment variable is used.
EOF
}

variable "cloud" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional; required if auth_url is not specified) An entry in a clouds.yaml file. See the OpenStack os-client-config documentation for more information about clouds.yaml files. If omitted, the OS_CLOUD environment variable is used.
EOF
}

variable "domain_id" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The ID of the Domain to scope to (Identity v3). If omitted, the OS_DOMAIN_ID environment variable is checked.
EOF
}

variable "domain_name" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The Name of the Domain to scope to (Identity v3). If omitted, the following environment variables are checked (in this order): OS_DOMAIN_NAME, OS_DEFAULT_DOMAIN.
EOF
}

variable "endpoint_type" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) Specify which type of endpoint to use from the service catalog. It can be set using the OS_ENDPOINT_TYPE environment variable. If not set, public endpoints is used.
EOF
}

variable "insecure" {
  default = false

  description = <<EOF
(Optional) Trust self-signed SSL certificates. If omitted, the OS_INSECURE environment variable is used.
EOF
}

variable "key" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) Specify client private key file for SSL client authentication. You can specify either a path to the file or the contents of the key. If omitted the OS_KEY environment variable is used.
EOF
}

variable "password" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The Password to login with. If omitted, the OS_PASSWORD environment variable is used.
EOF
}

variable "project_domain_id" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The domain ID where the project is located If omitted, the OS_PROJECT_DOMAIN_ID environment variable is checked.
EOF
}

variable "project_domain_name" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The domain name where the project is located. If omitted, the OS_PROJECT_DOMAIN_NAME environment variable is checked.
EOF
}

variable "region" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The region of the OpenStack cloud to use. If omitted, the OS_REGION_NAME environment variable is used. If OS_REGION_NAME is not set, then no region will be used. It should be possible to omit the region in single-region OpenStack environments, but this behavior may vary depending on the OpenStack environment being used.
EOF
}

variable "swauth" {
  default = false

  description = <<EOF
(Optional) Set to true to authenticate against Swauth, a Swift-native authentication system. If omitted, the OS_SWAUTH environment variable is used. You must also set username to the Swauth/Swift username such as username:project. Set the password to the Swauth/Swift key. Finally, set auth_url as the location of the Swift service. Note that this will only work when used with the OpenStack Object Storage resources.
EOF
}

variable "tenant_id" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The ID of the Tenant (Identity v2) or Project (Identity v3) to login with. If omitted, the OS_TENANT_ID or OS_PROJECT_ID environment variables are used.
EOF
}

variable "tenant_name" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The Name of the Tenant (Identity v2) or Project (Identity v3) to login with. If omitted, the OS_TENANT_NAME or OS_PROJECT_NAME environment variable are used.
EOF
}

variable "token" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional; Required if not using user_name and password) A token is an expiring, temporary means of access issued via the Keystone service. By specifying a token, you do not have to specify a username/password combination, since the token was already created by a username/password out of band of Terraform. If omitted, the OS_TOKEN or OS_AUTH_TOKEN environment variables are used.
EOF
}

variable "user_domain_id" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The domain ID where the user is located. If omitted, the OS_USER_DOMAIN_ID environment variable is checked.
EOF
}

variable "user_domain_name" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The domain name where the user is located. If omitted, the OS_USER_DOMAIN_NAME environment variable is checked.
EOF
}

variable "user_id" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The User ID to login with. If omitted, the OS_USER_ID environment variable is used.
EOF
}

variable "user_name" {
  type    = "string"
  default = ""

  description = <<EOF
(Optional) The Username to login with. If omitted, the OS_USERNAME environment variable is used.
EOF
}

variable "use_octavia" {
  default = false

  description = <<EOF
(Optional) If set to true, API requests will go the Load Balancer service (Octavia) instead of the Networking service (Neutron).
EOF
}

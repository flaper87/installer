package openstack

// Endpoints is the type of the OpenStack endpoints.
type Endpoints string

const (
	// EndpointsAll represents the configuration for using both private and public endpoints.
	EndpointsAll Endpoints = "all"
	// EndpointsPrivate represents the configuration for using only private endpoints.
	EndpointsPrivate Endpoints = "private"
	// EndpointsPublic represents the configuration for using only public endpoints.
	EndpointsPublic Endpoints = "public"
	// DefaultVPCCIDRBlock is the default CIDR range for an OpenStack VPC.
	DefaultVPCCIDRBlock = "10.0.0.0/16"
	// DefaultProfile is the default OpenStack credentials profile to use.
	DefaultProfile = "default"
	// DefaultRegion is the default OpenStack region for the cluster.
	DefaultRegion = "RegionOne"
)

// OpenStack converts OpenStack related config.
type OpenStack struct {
	Endpoints                 Endpoints           `json:"tectonic_openstack_endpoints,omitempty" yaml:"endpoints,omitempty"`
	Etcd                      `json:",inline" yaml:"etcd,omitempty"`
	External                  `json:",inline" yaml:"external,omitempty"`
	ExtraTags                 map[string]string `json:"tectonic_openstack_extra_tags,omitempty" yaml:"extraTags,omitempty"`
	InstallerRole             string            `json:"tectonic_openstack_installer_role,omitempty" yaml:"installerRole,omitempty"`
	Master                    `json:",inline" yaml:"master,omitempty"`
	Profile                   string `json:"tectonic_openstack_profile,omitempty" yaml:"profile,omitempty"`
	Region                    string `json:"tectonic_openstack_region,omitempty" yaml:"region,omitempty"`
	SSHKey                    string `json:"tectonic_openstack_ssh_key,omitempty" yaml:"sshKey,omitempty"`
	VPCCIDRBlock              string `json:"tectonic_openstack_vpc_cidr_block,omitempty" yaml:"vpcCIDRBlock,omitempty"`
	Worker                    `json:",inline" yaml:"worker,omitempty"`
}

// External converts external related config.
type External struct {
	MasterSubnetIDs []string `json:"tectonic_openstack_external_master_subnet_ids,omitempty" yaml:"masterSubnetIDs,omitempty"`
	PrivateZone     string   `json:"tectonic_openstack_external_private_zone,omitempty" yaml:"privateZone,omitempty"`
	VPCID           string   `json:"tectonic_openstack_external_vpc_id,omitempty" yaml:"vpcID,omitempty"`
	WorkerSubnetIDs []string `json:"tectonic_openstack_external_worker_subnet_ids,omitempty" yaml:"workerSubnetIDs,omitempty"`
}

// Etcd converts etcd related config.
type Etcd struct {
	FlavorName        string   `json:"tectonic_openstack_etcd_flavor_name,omitempty" yaml:"flavorName,omitempty"`
	ExtraSGIDs     []string `json:"tectonic_openstack_etcd_extra_sg_ids,omitempty" yaml:"extraSGIDs,omitempty"`
	EtcdRootVolume `json:",inline" yaml:"rootVolume,omitempty"`
}

// EtcdRootVolume converts etcd rool volume related config.
type EtcdRootVolume struct {
	IOPS int    `json:"tectonic_openstack_etcd_root_volume_iops,omitempty" yaml:"iops,omitempty"`
	Size int    `json:"tectonic_openstack_etcd_root_volume_size,omitempty" yaml:"size,omitempty"`
	Type string `json:"tectonic_openstack_etcd_root_volume_type,omitempty" yaml:"type,omitempty"`
}

// Master converts master related config.
type Master struct {
	CustomSubnets    map[string]string `json:"tectonic_openstack_master_custom_subnets,omitempty" yaml:"customSubnets,omitempty"`
	FlavorName          string            `json:"tectonic_openstack_master_flavor_name,omitempty" yaml:"flavorName,omitempty"`
	ExtraSGIDs       []string          `json:"tectonic_openstack_master_extra_sg_ids,omitempty" yaml:"extraSGIDs,omitempty"`
	MasterRootVolume `json:",inline" yaml:"rootVolume,omitempty"`
}

// MasterRootVolume converts master rool volume related config.
type MasterRootVolume struct {
	IOPS int    `json:"tectonic_openstack_master_root_volume_iops,omitempty" yaml:"iops,omitempty"`
	Size int    `json:"tectonic_openstack_master_root_volume_size,omitempty" yaml:"size,omitempty"`
	Type string `json:"tectonic_openstack_master_root_volume_type,omitempty" yaml:"type,omitempty"`
}

// Worker converts worker related config.
type Worker struct {
	CustomSubnets    map[string]string `json:"tectonic_openstack_worker_custom_subnets,omitempty" yaml:"customSubnets,omitempty"`
	FlavorName          string            `json:"tectonic_openstack_worker_flavor_name,omitempty" yaml:"flavorName,omitempty"`
	ExtraSGIDs       []string          `json:"tectonic_openstack_worker_extra_sg_ids,omitempty" yaml:"extraSGIDs,omitempty"`
	LoadBalancers    []string          `json:"tectonic_openstack_worker_load_balancers,omitempty" yaml:"loadBalancers,omitempty"`
	WorkerRootVolume `json:",inline" yaml:"rootVolume,omitempty"`
}

// WorkerRootVolume converts worker rool volume related config.
type WorkerRootVolume struct {
	IOPS int    `json:"tectonic_openstack_worker_root_volume_iops,omitempty" yaml:"iops,omitempty"`
	Size int    `json:"tectonic_openstack_worker_root_volume_size,omitempty" yaml:"size,omitempty"`
	Type string `json:"tectonic_openstack_worker_root_volume_type,omitempty" yaml:"type,omitempty"`
}

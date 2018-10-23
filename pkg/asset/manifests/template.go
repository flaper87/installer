package manifests

// AwsCredsSecretData holds encoded credentials and is used to generate cloud-creds secret
type AwsCredsSecretData struct {
	Base64encodeAccessKeyID     string
	Base64encodeSecretAccessKey string
}

// OpenStackCredsSecretData holds encoded credentials and is used to generate cloud-creds secret
type OpenStackCredsSecretData struct {
	Base64encodeCloudCreds string
}

type cloudCredsSecretData struct {
	AWS       *AwsCredsSecretData
	OpenStack *OpenStackCredsSecretData
}

type bootkubeTemplateData struct {
	AggregatorCaCert                string
	AggregatorCaKey                 string
	ApiserverCert                   string
	ApiserverKey                    string
	ApiserverProxyCert              string
	ApiserverProxyKey               string
	Base64encodeCloudProviderConfig string
	ClusterapiCaCert                string
	ClusterapiCaKey                 string
	EtcdCaCert                      string
	EtcdClientCert                  string
	EtcdClientKey                   string
	KubeCaCert                      string
	KubeCaKey                       string
	McsTLSCert                      string
	McsTLSKey                       string
	OidcCaCert                      string
	OpenshiftApiserverCert          string
	OpenshiftApiserverKey           string
	OpenshiftLoopbackKubeconfig     string
	PullSecret                      string
	RootCaCert                      string
	ServiceaccountKey               string
	ServiceaccountPub               string
	ServiceServingCaCert            string
	ServiceServingCaKey             string
	TectonicNetworkOperatorImage    string
	WorkerIgnConfig                 string
	CVOClusterID                    string
	EtcdEndpointHostnames           []string
	EtcdEndpointDNSSuffix           string
}

type tectonicTemplateData struct {
	CloudCreds                             cloudCredsSecretData
	IngressCaCert                          string
	IngressKind                            string
	IngressStatusPassword                  string
	IngressTLSBundle                       string
	IngressTLSCert                         string
	IngressTLSKey                          string
	KubeAddonOperatorImage                 string
	PullSecret                             string
	TectonicIngressControllerOperatorImage string
}

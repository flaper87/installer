package tectonic

const (
	// RoleCloudCredsSecretReader is the constant to represent contents of corresponding file
	RoleCloudCredsSecretReader = `
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  namespace: kube-system
  name: cloud-creds-secret-reader
rules:
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: ["cloud-creds"]
  verbs: ["get"]
`
)

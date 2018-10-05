package tectonic

import (
	"text/template"
)

var (
	// CloudCredsSecret is the constant to represent contents of corresponding yaml file
	CloudCredsSecret = template.Must(template.New("cloud-creds-secret.yaml").Parse(`
---
kind: Secret
apiVersion: v1
metadata:
  namespace: kube-system
  name: cloud-creds
data:
{{- if .CloudCreds.AWS}}
  aws_access_key_id: {{.CloudCreds.AWS.Base64encodeAccessKeyID}}
  aws_secret_access_key: {{.CloudCreds.AWS.Base64encodeSecretAccessKey}}
{{- else if .CloudCreds.OpenStack}}
  credentials: {{.CloudCreds.OpenStack.Base64encodeCloudCreds}}
{{- end}}
`))
)

{{/*
Vault annotations
*/}}
{{- define "ceilometer.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/ceilometer/ceilometer.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
   {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
   {{ print "[DEFAULT]" }}
   {{ print "transport_url={{ .Data.data.transport_url }}" }}
   {{ print "[notification]" }}
   {{ print "{{ .Data.data." .Values.siteName "_messaging_urls }}" }}
   {{ print "[publisher]" }}
   {{ print "telemetry_secret={{ .Data.data.telemetry_secret }}" }}
   {{ print "[service_credentials]" }}
   {{ print "password={{ .Data.data.service_credentials_password}}" }}
   {{ print "[bumblebee]" }}
   {{ print "password={{ .Data.data.bumblebee_password}}" }}
   {{ print "{{- end -}}" }}
vault.hashicorp.com/secret-volume-path-event_pipeline.yaml: /etc/ceilomter
vault.hashicorp.com/agent-inject-secret-event_pipeline.yaml: "{{ .Values.vault.event_pipeline}}"
vault.hashicorp.com/agent-inject-template-event_pipeline.yaml: |
  {{ print "{{- with secret \"" .Values.vault.event_pipeline "\" -}}" }}
  {{ print "{{ .Data.data.content }}" }}
  {{ print "{{- end -}}" }}
{{- end }}

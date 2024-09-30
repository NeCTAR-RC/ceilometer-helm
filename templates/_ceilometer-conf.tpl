{{- define "ceilometer-conf" }}
[DEFAULT]
http_timeout = {{ .Values.conf.http_timeout }}
debug = {{ .Values.conf.debug }}
polling_namespaces = {{ .Values.conf.polling_namespaces }}
event_pipeline_cfg_file = event_pipeline/event_pipeline.yaml

[network]
{{- if .Values.conf.network.ipavailability_project_filter }}
ipavailability_project_filter = {{ join "," .Values.conf.network.ipavailability_project_filter }}
{{- end }}

[notification]
batch_size = {{ .Values.conf.notification.batch_size }}
batch_timeout = {{ .Values.conf.notification.batch_timeout }}
workers = {{ .Values.conf.notification.workers }}

[oslo_messaging_notifications]
topics = notifications

[oslo_messaging_rabbit]
amqp_durable_queues = True
ssl = True
ssl_version = TLSv1_2
rabbit_ha_queues = True
rabbit_qos_prefetch_count = {{ .Values.conf.oslo_messaging_rabbit.rabbit_qos_prefetch_count }}

[service_credentials]
auth_type=password
auth_url = {{ .Values.conf.service_credentials.auth_url }}
username = {{ .Values.conf.service_credentials.username }}
project_name = {{ .Values.conf.service_credentials.project_name }}
user_domain_name = {{ .Values.conf.service_credentials.user_domain_name }}
project_domain_name = {{ .Values.conf.service_credentials.project_domain_name }}
region_name = {{ .Values.conf.service_credentials.region_name }}

[dispatcher_gnocchi]
{{- if .Values.conf.dispatcher_gnocchi.filter_project_ids }}
filter_project_ids = {{ join "," .Values.conf.dispatcher_gnocchi.filter_project_ids }}
{{- end }}

[bumblebee]
url = {{ .Values.conf.bumblebee.url }}
username = {{ .Values.conf.bumblebee.username }}

{{- end }}

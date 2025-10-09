{{- define "wordpress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.labels" -}}
helm.sh/chart: {{ include "wordpress.name" . }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: Helm
{{- end -}}

{{- define "wordpress.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}




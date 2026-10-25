{{/* Ім'я ресурсів = ім'я релізу (в Argo CD — ім'я Application) */}}
{{- define "lab-argo-app.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Мітки, за якими Service і Deployment знаходять поди. Незмінні між версіями */}}
{{- define "lab-argo-app.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Повний набір міток */}}
{{- define "lab-argo-app.labels" -}}
{{ include "lab-argo-app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end -}}

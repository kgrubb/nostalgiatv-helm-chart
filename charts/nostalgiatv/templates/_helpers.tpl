{{/*
Expand the name of the chart.
*/}}
{{- define "nostalgiatv.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nostalgiatv.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "nostalgiatv.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "nostalgiatv.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nostalgiatv.labels" -}}
app.kubernetes.io/name: {{ include "nostalgiatv.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "nostalgiatv.chart" . }}
{{- end -}}

{{- define "nostalgiatv.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nostalgiatv.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "nostalgiatv.image" -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion -}}
{{- if .Values.image.digest -}}
{{- printf "%s@%s" .Values.image.repository .Values.image.digest -}}
{{- else -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end -}}
{{- end -}}

{{- define "nostalgiatv.pvcName" -}}
{{- if .Values.persistence.existingClaim -}}
{{- .Values.persistence.existingClaim -}}
{{- else -}}
{{- printf "%s-data" (include "nostalgiatv.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "nostalgiatv.createPvc" -}}
{{- ternary "true" "false" (and .Values.persistence.enabled (empty .Values.persistence.existingClaim)) -}}
{{- end -}}

{{- define "nostalgiatv.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "nostalgiatv.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "nostalgiatv.weatherSecretName" -}}
{{- if .Values.weather.existingSecret -}}
{{- .Values.weather.existingSecret -}}
{{- else -}}
{{- printf "%s-weather" (include "nostalgiatv.fullname" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "nostalgiatv.createWeatherSecret" -}}
{{- ternary "true" "false" (and (ne .Values.weather.apiKey "") (empty .Values.weather.existingSecret)) -}}
{{- end -}}

{{/*
Pod securityContext with fsGroup defaulting to pgid when unset.
*/}}
{{- define "nostalgiatv.podSecurityContext" -}}
{{- $ctx := deepCopy (.Values.podSecurityContext | default dict) -}}
{{- if not (hasKey $ctx "fsGroup") -}}
{{- $_ := set $ctx "fsGroup" (.Values.pgid | int) -}}
{{- end -}}
{{- toYaml $ctx -}}
{{- end -}}

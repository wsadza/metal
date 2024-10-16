{{/* vim: set filetype=mustache: */}}

{{/*
**********************
General - Naming 
**********************
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "metal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this 
  (for example, by the DNS naming spec). 
If release name contains chart name it will be used as a full name.
*/}}
{{- define "metal.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for component.

Example:
  {{ 
    include "camundaPlatform.componentFullname" 
    ( dict "componentName" "foo" "componentValues" .Values.foo "context" $) 
  }}
*/}}
{{- define "metal.componentFullname" -}}
    {{- if (.componentValues).fullnameOverride -}}
        {{- .componentValues.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
        {{- $name := default .componentName (.componentValues).nameOverride -}}
        {{- if contains $name .context.Release.Name -}}
            {{- .context.Release.Name | trunc 63 | trimSuffix "-" -}}
        {{- else -}}
            {{- printf "%s-%s" .context.Release.Name $name | trunc 63 | trimSuffix "-" -}}
        {{- end -}}
    {{- end -}}
{{- end -}}

{{/*
**********************
General - Labels
**********************
*/}}

{{/*
Selector labels
*/}}
{{- define "metal.matchLabels" -}}
{{- if .Values.global.lables -}}
{{ toYaml .Values.global.labels }}
{{- end -}}
app.kubernetes.io/name: {{ template "metal.name" . }} 
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: metal 
{{- end -}}

{{/*
Define common labels, 
  combining the match labels and transient labels, 
  which might change on updating (version depending). 

These labels should not be used on matchLabels selector, 
  since the selectors are immutable.

*/}}
{{- define "metal.labels" -}}
{{- template "metal.matchLabels" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{/*
Defines extra labels for optimize.
*/}}
{{ define "metal.extraLabels" -}}
app.kubernetes.io/component: metal 
{{- end }}


{{/*
********************************************************************************
General - Image
********************************************************************************
*/}}

{{/*
Set image according the values of "base" or "overlay" values.
If the "overlay" values exist, 
  they will override the "base" values, 
  otherwise the "base" values will be used.

Usage: 
  {{ include "camundaPlatform.imageByParams" 
     ( dict "base" .Values.global "overlay" .Values.retentionPolicy) 
  }}

*/}}
{{- define "metal.imageByParams" -}}
    {{- $imageRegistry    := .base.image.registry -}}
    {{- $imageRepository  := .base.image.repository -}}
    {{- $imagePackage     := .base.image.package -}}
    {{- $imageTag         := .base.image.tag -}}

    {{- printf "%s%s%s:%s"
        (empty $imageRegistry | ternary "" (printf "%s/" $imageRegistry))
        (empty $imageRepository | ternary "" (printf "%s/" $imageRepository))
        $imagePackage
        $imageTag
    -}}
{{- end -}}

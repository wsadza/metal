{{/* vim: set filetype=mustache: */}}

{{/*
Defines extra labels for optimize.
*/}}
{{ define "stream.extraLabels" -}}
app.kubernetes.io/component: stream 
{{- end }}

{{/*
Define common labels for optimize, combining the match labels and transient labels, which might change on updating
(version depending). These labels shouldn't be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "stream.labels" -}}
    {{- include "stream.extraLabels" . }}
{{- end -}}

{{/*
Set image according the values of "base" or "overlay" values.
If the "overlay" values exist, they will override the "base" values, otherwise the "base" values will be used.
Usage: {{ include "camundaPlatform.imageByParams" (dict "base" .Values.global "overlay" .Values.retentionPolicy) }}
*/}}
{{- define "stream.imageByParams" -}}
    {{- $imageRegistry := .base.image.registry -}}
    {{- printf "%s%s%s:%s"
        $imageRegistry
        (empty $imageRegistry | ternary "" "/")
        (.base.image.repository)
        (.base.image.tag)
    -}}
{{- end -}}

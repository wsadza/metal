{{/* vim: set filetype=mustache: */}}

{{/*
Defines extra labels for optimize.
*/}}
{{ define "coturn.extraLabels" -}}
app.kubernetes.io/component: metal 
{{- end }}

{{/*
Define common labels for optimize, combining the match labels and transient labels, which might change on updating
(version depending). These labels shouldn't be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "coturn.labels" -}}
    {{- include "extraLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "coturn.matchLabels" -}}
{{- template "metal.matchLabels" . }}
app.kubernetes.io/component: coturn 
{{- end -}}

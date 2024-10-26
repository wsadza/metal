{{/* vim: set filetype=mustache: */}}

{{/*
**********************
stream - Naming 
**********************
*/}}

{{- define "stream.name" -}}
    {{- default .Chart.Name .Values.stream.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "stream.fullname" -}}
    {{- include "metal.componentFullname" (dict
        "componentName" "stream"
        "componentValues" .Values.stream
        "context" $
    ) -}}
{{- end -}}

{{/*
**********************
stream - Labels
**********************
*/}}

{{/*
Defines extra labels for optimize.
*/}}
{{- define "stream.extraLables" -}}
app.kubernetes.io/component: stream 
{{- end -}}

{{/*
Define common labels, combining the match labels and transient labels, which might change on updating
(version depending). These labels should not be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "stream.labels" -}}
{{- template "metal.labels" . }}
{{ template "stream.extraLables" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "stream.matchLabels" -}}
{{- template "metal.matchLabels" . }}
app.kubernetes.io/component: stream 
{{- end -}}

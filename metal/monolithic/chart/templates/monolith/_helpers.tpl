{{/* vim: set filetype=mustache: */}}

{{/*
**********************
Monolith - Naming 
**********************
*/}}

{{- define "monolith.name" -}}
    {{- default .Chart.Name .Values.monolith.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "monolith.fullname" -}}
    {{- include "metal.componentFullname" (dict
        "componentName" "monolith"
        "componentValues" .Values.monolith
        "context" $
    ) -}}
{{- end -}}

{{/*
**********************
Monolith - Labels
**********************
*/}}

{{/*
Defines extra labels for optimize.
*/}}
{{- define "monolith.extraLables" -}}
app.kubernetes.io/component: monolith 
{{- end -}}

{{/*
Define common labels, combining the match labels and transient labels, which might change on updating
(version depending). These labels should not be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "monolith.labels" -}}
{{- template "metal.labels" . }}
{{ template "monolith.extraLables" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "monolith.matchLabels" -}}
{{- template "metal.matchLabels" . }}
app.kubernetes.io/component: monolith 
{{- end -}}

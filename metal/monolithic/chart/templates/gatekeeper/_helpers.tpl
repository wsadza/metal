{{/* vim: set filetype=mustache: */}}

{{/*
**********************
Gatekeeper - Naming 
**********************
*/}}

{{- define "gatekeeper.name" -}}
    {{- default .Chart.Name .Values.gatekeeper.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gatekeeper.fullname" -}}
    {{- include "metal.componentFullname" (dict
        "componentName" "gatekeeper"
        "componentValues" .Values.gatekeeper
        "context" $
    ) -}}
{{- end -}}

{{/*
**********************
Gatekeeper - Labels
**********************
*/}}

{{/*
Defines extra labels for optimize.
*/}}
{{- define "gatekeeper.extraLables" -}}
app.kubernetes.io/component: gatekeeper 
{{- end -}}

{{/*
Define common labels, combining the match labels and transient labels, which might change on updating
(version depending). These labels should not be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "gatekeeper.labels" -}}
{{- template "metal.labels" . }}
{{ template "gatekeeper.extraLables" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "gatekeeper.matchLabels" -}}
{{- template "metal.matchLabels" . }}
app.kubernetes.io/component: gatekeeper 
{{- end -}}

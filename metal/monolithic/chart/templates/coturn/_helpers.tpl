{{/* vim: set filetype=mustache: */}}

{{/*
**********************
Coturn - Naming 
**********************
*/}}

{{- define "coturn.name" -}}
    {{- default .Chart.Name .Values.coturn.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "coturn.fullname" -}}
    {{- include "metal.componentFullname" (dict
        "componentName" "coturn"
        "componentValues" .Values.coturn
        "context" $
    ) -}}
{{- end -}}

{{/*
**********************
Coturn - Labels
**********************
*/}}

{{/*
Defines extra labels for optimize.
*/}}
{{- define "coturn.extraLables" -}}
app.kubernetes.io/component: coturn 
{{- end -}}

{{/*
Define common labels, combining the match labels and transient labels, which might change on updating
(version depending). These labels should not be used on matchLabels selector, since the selectors are immutable.
*/}}
{{- define "coturn.labels" -}}
{{- template "metal.labels" . }}
{{ template "coturn.extraLables" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "coturn.matchLabels" -}}
{{- template "metal.matchLabels" . }}
app.kubernetes.io/component: coturn 
{{- end -}}

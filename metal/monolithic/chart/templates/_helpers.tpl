{{/*
Set image according the values of "base" or "overlay" values.
If the "overlay" values exist, they will override the "base" values, otherwise the "base" values will be used.
Usage: {{ include "camundaPlatform.imageByParams" (dict "base" .Values.global "overlay" .Values.retentionPolicy) }}
*/}}
{{- define "imageByParams" -}}
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

{{/*
NAMING:
*/}}

{{- define "chart.applicationName" -}}
{{- .Values.metal.nameOverride | default "app" -}}
{{- end -}}

{{- define "chart.fullname" -}}
{{- printf "%s-%s" .Chart.Name (include "chart.applicationName" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "container1" -}}
- name: new-container1
  image: "{{ .Values.deployment.image.app }}:{{ .Values.deployment.image.version}}"
{{- end -}}
{{- define "container2" -}}
- name: new-container2
  image: "{{ .Values.deployment.image.app }}:{{ .Values.deployment.image.version}}"
{{- end -}}

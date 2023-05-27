kubectl: 
  pkg.installed:
    - names:
       - kubectl
       - helm
       - k9s
       - minikube
       - skaffold
       - kubebuilder
       - kustomize
       - clusterctl
       # - vmware-tanzu-labs/tap/yot
       # - vmware-tanzu-labs/tap/operator-builder
       
kubernetes-envs:
  file.recurse:
    - name: {{ pillar['xdg_config_home'] }}/env/kubernetes
    - source: salt://kubernetes/env
    - clean: true
    - makedirs: true
    - user: {{ grains['user'] }}

konfig:
  cmd.run:
    - name: "kubectl krew install konfig"
    - user: {{ grains['user'] }}
    - runas: {{ grains['user'] }}

blame:
  cmd.run:
    - name: "kubectl krew install blame"
    - user: {{ grains['user'] }}
    - runas: {{ grains['user'] }}

neat:
  cmd.run:
    - name: "kubectl krew install neat"
    - user: {{ grains['user'] }}
    - runas: {{ grains['user'] }}

split-yaml:
  cmd.run:
    - name: "kubectl krew install split-yaml"
    - user: {{ grains['user'] }}
    - runas: {{ grains['user'] }}

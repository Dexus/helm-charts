cluster.name: {{.Values.monasca_elasticsearch_cluster_name}}

cloud:
  kubernetes:
    service: es-master
    namespace: {{.Values.monasca_namespace}} 

node:
  master: ${NODE_MASTER}
  data: ${NODE_DATA}

path:
  data: /data/data
  logs: /data/log
  plugins: /elasticsearch/plugins
  work: /data/work


security.manager.enabled: false

network.host: 0.0.0.0
http.enabled: ${HTTP_ENABLE}
http.max_content_length: 500mb

discovery:
    type: kubernetes

discovery.zen.minimum_master_nodes: 2

readonlyrest:
    enable: true
    response_if_req_forbidden: <h1>Forbidden</h1>    
    access_control_rules:

    - name: Monsoon (read only, but can create dashboards)
      type: allow
      kibana_access: ro
      auth_key: {{.Values.monasca_elasticsearch_monsoon_user}}:{{.Values.monasca_elasticsearch_monsoon_password}}

    - name: data
      type: allow
      actions: ["indices:data/read/*","indices:data/write/*","indices:admin/template/*","indices:admin/create","indices:data/write/bulk"]
      indices: ["logstash-*", "<no-index>"]
      auth_key: {{.Values.monasca_elasticsearch_data_user}}:{{.Values.monasca_elasticsearch_data_password}}

    - name: audit
      type: allow
      actions: ["indices:data/read/*","indices:data/write/*","indices:admin/template/*","indices:admin/create","indices:data/write/bulk"]
      indices: ["audit-*", "<no-index>"]
      auth_key: {{.Values.monasca_elasticsearch_audit_user}}:{{.Values.monasca_elasticsearch_audit_password}}
 
    - name: test
      type: allow
      actions: ["indices:data/read/*","indices:data/write/*","indices:admin/template/*","indices:admin/create","indices:data/write/bulk"]
      indices: ["testing-*", "<no-index>"]
      auth_key: {{.Values.monasca_elasticsearch_test_user}}:{{.Values.monasca_elasticsearch_test_password}}

    - name: Admin
      type: allow
      auth_key: {{.Values.monasca_elasticsearch_admin_user}}:{{.Values.monasca_elasticsearch_admin_password}}

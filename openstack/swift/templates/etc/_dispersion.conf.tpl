[dispersion]
auth_user = test_admin
user_domain_name = cc3test
project_name = swift_dispersion
project_domain_name = cc3test
auth_key = {{.Values.cc3test_admin_password}}
auth_url = {{.Values.keystone_auth_url}}
auth_version = 3
keystone_api_insecure = no
region_name = {{.Values.global.region}}

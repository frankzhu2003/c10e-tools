# Installation

* git clone caretta.repo

* helm install caretta ./chart -n caretta

* kubectl apply -f caretta-deploy.yaml

* Update nginx reverse proxy: /etc/nginx/nginx.conf
```
server { # simple reverse-proxy
        listen       80;
        server_name     caretta.local;
        # pass requests for dynamic content to rails/turbogears/zope, et al

        location / {
                proxy_pass      http://caretta.local:31834;
        }
}
```

* Install the ChronoCollector
```
git clone https://github.com/chronosphereio/saleseng-demo-prod

helm install caretta-chronocollector-svcmon ./chronocollector-servicemonitor-chart --set orgName=$CHRONOSPHERE_ORG_NAME --set apiToken=$CHRONOSPHERE_API_TOKEN -n caretta
```
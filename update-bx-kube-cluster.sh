#!/bin/bash
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" deployment.json > deployment-${BUILD_NUMBER}.json
curl --request POST   --url https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/0c0c42825753e26f312af08e746f1031faad1f0d2facda7e16faa2863f0a3dea/kubeDeploy/kubeDeploy   --header 'accept: application/json'   --header 'content-type: application/json'   --data @deployment-${BUILD_NUMBER}.json

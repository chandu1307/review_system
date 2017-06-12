#!/bin/bash

cat > review-system-service.json << EOF
{
   "apiVersion": "v1",
   "kind": "Service",
   "metadata": {
      "name": "${MS_NAME}",
      "labels": {
         "name": "${MS_NAME}"
      }
   },
   "spec":{
      "type": "LoadBalancer",
      "ports": [
         {
           "port": 80,
           "targetPort": "reveiw-system",
           "protocol": "TCP"
         }
      ],
      "selector":{
         "name":"${MS_NAME}"
      }
   }
}
EOF

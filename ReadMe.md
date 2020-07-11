## ElasticSearch Sandbox

### Requirements

- Mac OS
- Docker Desktop for Mac

### Run Elastic Stack Locally

- Execute `run.sh` file to create your local Elastic stack.
```bash
./run.sh
```
- Once executed, give it a minute or 2 for the services to come up and try accessing below urls'.
    - ElastiSearch - http://kubernetes.docker.internal:9200
    - Kibana - http://kubernetes.docker.internal:5601
- Check if the indices are being created using the below curl command.
```bash
curl  http://kubernetes.docker.internal:9200/_cat/indices\?v

health status index                              uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   metricbeat-7.7.0-2020.05.18-000001 j5Qr1_r2TZ2U8AjTgGTYsw   1   1        887            0      2.1mb          1.1mb
green  open   filebeat-7.7.0-2020.05.18-000001   2EKaTVRYRSWUPNYlIV0-pQ   1   1       4153            0        3mb          1.5mb
green  open   .apm-custom-link                   vKBMTuAgQRG1vkCcOiXHvA   1   1          0            0       416b           208b
green  open   .kibana_task_manager_1             ruds7wy3RsWOo4H6_Loukg   1   1          5            2     74.9kb         37.4kb
green  open   .apm-agent-configuration           STqKDvz_S-GDABqcrUCEoQ   1   1          0            0       416b           208b
green  open   .kibana_1                          9WmofEw0Rm28uEYw6Ky0fg   1   1         23            1     96.2kb         48.1kb
```

### Clean all the Services

- Execute `clean.sh` file to clean-up all the containers and deployments you have created for the sandbox setup.
```bash
./clean.sh
```

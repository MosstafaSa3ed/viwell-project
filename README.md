**Viwell APPS**

This Repo Contain the following:
1. Ansible playbook to deploy minikube on Ubuntu Machine
2. cronjob on kubernetes for periodic login to ECR
3. deploy.sh file to deploy the environment on kubernetes using helm
4. helm charts templates for both applications (airports & countries)


**1. Ansible playbook to deploy minikube on Ubuntu Machine**
To use Ansible playbook you need to install it on the target machine which gonna host minikube
you can run it from ./ansible dir with:
```
ansible-playbook main.yml
```
**2. cronjob on kubernetes for periodic login to ECR**
To create Token for ECR to pull images from it every hour you need to replace access_key and secret_access_key on this file with the provided ones.

**3. deploy.sh file to deploy the environment on kubernetes using helm**
Bash script with the aim to deploy our 2 applications using helm charts.

To use it you need to do the following:
1. After Adding the required access_key and secret_access_key in the previous step, uncomment "Creating CronJob for ECR Login" step.
2. Configure aws cli with the provided cred
3. run ``` sh deploy.sh ```

**4. helm charts templates for both applications (airports & countries)**
Helm chart template for easy maintance and easy deployment for all needed services with the application.
Each template contain the following:
1. deployment file
2. ingress using nginx-controller
3. service (ClusterIP)


   

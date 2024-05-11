
############# Setup AWS CLI first with the attached access key and secret access key ################

passwd=$(aws ecr get-login-password --region eu-west-3 | cut -d' ' -f6)
baseURL=622931036635.dkr.ecr.eu-west-3.amazonaws.com
airportsRepoURL=$baseURL/viwell-airports
countriesRepoURL=$baseURL/viwell-countries

aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin $baseURL
kubectl delete secret ecr -nviwell
kubectl create secret -nviwell docker-registry ecr --docker-server=$baseURL --docker-username=AWS --docker-password=$passwd

# ************* Replace values in file ./ecr-login/cronjob.yml then uncomment this section ***********
# echo "\n*******Creating CronJob for ECR Login******\n"
# kubectl apply -f ./ecr-login/cronjob.yaml

echo "\n*******Build and push docker image for airports******\n"
docker build -t $airportsRepoURL:1.0.1-v1 ./viwell-airports
docker push $airportsRepoURL:1.0.1-v1

echo "\n*******Build and push helm chart for airports******\n"
helm package ./viwell-airports/devops-tools/helm
helm push viwell-airports-1.0.1.tgz oci://$baseURL

echo "\n*******Deploy airports helm chart******\n"
helm upgrade --install viwell-airports -nviwell oci://$airportsRepoURL --version 1.0.1

echo "\n*******Build and push docker image for countries******\n"
docker build -t $countriesRepoURL:1.0.1-v1 ./viwell-countries
docker push $countriesRepoURL:1.0.1-v1

echo "\n*******Build and push helm chart for countries******\n"
helm package ./viwell-countries/devops-tools/helm
helm push viwell-countries-1.0.1.tgz oci://$baseURL

echo "\n*******Deploy countries helm chart******\n"
helm upgrade --install viwell-countries -nviwell oci://$countriesRepoURL --version 1.0.1
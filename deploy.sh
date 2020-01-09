docker build -t travistkirton/multi-client:latest -t travistkirton/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t travistkirton/multi-server:latest -t travistkirton/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t travistkirton/multi-worker:latest -t travistkirton/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push travistkirton/multi-client:latest
docker push travistkirton/multi-server:latest
docker push travistkirton/multi-worker:latest

docker push travistkirton/multi-client:$SHA
docker push travistkirton/multi-server:$SHA
docker push travistkirton/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=travistkirton/multi-server:$SHA
kubectl set image deployments/client-deployment client=travistkirton/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=travistkirton/multi-worker:$SHA
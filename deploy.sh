docker build -t mathildapurr/multi-client:latest -t mathildapurr/multi-client:$SHA -f ./client/Dockerfile ./client

docker build -t mathildapurr/multi-server:latest -t mathildapurr/multi-server:$SHA -f ./server/Dockerfile ./server

docker build -t mathildapurr/multi-worker:latest -t mathildapurr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mathildapurr/multi-client:latest
docker push mathildapurr/multi-server:latest
docker push mathildapurr/multi-worker:latest

docker push mathildapurr/multi-client:$SHA
docker push mathildapurr/multi-server:$SHA
docker push mathildapurr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mathildapurr/multi-server:$SHA
kubectl set image deployments/client-deployment client=mathildapurr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mathildapurr/multi-worker:$SHA
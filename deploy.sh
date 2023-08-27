docker build -t saishnaik/multi-client:latest -t saishnaik/multi-client:$SHA -f client/Dockerfile ./client
docker build -t saishnaik/multi-server:latest -t saishnaik/multi-server:$SHA -f server/Dockerfile ./server
docker build -t saishnaik/multi-worker:latest -t saishnaik/multi-worker:$SHA -f worker/Dockerfile ./worker
docker push saishnaik/multi-client:latest
docker push saishnaik/multi-server:latest
docker push saishnaik/multi-worker:latest
docker push saishnaik/multi-client:$SHA
docker push saishnaik/multi-server:$SHA
docker push saishnaik/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=saishnaik/multi-client:$SHA
kubectl set image deployments/server-deployment server=saishnaik/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=saishnaik/multi-worker:$SHA
docker build -t tareksaleh5/multi-client:latest -t tareksaleh5/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tareksaleh5/multi-server:latest -t tareksaleh5/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tareksaleh5/multi-worker:latest -t tareksaleh5/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tareksaleh5/multi-client:latest
docker push tareksaleh5/multi-server:latest
docker push tareksaleh5/multi-worker:latest

docker push tareksaleh5/multi-client:$SHA
docker push tareksaleh5/multi-server:$SHA
docker push tareksaleh5/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tareksaleh5/multi-server:$SHA
kubectl set image deployments/client-deployment client=tareksaleh5/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tareksaleh5/multi-worker:$SHA
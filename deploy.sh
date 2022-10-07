# 1. deployment
docker build -t freecode23/fibonacci-client-k8s:latest -t freecode23/fibonacci-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t freecode23/fibonacci-server-k8s:latest -t freecode23/fibonacci-server-k8s:$SHA -f ./server/Dockerfile ./server



docker build -t freecode23/fibonacci-worker-k8s:latest -t freecode23/fibonacci-worker-k8s:$SHA -f ./worker/Dockerfile ./worker
docker build -t freecode23/fibonacci-worker-k8s:latest -f ./worker/Dockerfile ./worker


# 2. push to docker hub
# push latest
docker push freecode23/fibonacci-client-k8s:latest
docker push freecode23/fibonacci-server-k8s:latest
docker push freecode23/fibonacci-worker-k8s:latest

# push unique version
docker push freecode23/fibonacci-client-k8s:$SHA
docker push freecode23/fibonacci-server-k8s:$SHA
docker push freecode23/fibonacci-worker-k8s:$SHA

# 3. apply
kubectl apply -f k8s

# 4. set image
kubectl set image deployments/server-deployment server=freecode23/fibonacci-server-k8s:$SHA
kubectl set image deployments/client-deployment client=freecode23/fibonacci-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=freecode23/fibonacci-worker-k8s:$SHA
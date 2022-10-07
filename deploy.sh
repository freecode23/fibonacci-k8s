# deployment
docker build -t freecode23/fibonacci-client-k8s -t freecode23/fibonacci-client-k8s -f ./client/Dockerfile ./client
docker build -t freecode23/fibonacci-server-k8s -t freecode23/fibonacci-server-k8s -f ./server/Dockerfile ./server
docker build -t freecode23/fibonacci-worker-k8s -t freecode23/fibonacci-worker-k8s -f ./worker/Dockerfile ./worker

docker push freecode23/fibonacci-client-k8s
docker push freecode23/fibonacci-server-k8s
docker push freecode23/fibonacci-worker-k8s

docker push freecode23/fibonacci-client-k8s
docker push freecode23/fibonacci-server-k8s
docker push freecode23/fibonacci-worker-k8s

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=freecode23/fibonacci-server-k8s
kubectl set image deployments/client-deployment client=freecode23/fibonacci-client-k8s
kubectl set image deployments/worker-deployment worker=freecode23/fibonacci-worker-k8s
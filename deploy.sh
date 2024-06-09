docker build -t vondoste/multi-client:latest -t vondoste/multi-client:$SHA -f ./client/Dockerfile ./client # $SHA defined in .travis.yml
docker build -t vondoste/multi-server:latest -t vondoste/multi-server:$SHA -f ./server/Dockerfile ./server # $SHA defined in .travis.yml
docker build -t vondoste/multi-worker:latest -t vondoste/multi-worker:$SHA -f ./worker/Dockerfile ./worker # $SHA defined in .travis.yml

docker push vondoste/multi-client:latest
docker push vondoste/multi-server:latest
docker push vondoste/multi-worker:latest

docker push vondoste/multi-client:$SHA
docker push vondoste/multi-server:$SHA
docker push vondoste/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=vondoste/multi-client:$SHA
kubectl set image deployments/server-deployment server=vondoste/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=vondoste/multi-worker:$SHA

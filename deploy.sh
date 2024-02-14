    - docker build -t aidenlambert94/multi-client:latest -t aidenlambert94/multi-client:$SHA -f ./client/Dockerfile ./client
    - docker build -t aidenlambert94/multi-server:latest -t aidenlambert94/multi-server:$SHA -f ./server/Dockerfile ./server
    - docker build -t aidenlambert94/multi-worker:latest -t aidenlambert94/multi-worker:$SHA -f ./worker/Dockerfile ./worker
    # Log in to the docker CLI
    # Take those images and push them to docker hub
    - docker push aidenlambert94/multi-client
    - docker push aidenlambert94/multi-server
    - docker push aidenlambert94/multi-worker
    # Apply all configs in the k8s folder
    - kubectl apply -f k8s
    # Imperatively set latest images on each deployment
    - kubectl set image deployments/server-deployment server=aidenlambert94/multi-server:$SHA
    - kubectl set image deployments/client-deployment client=aidenlambert94/multi-client:$SHA
    - kubectl set image deployments/worker-deployment worker=aidenlambert94/multi-worker:$SHA
    ## kubectl set image deployment/client-deployment client=aidenlambert94/multi-client:$SHA

node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = 'latest'
    appName = "rothstocks"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:${tag}"
    imageNameTest = "${registryHost}${appName}_test:${tag}"
    env.BUILDIMG=imageName

    stage("Build"){
    
        sh "docker build -t ${imageName} -f ./Dockerfile ./"
        sh "docker build -t ${imageNameTest} -f ./Dockerfile.test ./"
    }
    stage("Push"){

        sh "docker push ${imageName}"
        sh "docker push ${imageNameTest}"
    }
    stage("Test"){
        sh "kubectl delete --ignore-not-found=true --namespace app-test -f k8s/rothstocks_tests_job.yaml"
        sh "kubectl apply --namespace app-test -f k8s/rothstocks_tests_job.yaml"
        sh "until kubectl get pod \$(kubectl get pods --namespace app-test -l 'job-name=tests' -o jsonpath='{.items[0].metadata.name}') --namespace app-test -o jsonpath='{.status.conditions[?(@.type==\"Ready\")].status}' | grep True ; do sleep 15; done"
        sh "kubectl --namespace app-test logs --pod-running-timeout=2m -f pod/\$(kubectl get pods --namespace app-test -l 'job-name=tests' -o jsonpath='{.items[0].metadata.name}')"
    }
    stage("Deploy"){

        sh "kubectl delete --ignore-not-found=true --namespace default -f k8s/rothstocks_setup_job.yaml"
        sh "kubectl apply --namespace default -f k8s/rothstocks_setup_job.yaml"
        sh "sleep 15"
        sh "until kubectl get jobs setup --namespace default -o jsonpath='{.status.conditions[?(@.type==\"Complete\")].status}' | grep True ; do sleep 15; done"
        sh "kubectl apply --namespace default -f k8s/rothstocks_service.yaml"
        sh "sed 's#127.0.0.1:30400/rothstocks:latest#'$BUILDIMG'#' k8s/rothstocks_deployment.yaml | kubectl apply --namespace default -f -"
        sh "kubectl rollout status --namespace default deployment/rothstocks-deployment"
        sh "sleep 15"
        sh "kubectl set image deployment/rothstocks-deployment --namespace default rothstocks=127.0.0.1:30400/rothstocks:latest"
        sh "kubectl set image deployment/rothstocks-deployment --namespace default rothstocks=127.0.0.1:30400/rothstocks"
    }
}

node {

    checkout scm

    env.DOCKER_API_VERSION="1.23"
    
    sh "git rev-parse --short HEAD > commit-id"

    tag = readFile('commit-id').replace("\n", "").replace("\r", "")
    appName = "RothStocks"
    registryHost = "127.0.0.1:30400/"
    imageName = "${registryHost}${appName}:${tag}"
    env.BUILDIMG=imageName

    stage("Build"){
    
        sh "docker build -t ${imageName} -f ./Dockerfile ./"
    }
    stage("Push"){

        sh "docker push ${imageName}"
    }
    stage("Deploy"){

        sh "kubectl create -f railsapp_setup_job.yaml"
        sh "kubectl create -f railsapp_service.yaml"
        sh "sed 's#127.0.0.1:30400/RothStocks:latest#'$BUILDIMG'#' railsapp_deployment.yaml | kubectl apply -f -"
        sh "kubectl rollout status deployment/RothStocks"
    }
}

node {
    def registry = 'mktavish/udacity-capstone-project'
    stage('Checking out git repo') {
      echo 'Checkout...'
      checkout scm
    }
    stage('Checking environment') {
      echo 'Checking environment...'
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'docker -v'
    }
    stage("Linting") {
      echo 'Linting...'
        sh '''#!/bin/bash'''
        sh 'hadolint Dockerfile'
    }
    stage('Building image') {
	    echo 'Building Docker image...'
	     	sh "sudo docker build . -t mktavish/capstone-project:v2"
    }
    stage('Deploying') {
      echo 'Deploying to AWS...'
      dir ('./') {
        withAWS(credentials: 'aws-eks', region: 'us-east-1', serverUrl: 'https://35F1FCB6DE7E415B2958ED21E4242350.gr7.us-east-1.eks.amazonaws.com') {
           
            
            sh "kubectl -n udacity-capstone-storeapp set image deployments/udacity-capstone-storeapp  udacity-capstone-storeapp=mktavish/capstone-project:v2"
            sh "kubectl apply -f aws/capstone-storeapp-deployment.yml"
            sh "kubectl get nodes"
            sh "kubectl get pods"
            sh "aws cloudformation update-stack --stack-name udacity-capstone-nodes --template-body file://aws/worker_nodes.yml --parameters file://aws/worker_nodes_parameters.json --capabilities CAPABILITY_IAM"
        }
      }
    }
    stage("Cleaning up") {
      echo 'Cleaning up...'
      sh "docker system prune"
    }
}

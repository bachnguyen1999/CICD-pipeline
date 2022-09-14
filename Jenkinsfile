pipeline{
    agent any
    tools {
      maven 'maven'
    }
    environment {
      DOCKER_TAG = getVersion()
      GITBRANCH = "${GIT_BRANCH.tokenize('/').pop()}"
    }
    stages{
        stage('SCM'){
            }
            steps{
                git credentialsId: 'github', 
                    url: 'https://github.com/bachnguyen1999/CICD-pipeline.git'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build'){
            when{
                 expression { GITBRANCH == "dev" }
            }
            steps{
                sh "docker build . -t bachnguyen18/image:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'dockerhub_passwd', variable: 'dockerHubPwd')]) {
                    sh "docker login -u bachnguyen18 -p ${dockerHubPwd}"
                }
                
                sh "docker push bachnguyen18/image:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
            steps{
              ansiblePlaybook credentialsId: 'docker-host', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}

pipeline {
    environment {
        IMAGEN = "legnakra/crudphp"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("Push") {
            agent any
            stages {
                stage('Clone') {
                    steps {
                        git branch:'main',url:'https://github.com/Legnakra/Crudphp-Jenkins'
                    }
                }
                stage('Build') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN:latest"
                        }
                    }
                }
                stage('Upload') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('Remove') {
                    steps {
                        sh "docker rmi $IMAGEN:latest"
                    }
                }
                stage ('SSH') {
    steps{
        sshagent(credentials : ['SSH_ROOT']) {
            sh 'ssh -o StrictHostKeyChecking=no maria@mariatec.es wget https://raw.githubusercontent.com/Legnakra/Crudphp-Jenkins/main/docker-compose.yaml -O docker-compose.yaml'
            sh 'ssh -o StrictHostKeyChecking=no maria@mariatec.es sudo docker compose up -d --force-recreate'
        }
    }
}
            }
        }           
    }
}

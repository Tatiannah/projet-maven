pipeline {
    agent any
    stages {
        stage('git checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Tatiannah/maven_projet.git',
                    credentialsId: 'Github-Credentials'
            }
        }
        stage('Build the application') {
            steps {
                bat 'mvn clean install'
            }
        }
        stage('Unit Test Execution') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Build the docker image') {
            steps {
                bat 'docker build -t tatiannah/triang7:1.0.0 .'
            }
        }
        stage('Push docker image') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhubpass',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                    bat 'docker push tatiannah/triang7:1.0.0'
                }
            }
        }
    }       
    post {
        failure {
            emailext body: 'Ce Build $BUILD_NUMBER a échoué',
                     recipientProviders: [requestor()],
                     subject: 'Build échoué',
                     to: 'raltaty1704@gmail.com'
        }
        success {
            emailext body: 'Ce Build $BUILD_NUMBER a réussi',
                     recipientProviders: [requestor()],
                     subject: 'Build réussi',
                     to: 'raltaty1704@gmail.com'
        }
    }
}
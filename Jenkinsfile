pipeline {
    agent {
     label 'agent'
    }
    environment {
        // Define environment variables
        REPO_URL = 'https://github.com/MahmoudAbelaziz22/ecommerceBIS.git'
    }

    stages {
        stage('Clone and Run Docker Compose') {
            when {
                expression {
                    changeset ".*"
                }
            }
            steps {
                // Clone the repository
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: "${REPO_URL}"]]])

                // Change to the repository directory
                dir("ecommerceBIS") {
                    // Start Docker Compose
                    sh "docker-compose down"
                    sh "docker-compose up -d"
                }
            }
        }
    }
}

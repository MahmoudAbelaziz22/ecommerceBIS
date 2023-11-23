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
            steps {
                // Clone the repository
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: "${REPO_URL}"]]])

                // Change to the repository directory
                dir("ecommerceBIS") {
                    // Start Docker Compose
                    sh "docker-compose down"
                    sh "docker-compose up -d"
                    sh "docker-compose run app rm -rf vendor composer.lock"
                    sh "docker-compose run app composer install"
                    sh "docker-compose run app php artisan key:generate"
                }
            }
        }
    }
}

pipeline {
    agent any

    environment {
        IMAGE_NAME = 'kotlin-spring:latest'
    }

    stages {
        stage('Clone') {
            steps {
                echo '소스 코드 클론 중...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Maven 빌드 중...'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Docker 이미지 빌드 중...'
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Docker Run') {
            steps {
                echo '기존 컨테이너 정리 후 새로 실행'
                sh """
                    docker stop spring-app || true
                    docker rm spring-app || true
                    docker run -d --name spring-app -p 8080:8080 ${IMAGE_NAME}
                """
            }
        }
    }
}
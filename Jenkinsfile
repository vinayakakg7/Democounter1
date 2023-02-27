pipeline{
    agent any

    tools {
        maven 'maven'
        jdk 'Java'
    }

    environment{
        GIT_REPO = 'https://github.com/vinayakakg7/Democounter1.git'
        GIT_BRANCH = 'main'
        DOCKER_NAMESPACE = "vinayakakg7"
    }
    stages {
        stage('Clone Git repository') {
            steps {
                git branch: GIT_BRANCH, url: GIT_REPO
            }
        }
    stage('Build and test using Maven') {
            steps {
                bat 'mvn clean install -DskipTests=true'
            }
        }
    stage('Run SonarQube analysis') {
          steps {

             script{
                withSonarQubeEnv(credentialsId: 'sonarapi') {
                    bat 'mvn clean package sonar:sonar'
               }
           }
           }
       }
       
    stage('Check quality gate status') {
        steps {
            script {
                def qg = waitForQualityGate()
                if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
               }
            }
    }

    stage('Docker image build'){
      steps{
        script{
			def imageTag = "${DOCKER_NAMESPACE}/${env.JOB_NAME}:${env.BUILD_ID}"
			 bat "docker build -t ${imageTag} -f Dockerfile ."
        }
      }
    }
     
}
}
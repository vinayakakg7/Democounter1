pipeline {
    agent any
    
    tools {
        maven 'maven'
        jdk 'Java'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
        NEXUS_URL = 'http://13.233.111.214:8081'
        GIT_REPO = 'https://github.com/vinayakakg7/DemoCounter.git'
        GIT_BRANCH = 'main'
        NEXUS_SNAPSHOT_REPO = 'demo_snapshot'
        NEXUS_RELEASE_REPO = 'demo_release'
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
        
        stage('Upload JAR to Nexus repository') {
            steps {
                script {
                    def pom = readMavenPom file: 'pom.xml'
                    def version = pom.version
                    def snapshot = version.endsWith('-SNAPSHOT')
                    
                    def repo = snapshot ? NEXUS_SNAPSHOT_REPO : NEXUS_RELEASE_REPO
                    def url = "${NEXUS_URL}/repository/${repo}/"
                    
                    withCredentials([usernamePassword(credentialsId: 'nexus_cred', passwordVariable: 'NEXUS_PASSWORD', usernameVariable: 'NEXUS_USERNAME')]) {
                        sh "mvn deploy:deploy-file -DgroupId=${pom.groupId} -DartifactId=${pom.artifactId} -Dversion=${version} -Dpackaging=jar -Dfile=target/${pom.artifactId}-${version}.jar -Durl=${url} -DrepositoryId=nexus -DgeneratePom=false -DpomFile=pom.xml -Drepository.username=${NEXUS_USERNAME} -Drepository.password=${NEXUS_PASSWORD}"
                    }
                }
            }
        }
    }
}

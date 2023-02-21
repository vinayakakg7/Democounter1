pipeline {
    agent any
    
    tools {
        maven 'maven'
        jdk 'Java'
    }
    
    environment {
        SONAR_HOST_URL = 'http://localhost:9000'
       // NEXUS_URL = '13.232.22.30:8081'
        GIT_REPO = 'https://github.com/vinayakakg7/DemoCounter.git'
        GIT_BRANCH = 'main'
        NEXUS_SNAPSHOT_REPO = 'demo_snapshot'
        NEXUS_RELEASE_REPO = 'demo_release'
        TOMCAT_HOME = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0" // Path to Tomcat installation
        JAR_FILE = "Uber.jar" // Name of the JAR file to deploy
        CONTEXT_PATH = "Uber" // Context path for the application
        WAR_FILE = "${CONTEXT_PATH}.jar" // Name of the WAR file to create
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
        
      //  stage('Upload JAR to Nexus repository') {

        //    steps {

          //      script {
            //        def pom = readMavenPom file: 'pom.xml'
              //      def version = pom.version
                //    env.version = version
                  //  def snapshot = version.endsWith('-SNAPSHOT')
                    
                    //def repo = snapshot ? NEXUS_SNAPSHOT_REPO : NEXUS_RELEASE_REPO
                   // env.repo = repo
                  
                    //def groupId = pom.groupId
                   // env.groupId = groupId

        
                   // nexusArtifactUploader artifacts: [
                     //       [artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']
                       //     ], 
                         //   credentialsId: 'nexus_cred', 
                           // groupId: "${env.groupId}", 
                            //nexusUrl: '13.232.22.30:8081',
                            //nexusVersion: 'nexus3', 
                            //protocol: 'http',
                            //repository: "${env.repo}", 
                           // version: "${env.version}"

                    //}
             
                    
                    //}
               // }
       stage('Deploy') {
            steps {
                bat "xcopy /Y /S ${WAR_FILE} ${TOMCAT_HOME}\\webapps\\" // Copy the WAR file to Tomcat's webapps directory
                bat "net stop Tomcat9" // Stop Tomcat
                bat "net start Tomcat9" // Start Tomcat
            }
        }
        }
}
    



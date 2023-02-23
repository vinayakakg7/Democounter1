pipeline {
    agent any

   // @Grab(group='org.apache.tomcat.maven', module='tomcat-maven-plugin', version='3.2')

    tools {
        maven 'maven'
        jdk 'Java'
    }
    
    environment {
        //SONAR_HOST_URL = 'http://localhost:9000'
       // NEXUS_URL = '13.232.22.30:8081'
        GIT_REPO = 'https://github.com/vinayakakg7/DemoCounter.git'
        GIT_BRANCH = 'main'
      //  NEXUS_SNAPSHOT_REPO = 'demo_snapshot'
      //  NEXUS_RELEASE_REPO = 'demo_release'
        TOMCAT_URL = "http://13.235.75.30:8084"
        //TOMCAT_USER = "admin"
        //TOMCAT_PASSWORD = "P@ssw0rdkgv1"
        //WAR_FILE = "**/*.jar"

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
        
 //       stage('Check quality gate status') {
 //           steps {
 //               script {
  //                  def qg = waitForQualityGate()
  //                  if (qg.status != 'OK') {
  //                      error "Pipeline aborted due to quality gate failure: ${qg.status}"
  //                  }
   //             }
   //         }
   //     }
        
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
                deploy(
                    adapters: [
                        tomcat9(credentialsId: 'tomcatcred', url: 'http://localhost:8082/manager/text')
                    ],
                    contextPath: 'Uber/',
                    war: '**/*.Jar'
                )
          

       
        //sshagent(['Tomcat_User']) {
          //sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.235.75.30 "sudo systemctl tomcat stop && sudo rm -rf /opt/tomcat/webapps/.jar && sudo cp C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\DemoApp\\target\\.jar /opt/tomcat/webapps/ && sudo systemctl tomcat start"'
         // }
            

         
            }
          }
    }
}
      
    
  


    



pipeline {
    
    agent any 
    
    stages {
        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'main', url: 'https://github.com/vinayakakg7/DemoCounter.git'
                }
            }
        }
        stage('UNIT testing'){
            
            steps{
                
                script{
                    
                    bat 'mvn test'
                }
            }
        }
        stage('Integration testing'){
            
            steps{
                
                script{
                    
                    bat 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven build'){
            
            steps{
                
                script{
                    
                    bat 'mvn clean install'
                }
            }
        }
        stage('Static code Analysis'){

            steps{

                script{
                    withSonarQubeEnv(credentialsId: 'sonarapi') {
                    bat 'mvn clean package sonar:sonar'
                    }
                }
            }
        }

        //stage('Quality Gate Status'){
                
          //      steps{
                    
            //        script{
              //          waitForQualityGate abortPipeline: false, credentialsId: 'sonarapi'
                //    }
                //}
      //  }

        stage('upload jar to nexus repo'){
                
                steps{

                    
                    script{

                       def pom = readMavenPom file: 'pom.xml'

                       // def nexusrepo = readMavenPom.version.endsWith("SNAPSHOT") ? "demo_snapshot" : "demo_release"

                        nexusArtifactUploader artifacts: [
                            [artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']
                            ], 
                            credentialsId: 'nexus_cred', 
                            groupId: 'com.example', 
                            nexusUrl: '13.233.111.214:8081',
                            nexusVersion: 'nexus3', 
                            protocol: 'http',
                            repository: 'demo_snapshot', 
                            version: '1.0.1-SNAPSHOT'

                    }
             
          }

        }

 
    }
}

pipeline{
    
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
    }
}
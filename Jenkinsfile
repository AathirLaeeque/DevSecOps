
pipeline {
  agent { label 'build' }
   environment { 
        registry = "aathir007/democicd" 
        registryCredential = 'dockerhub' 
   }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'release', credentialsId: 'GitCred', url: 'https://github.com/AathirLaeeque/DevSecOps.git'
      }
    }
  
   stage('Stage I: Build') {
      steps {
        echo "Building Jar Component ..."
        sh "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64; mvn clean install -D maven.test.skip=true"
      }
    }

   stage('Stage II: Code Coverage ') {
      steps {
	    echo "Running Code Coverage ..."
        sh "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64; mvn jacoco:report"
      }
    }

   stage('Stage III: SCA') {
      steps { 
        echo "Running Software Composition Analysis using OWASP Dependency-Check ..."
        sh "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64; mvn org.owasp:dependency-check-maven:12.1.0:check"
      }
    }

   stage('Stage IV: SAST') {
      steps { 
        echo "Running Static application security testing using SonarQube Scanner ..."
        withSonarQubeEnv('mysonar') {
            sh 'mvn sonar:sonar -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml -Dsonar.dependencyCheck.jsonReportPath=target/dependency-check-report.json -Dsonar.dependencyCheck.htmlReportPath=target/dependency-check-report.html -Dsonar.projectName=demodevsecops'
       }
      }
    }

   stage('Stage V: QualityGates') {
      steps { 
        echo "Running Quality Gates to verify the code quality"
        script {
          timeout(time: 1, unit: 'MINUTES') {
            def qg = waitForQualityGate()
            if (qg.status != 'OK') {
              error "Pipeline aborted due to quality gate failure: ${qg.status}"
            }
           }
        }
      }
    }
   
   stage('Stage VI: Build Image') {
      steps { 
        echo "Build Docker Image"
        script {
               docker.withRegistry( '', registryCredential ) { 
                 myImage = docker.build registry
                 myImage.push()
                }
        }
      }
    }
        
   stage('Stage VII: Scan Image ') {
      steps { 
        echo "Scanning Image for Vulnerabilities"
        sh "trivy image --scanners vuln --offline-scan aathir007/democicd:latest > trivyresults.txt"
        }
    }
          
   stage('Stage VIII: Smoke Test ') {
      steps { 
        echo "Smoke Test the Image"
        sh "docker run -d --name smokerun -p 8080:8080 aathir007/democicd"
		  
		echo "=== Checking running containers ==="
   	    docker ps -a
    
  		echo "=== Waiting for app ==="
    	sleep 120
    
        sh "sleep 90; ./check.sh"
        sh "docker rm --force smokerun"
        }
    }

  }
}

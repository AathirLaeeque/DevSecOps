
<html><body><h1 style="font-size:50px;color:blue;">CLOUD WITH AATHIR | <font style="color:red;"> www.cloudwidaathir.com | <font style="color:green;"> +91-8618198639 </h1>
<h1> Please follow my Youtube/GitHub account for Projects related to DevSecOps: 
<a href="coming soon...">https://github.com/AathirLaeeque</a> </h1>
</body></html>


# PRODUCTION GRADE DEVSECOPS CICD Pipeline

## Prereq: Create 2 EC2 servers
- [ ] Build server with 15GB storage - t2.mirco
- [ ] Sonarqube server with 4 GB memory - t2.medium

## Step 1: Ensure all the necessary plugins are installed in Jenkins Master
- [ ] Parameterized trigger plugin
- [ ] Gitlab plugin, Git and JDK Plugin
- [ ] Docker Pipeline
- [ ] Pipeline: AWS steps
- [ ] SonarQube Scanner
- [ ] Quality Gates

## Step 2: Install Docker, Java8, Java11 & Trivy on Build Server
```
-> Git clone repo and then run
$ sudo ./setup.sh
which docker
which trivy
which java
ls -l /usr/lib/java
ls -l /etc/alternatives/java
ls /usr/bin/jvm
/usr/lib/java/java-8/bin/java -version #java --version (current version installed)
```

## Step 3: Install Sonrqube on the t2.medium server
```
$ sudo apt update
$ sudo apt install -y docker.io
$ sudo usermod -a -G docker ubuntu
$ sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

## Step 4: Add necessary credentials
- [ ] Generate Sonarqube token of type "global analysis token" and add it as Jenkins credential of type "secret text". Manage Jenkins -> System -> SQ servers -> same name(mysonarqube) -> SQ URL -> Creds we just added.
- [ ] For QG Jenkins needs to check with SQ and get the QG results for that we need to configure webhook.
- [ ] For SCA we need to install OWASP dependency check plugin.
- [ ] Add dockerhub credentials as username/password type
- [ ] Add Github credentials 
- [ ] Add Build server credentials for Jenkins master to connect

## Step 5: Enable Sonarqube webhook for Quality Gates & Install dependency-check plugin
- [ ] Generate webhook & add the Jenkins URL as follows - http://URL:8080/sonarqube-webhook/







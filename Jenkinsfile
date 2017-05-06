node {
   stage('Git Code Checkout') { // for display purposes
      // Get some code from a GitHub repository
      git url: 'git@github.com:abirdatta/SimpleSpringMvcHelloWorld.git', branch: 'bluemix'
   }
   stage('Perform Maven Build, generate App artifact') {
      // Run the maven build
      echo "Starting Mvn build"
      sh "mvn clean package"
      echo "Finished Mvn build"
   }
   stage("Create Docker image from DockerFile") {
       sh "docker build -t abirdatta/poc:v${BUILD_NUMBER} ."
   }
   stage("Login and Push Image to DockerHub") {
       sh 'docker login --username=abirdatta --email="abirdatta.in@gmail.com" --password="dockerhub123"'
       sh "docker push abirdatta/poc:v${BUILD_NUMBER}"
   }
   stage("Invoke Openwhisk api, action to perform bx container service kube cluster update"){
       sh "./update-bx-kube-cluster.sh"
   }
}

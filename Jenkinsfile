node {
   stage('Git Code Checkout') { // for display purposes
      // Get some code from a GitHub repository
      git url: 'git@github.com:abirdatta/SimpleSpringMvcHelloWorld.git', branch: 'cloudformation-branch'
   }
   stage('Maven Build') {
      // Run the maven build
      echo "Starting Mvn build"
      sh "mvn clean package"
      echo "Finished Mvn build"
   }
   stage("Create Docker image from DockerFile") {
       sh "docker build -t abirdatta/poc:${BUILD_NUMBER} ."
   }
   stage("Login and Push Image to DockerHub") {
       sh 'docker login --username=abirdatta --email="abirdatta.in@gmail.com" --password="dockerhub123"'
       sh "docker push abirdatta/poc:${BUILD_NUMBER}"
   }
   stage("update cloudformation stack to update ECS"){
       sh "./update-ecs-cloudformation-stack.sh MyStack 'https://s3.amazonaws.com/ecs-cloudformation-templates/ecs-stack-template.json' ${BUILD_NUMBER}"
   }
}
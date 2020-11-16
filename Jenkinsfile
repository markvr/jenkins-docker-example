pipeline {
  agent any

  stages {
    stage('Build') {
      when {
        branch 'master'
      }
      environment {
        GITHUB_CREDS = credentials('github')
      }
      steps {
        sh '''
          TAG=$(git rev-parse HEAD | cut -c 1-6)
          IMAGE=jenkins-docker-example
          echo $GITHUB_CREDS_PSW | docker login --username $GITHUB_CREDS_USR --password-stdin ghcr.io
          docker build -t ghcr.io/markvr/$IMAGE:$TAG .
          docker push ghcr.io/markvr/$IMAGE:$TAG
        '''
      }
    }
  }
}
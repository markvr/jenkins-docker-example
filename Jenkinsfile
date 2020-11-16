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
    stage('Deploy') {
      when {
        branch 'master'
      }
      environment {
        GITHUB_CREDS = credentials('github')
      }
      steps {
        sh  '''
          TAG=$(git rev-parse HEAD | cut -c 1-6)
          IMAGE=jenkins-docker-example
          DSL_FILE=jenkins_docker_example.dsl
          CONFIG_REPO=jenkins-dsl-config
          cd /tmp
          if [ -d $CONFIG_REPO ]; then
            cd $CONFIG_REPO
            git pull
          else
            git clone https://$GITHUB_CREDS_USR:$GITHUB_CREDS_PSW@github.com/markvr/$CONFIG_REPO
            cd $CONFIG_REPO
          fi
          sed -i -E  "s/$IMAGE:(.*)/$IMAGE:$TAG/" $DSL_FILE
          git commit -a -m "Updated $IMAGE to $TAG"
          git push
          '''
      }
    }    
  }
}
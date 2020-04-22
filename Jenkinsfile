pipeline {
  agent { label 'AWS_Jenkins-slave' }

  libraries {
    lib 'jenkins-ci-tad'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 15, unit: 'MINUTES')
  }

  tools {
    nodejs 'Node12.16.1'
  }

  environment {
    GH_TOKEN = credentials('GithubPAT')
    GIT_CREDENTIALS = credentials('github_semantic_release')
    NPM_TOKEN = credentials('npmrc')
  }

  stages {
    stage('Checkout') {
      steps {
        scmSkip(deleteBuild: true, skipPattern:'.*\\[skip ci\\].*')

      }
    }

    stage('Semantic Release') {
      when {
        anyOf {
          branch 'master'
        }
      }
      steps {
        withNPM(npmrcConfig: 'basenpmrc') {
          sh 'npm i'
          sh 'npm run semantic-release'
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }
  }
}

#!groovy

def err_msg = ""
def repo_name = "sample-jenkinsfile-rb"
def git_url = "git@github.com:shouhei/${repo_name}.git"
def dev_branch = "development"
def release_branch = "master"

node {
    try {
        stage('prepare') {
            env.PATH = "/usr/local/bin:$JENKINS_HOME/.rbenv/shims:$JENKINS_HOME/.rbenv/bin:$PATH"
            sh 'eval "$(rbenv init -)"'
            sh 'rbenv local 2.4.0'
        }
        // ソースの取得
        stage("get resource") {
            // カレントディレクトにgitリポジトリが存在するか否かの確認
            if(fileExists("./${repo_name}") && fileExists("./${repo_name}/.git")) {
                // フェッチ
                def FETCH_RESULT = sh(script: "cd ./${repo_name} && git fetch --all", returnStatus: true) == 0
                if(!FETCH_RESULT) {
                    // throw error
                    error "fetchに失敗しました"
                }
                // gitがある場合はpull
                def PULL_RESULT = sh(script: "cd ./${repo_name} && git pull --all", returnStatus: true) == 0
                if(!PULL_RESULT) {
                    error "pullに失敗しました"
                }
                // ブランチの切替
                def CHECKOUT_RESULT = sh(script: "cd ./${repo_name} && git checkout ${dev_branch}", returnStatus: true) == 0
                if(!CHECKOUT_RESULT) {
                    // throw error
                    error "checkoutに失敗しました"
                }
            } else {
                // gitがない場合はclone
                def CLONE_RESULT = sh(script: "git clone ${git_url} ${repo_name}", returnStatus: true) == 0
                if(!CLONE_RESULT) {
                    error "cloneに失敗しました"
                }
            }
        }

        stage("install libs") {
            def GEM_RESULT = sh(script: "cd ./${repo_name} && bundle install --path=vendor/bundle", returnStatus: true) == 0
            if(!GEM_RESULT) {
                error "npm installに失敗しました"
            }
        }

    } catch (err) {
        err_msg = "${err}"
        currentBuild.result = "FAILURE"
    } finally {
        if(currentBuild.result != "FAILURE") {
            currentBuild.result = "SUCCESS"
        }
        notigication(err_msg)
    }
}

// 実行結果のSlack通知
def notigication(msg) {
    def slack_channel = "#pjct_1-commit-per-day"  // jenkinsが通知するチャネル
    def slack_domain = "fnifnilab"           // slackのドメイン名 https://mydomain.slack.comのmydomainの部分
    def slack_token = "nn8ktB4a55ul9Lv1WJM0ZANa"            // slackのjenkinsプラグインで取得できるtoken
    def slack_color = "good"
    def slack_icon = ""
    def detail_link = "(<${env.BUILD_URL}|Open>)"  // SlackでOpenのアンカーとして表示されます
    // ビルドエラー時にメッセージの装飾を行う
    if(currentBuild.result == "FAILURE") {
        slack_color = "danger"
    }
    def slack_msg = "job ${env.JOB_NAME}[No.${env.BUILD_NUMBER}] was builded ${currentBuild.result}. ${detail_link} \n\n ${msg}"
    slackSend channel: "${slack_channel}", color: "${slack_color}", message: "${slack_msg}", teamDomain: "${slack_domain}", token: "${slack_token}"
}

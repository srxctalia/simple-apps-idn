pipeline {
    agent { label 'devops1-ludfiazimada' }
    configFileProvider([configFile(fileId: 'efead934-55c6-4e66-bbe8-7b81f53126bb', targetLocation: '.env')]) {}

    stages {
        stage('Pull SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/srxctalia/simple-apps-idn.git'
            }
        }
        
        stage('Import Environtment') {
            steps {
                script {
                    configFileProvider([configFile(fileId: 'your-file-id', targetLocation: '.env')]) {
                        // Access the file
                        sh 'cat .env'
                    }
                }
            }
        }

        stage('Build') {
            steps {
                sh'''
                cd apps
                npm install
                '''
            }
        }
        
        stage('Testing') {
            steps {
                sh'''
                cd apps
                npm test
                npm run test:coverage
                '''
            }
        }
        
        stage('Code Review') {
            steps {
                sh'''
                cd apps
                sed -i "s/localhost/db/g" .env
                sonar-scanner \
                    -Dsonar.projectKey=simple-apps \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://172.23.11.14:9000 \
                    -Dsonar.login=sqp_db2885ef5e22f3429a11285a0e10cb5e8fa032dd 
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                sh'''
                docker compose up --build -d
                '''
            }
        }
        
        // stage('Backup') {
        //     steps {
        //         build wait: false, job: 'backup-image'
        //     }
        // }
    }
}
#Upwork Jobs Piper
This is a customizeable Upwork jobs filtering app.

[![Travis build status](http://img.shields.io/travis/artemv/upwork-jobs-piper.svg?style=flat)](https://travis-ci.org/artemv/upwork-jobs-piper)
[![Codacy Badge](https://api.codacy.com/project/badge/grade/fddd6442eb6a400a87aafdb1bfb28e46)](https://www.codacy.com/app/artem-job/upwork-jobs-piper)
[![Codacy Badge](https://api.codacy.com/project/badge/coverage/fddd6442eb6a400a87aafdb1bfb28e46)](https://www.codacy.com/app/artem-job/upwork-jobs-piper)

#Installation
1. Register new application at Upwork to get consumer key and consumer secret: https://www.upwork.com/services/api/apply.
Or use your existing app key, you can see them at https://www.upwork.com/services/api/keys.
1. Clone the repo: ```
git clone https://github.com/artemv/upwork-jobs-piper.git
cd upwork-jobs-piper
```
1. Initialize a local .env file: `cp .env.example .env` and put your random SECRET_KEY_BASE there.
1. After the application is approved by Upwork you can use its consumer keys, put them to UPWORK_CONSUMER_KEY and UPWORK_CONSUMER_SECRET keys of .env file
1. Install the required gems: `bundle install`
1. Run the access key script: `bin/setup_upwork_keys.rb`. Follow its instructions to get UPWORK_ACCESS_TOKEN and UPWORK_ACCESS_SECRET keys.
Put their values to .env file and uncomment relevant lines.
1. Run this command to verify that Upwork API access works: `JOB_ID="_~01a9a3a697ce5e4cf5" bin/query_upwork.rb`. It should print job data JSON.
1. Initialize a local database.yml file and create the database: ```
cp config/database.yml.example config/database.yml
bundle exec rake db:create db:migrate
```
1. Run the jobs populating script: `bundle exec rake upwork_jobs:fetch_jobs`
1. Run the local server: `bundle exec guard`
1. Open it in browser: http://localhost:3010

#Terms of Use
This app uses Upwork API and Upwork jobs data, make sure to check their Terms of Use before using it: https://developers.upwork.com/api-tos.html

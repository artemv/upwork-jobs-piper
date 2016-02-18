#Upwork Jobs Piper
This is a customizeable Upwork jobs filtering app.

[![Travis build status](http://img.shields.io/travis/artemv/upwork-jobs-piper.svg?style=flat)](https://travis-ci.org/artemv/upwork-jobs-piper)
[![Codacy Badge](https://api.codacy.com/project/badge/grade/fddd6442eb6a400a87aafdb1bfb28e46)](https://www.codacy.com/app/artem-job/upwork-jobs-piper)
[![Code Climate](https://codeclimate.com/github/artemv/upwork-jobs-piper/badges/gpa.svg)](https://codeclimate.com/github/artemv/upwork-jobs-piper)
[![Codacy Badge](https://api.codacy.com/project/badge/coverage/fddd6442eb6a400a87aafdb1bfb28e46)](https://www.codacy.com/app/artem-job/upwork-jobs-piper)
[![Dependency Status](https://gemnasium.com/artemv/upwork-jobs-piper.svg)](https://gemnasium.com/artemv/upwork-jobs-piper)

#Installation
* Register new application at Upwork to get consumer key and consumer secret: https://www.upwork.com/services/api/apply.
Or use your existing app key, you can see them at https://www.upwork.com/services/api/keys.
* Clone the repo:
```
git clone https://github.com/artemv/upwork-jobs-piper.git
cd upwork-jobs-piper
```
* Initialize a local .env file: `cp .env.example .env` and put your random SECRET_KEY_BASE there.
* After the application is approved by Upwork you can use its consumer keys, put them to UPWORK_CONSUMER_KEY and UPWORK_CONSUMER_SECRET keys of .env file
* Install the required gems: `bundle install`
* Run the access key script: `bin/setup_upwork_keys.rb`. Follow its instructions to get UPWORK_ACCESS_TOKEN and UPWORK_ACCESS_SECRET keys.
Put their values to .env file and uncomment relevant lines.
* Run this command to verify that Upwork API access works: `JOB_ID="_~01a9a3a697ce5e4cf5" bin/query_upwork.rb`. It should print job data JSON.
* Initialize a local database.yml file and create the database:
```
cp config/database.yml.example config/database.yml
bundle exec rake db:create db:migrate
```
* Run the jobs populating script: `bundle exec rake upwork_jobs:fetch_jobs`
* Run the local server: `bundle exec guard`
* Open it in browser: http://localhost:3010/ (fixed rate and hourly jobs) or http://localhost:3010/hourly (hourly jobs only).
* Now you can setup a cron task to fetch fresh jobs e.g. each 10 mins:
```
*/10 * * * * /bin/bash -l -c 'cd /absolute/path/to/upwork-jobs-piper && bundle exec rake upwork_jobs:fetch_jobs --silent'

```

#Terms of Use
This app uses Upwork API and Upwork jobs data, make sure to check their Terms of Use before using it: https://developers.upwork.com/api-tos.html

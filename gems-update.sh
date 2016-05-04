export GEMNASIUM_TESTSUITE="true"
export GEMNASIUM_PROJECT_SLUG="artemv/upwork-jobs-piper"
gemnasium autoupdate run && gemnasium autoupdate apply && bundle exec rspec spec && git commit -m "chore(dependencies): gemnasium autoupdate" Gemfile.lock && git push


# <Project Name>

## Getting Setup

```bash
# Checkout the repo
git clone git@github.com:highgroove/<project>.git

# Install gem dependencies
gem install bundler
bundle install

# Install other dependencies
# ex: brew install <list dependencies here. e.g. postgres, redis, etc.>

# Get the database ready
# ex: bundle exec rake db:create:all db:schema:load db:test:prepare

# Start the app and other processes

bundle exec foreman start

# setup other services like Solr, Redis, etc...
```

## Development

When making changes to files, make sure that your changes are consistent with
the existing style of the file. For Ruby files, these will typically follow the
Github Ruby Styleguide:

* https://github.com/styleguide/ruby

### Database setup

For example:

Grab the production database

```bash
heroku pgbackups:capture --expire
curl -o latest.dump `heroku pgbackups:url`
pg_restore -h localhost --verbose --clean --no-acl --no-owner -d
<project>_development latest.dump
rm latest.dump
```


### Testing

Explain how to run the test-suite here

## Production

* Explain how to deploy here
* Explain any addons required (for example Heroku addons)
* Explain external services being used e.g. Mailchimp, Mandrill, NewRelic, etc.

## Architecture

* List any salient architecture notes.  This should be super high-level but
  explain to future devs how things fit together

# LA Covid Bubbles

Inspired by this tweet from [skarlamangla](https://twitter.com/skarlamangla/status/1348783210855944192)

Data pulled from [lacounty.gov](http://publichealth.lacounty.gov/media/coronavirus/locations.htm)

## Ruby version

```
3.0.0
```

## Running locally

The app is configured with PostgreSQL. To install on mac if you don't have it:

```
brew install postgresql
```

Everything else is standard Rails :steam_locomotive:

```
bin/rails db:setup
bin/rails db:migrate
bin/rails t
bin/rails s
```

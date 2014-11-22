# MIDI Munge

Munges MIDI files.


## Format
```
{
  'name'   => 'MIDI Name',
  'bpm'    => 150,
  'tracks' => [
    {
      notes: [
        { note: 71, milliseconds_from_start: 0 },
        { note: 65, milliseconds_from_start: 150 }
      ]
    },
    {
      notes: [
        { note: 45, milliseconds_from_start: 75 },
        { note: 48, milliseconds_from_start: 200 }
      ]
    }
  ]
}
```

## Setup & Configuration
Ruby Version
```
2.1.3
```

Rails Version
```
4.1.8
```

### Bundle
Bundle install all the dependencies:
```
bundle install
```

If you don't have Bundler for your particular version of Ruby, try:
```
gem install bundler
```
..before `bundle install`.

### Database
MIDI Munge uses Postgres.  If you don't have it:
```
brew install postgres
```
(And if you don't yet have Homebrew, go [download](http://brew.sh/) that first!)

Then, copy the example database configuration & fill in with your postgres username/password:
```
cp config/database.yml{.example,}
```

Once you've configured the database, create the database and run migrations:
```
bundle exec rake db:create db:migrate
```

### Starting the Server
At this point, you should be able to start the rails server:
```
rails s
```

Then, in your browser, access the application at:
```
http://localhost:3000
```

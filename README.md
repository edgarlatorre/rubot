# Rubot
Rubot: Simple slack bot to find ruby documentation.

[![CircleCI](https://circleci.com/gh/edgarlatorre/rubot/tree/master.svg?style=svg)](https://circleci.com/gh/edgarlatorre/rubot/tree/master)

##Setup
First, you need to clone the project.
```
$ git clone git@github.com:edgarlatorre/rubot.git
```

Install the dependencies.
```
$ sh script/setup
```

Add the slack token to a environment variable.
```
$ export SLACK_TOKEN=<TOKEN>
```

Run the application.
```
$ rake run
```

##Tests
Run the tests.
```
$ rake test
```

##Interacting with rubot on slack

Direct command
```
> Array#first
```

Metion command
```
> @<bot_name> Array#first
```

Advanced command
```
@<bot_name> please explain Array#first
```

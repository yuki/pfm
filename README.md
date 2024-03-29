# Personal Finance Manager

This is my personal finance manager (PFM). It works for me, and it's an upgrade
of what I did few years ago (you can see the log of the project and the branch
"old_version").

It's made with Ruby on Rails and few gems. As I said, it has the functionality I need, so 
probably it's not for you. If you think you can improve it,
fork it and make a pull request :D

# Install
If you  want to try it, make sure you have Ruby on Rails installed (tested with
Ruby 3.3 and Rails 7.1). You probably want to use https://rvm.io/

To use PFM you should do:
```
$ git clone https://github.com/yuki/pfm.git
$ cd pfm
$ bundle install
$ rake db:migrate
$ rake db:seed
$ rails s
```

## Using Docker
I have created a simple docker-compose.yml in order to test PFM. The service will use this repository code as an external volume. 


If you have **Docker** and **docker-compose** installed you can do:

```
$ docker-compose up
```

Then, you can go to **http://localhost:3000** and you will see PFM's web.

If you need a minimal data to see how it works, you can execute:
```
$ docker-compose exec pfm rake db:seed
```
and it will create two accounts for testign and two movements.

If you stop the docker-compose, you will need to delete the file **tmp/pids/server.pid**.

# Configure
You should configure the application to use your locale. Change it in
config/application.rb

```
# config.i18n.default_locale = :es
```

To change the default currency change it in config/initializers/money.rb , few examples:
```
  config.default_currency = :eur
  # config.default_currency = :usd
  # config.default_currency = :gbp
```


# Disclaimer
This projects is unfinished and there are known bugs.

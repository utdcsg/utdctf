# Installing Network Security CTF Manager and Problems

Installation Instructions are given for Ubuntu 12.04.02 64-bit servers.

NOTE: These instructions are for UTD students or faculty attempting to set up
this application. Anyone else should use whatever deployment approach they 
prefer.

More detailed instructions for developers or CTF administrators can be found in
the doc/ folder.

----
## Installing CTF Manager

Ensure that packages are current and install all the ones we'll need:

	sudo apt-get update && sudo apt-get upgrade -y
	sudo apt-get install nodejs git curl build-essential libcurl4-openssl-dev apache2 apache2-prefork-dev libapr1-dev libaprutil1-dev postgresql libpq-dev
	sudo apt-get --no-install-recommends install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev

Install RVM (Ruby Version Manager).
    
	\curl -L https://get.rvm.io | bash -s stable --ruby

Restart your SSH window when finished.
	
Install Ruby 1.9.3
    
	rvm install 1.9.3
    rvm use 1.9.3 --default

Install Ruby on Rails along with Phusion Passenger

	gem install rdoc rails passenger

Run "passenger-config --root" and chmod o+x every directory along that path, starting at home. For example:
	
	passenger-config --root
	chmod o+x /home/ctf
	chmod o+x /home/ctf/.rvm/
	chmod o+x /home/ctf/.rvm/gems
	chmod o+x /home/ctf/.rvm/gems/ruby-1.9.3-p392
	chmod o+x /home/ctf/.rvm/gems/ruby-1.9.3-p392/gems/
	chmod o+x /home/ctf/.rvm/gems/ruby-1.9.3-p392/gems/passenger-3.0.19

Install the Passenger Apache2 module. Important: Follow the instructions given to you by the module installer about editing Apache configs.

	passenger-install-apache2-module

Configure database by entering PostgreSQL command line with "sudo -u postgres psql template1" and entering:

	create user utdctf with password 'YOUR_PASSWORD_HERE';
	create database ctf_prod owner utdctf;
	create database ctf_dev owner utdctf;

Configure the application's database information (config/database.yml) to contain:
	
	production:
	  adapter: postgresql
	  host: localhost
	  encoding: unicode
	  database: ctf_prod
	  pool: 5
	  username: utdctf
	  password: YOUR_PASSWORD_HERE


Navigate to the project's root directory and install dependencies.

	bundle install

Prepare the database

	export RAILS_ENV=production
	rake db:setup
	rake db:schema:load
	rake db:migrate RAILS_ENV=production

Add admin user

	export RAILS_ENV=production
	rails c
	admin = User.new
	admin.name = "ctfadmin"
	admin.password = "YOUR_PASSWORD_HERE"
	admin.description = "CTF Administrator"
	admin.role = :admin
	admin.save

Precompile assets and clear logs

	rake assets:precompile
	rake log:clear

Restart Apache2

	sudo service apache2 restart
	
Load CTF data

	rake db:data:load

## Installing CTF Problems

Ensure that packages are current and install all the ones we'll need:

	sudo apt-get update && sudo apt-get upgrade -y
	sudo tasksel install lamp-server
	sudo apt-get install php5-sqlite sqlite3
	
Sometimes a reboot is needed before the SQLite module takes effect.	
	
Make a symlink to the problems folder:

	sudo ln -s ~ctf/problems /var/www/problems
	
Edit "/etc/apache2/sites-enabled/000-default" to point to extracting problems folder:
	
	Before: DocumentRoot /var/www
	After: DocumentRoot /var/www/problems
	
Fix permissions on the "social" problem folder and contents. From problems folder assuming username is "ctf":
	
	sudo chown ctf:www-data social/data
	sudo chown ctf:www-data social/data/users.db

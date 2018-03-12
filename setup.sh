# Generate a sinatra application

part=$3
test="${part}/test"

mkdir -p "${part}/app/controllers" "${part}/app/models" "${part}/app/views"
mkdir $test

app="${part}/app/controllers/app.rb"
echo "class App < Sinatra::Base" > $app
echo "\tset :root, File.expand_path('..', __dir__)" >> $app
echo "\tset :method_override, true" >> $app
echo "\nend" >> $app

test_helper="${part}/test/test_helper.rb"
echo "require 'simplecov'" > $test_helper
echo "SimpleCov.start" >> $test_helper
echo "\nrequire 'minitest'" >> $test_helper
echo "require 'minitest/autorun'" >> $test_helper
echo "require 'minitest/pride'" >> $test_helper

hound="${part}/.hound.yml"
echo "ruby:" > $hound
echo "\tconfig_file: .rubocop.yml" > $hound

rubocop="${part}/.rubocop.yml"
echo "AllCops:" > $rubocop
echo "\tExclude:" >> $rubocop
echo "\t\t- 'test/**/*'" >> $rubocop

config="${part}/config.ru"
echo "require 'bundler'" > $config
echo "Bundler.require" >> $config
echo "$LOAD_PATH.unshift(File.expand_path('app', __dir__))" >> $config
echo "require 'controllers/app'" >> $config
echo "run App" >> $config

gemfile="${part}/Gemfile"
echo "source 'https://rubygems.org'" > $gemfile
echo "\ngem 'shotgun'" >> $gemfile
echo "gem 'sinatra', require: 'sinatra/base'" >> $gemfile
echo "gem 'sqlite3'" >> $gemfile
echo "gem 'pry'" >> $gemfile
echo "gem 'simplecov'" >> $gemfile
echo "gem 'minitest'" >> $gemfile

rakefile="${part}/Rakefile"
echo "require 'rake/testtask'" > $rakefile
echo "\nRake::TestTask.new do |t|" >> $rakefile
echo "\tt.pattern = 'test/**/*_test.rb'" >> $rakefile
echo "end" >> $rakefile
echo "\ntask :default => [:test]" >> $rakefile







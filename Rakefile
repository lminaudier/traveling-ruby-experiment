require 'bundler'

PACKAGE_NAME = "liquid-previewer"
VERSION = "1.0.0"
TRAVELING_RUBY_VERSION = "20150517-2.2.2"

desc "Package your app"
task :package => ['package:linux:x86', 'package:linux:x86_64', 'package:osx', 'package:win32']

namespace :package do
  namespace :linux do
    desc "Package your app for Linux x86"
    task :x86 => [:vendoring, "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86.tar.gz"] do
      create_package("linux-x86")
    end

    desc "Package your app for Linux x86_64"
    task :x86_64 => [:vendoring, "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86_64.tar.gz"] do
      create_package("linux-x86_64")
    end
  end

  desc "Package your app for OS X"
  task :osx => [:vendoring, "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-osx.tar.gz"] do
    create_package("osx")
  end

  desc "Package your app for Windows"
  task :win32 => [:vendoring, "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-win32.tar.gz"] do
    create_package("win32", os_type: :windows)
  end

  desc "Vendoring gems"
  task :vendoring do
    if RUBY_VERSION !~ /^2\.2\./
      abort "You can only 'bundle install' using Ruby 2.2, because that's what Traveling Ruby uses."
    end
    sh "rm -rf tmp/bundle"
    sh "mkdir -p tmp/bundle"
    sh "cp app/Gemfile app/Gemfile.lock tmp/bundle"
    Bundler.with_clean_env do
      sh "cd tmp/bundle && env BUNDLE_IGNORE_CONFIG=1 bundle install --path ../vendor --without development"
    end
    sh "rm -rf tmp/bundle"
    sh "rm -f tmp/vendor/*/*/cache/*"
  end
end

file "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86.tar.gz" do
  download_runtime("linux-x86")
end

file "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-linux-x86_64.tar.gz" do
  download_runtime("linux-x86_64")
end

file "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-osx.tar.gz" do
  download_runtime("osx")
end

file "tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-win32.tar.gz" do
  download_runtime("win32")
end

def create_package(target, os_type: :unix)
  sh "mkdir -p pkg"
  package_full_name = "#{PACKAGE_NAME}-#{VERSION}-#{target}"
  package_dir = "pkg/#{package_full_name}"
  sh "rm -rf #{package_dir}"
  sh "mkdir -p #{package_dir}/lib"
  sh "cp -R app #{package_dir}/lib/"
  sh "mkdir #{package_dir}/lib/ruby"
  sh "tar -xzf tmp/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz -C #{package_dir}/lib/ruby"

  if os_type == :unix
    sh "cp packaging/wrapper.sh #{package_dir}/#{PACKAGE_NAME}"
  else
    sh "cp packaging/wrapper.bat #{package_dir}/#{PACKAGE_NAME}.bat"
  end

  sh "cp -pR tmp/vendor #{package_dir}/lib/"
  sh "cp app/Gemfile app/Gemfile.lock #{package_dir}/lib/vendor/"
  sh "mkdir #{package_dir}/lib/vendor/.bundle"
  sh "cp packaging/bundler-config #{package_dir}/lib/vendor/.bundle/config"

  if !ENV['DIR_ONLY']
    if os_type == :unix
      sh "cd pkg && tar -czf #{package_full_name}.tar.gz #{package_full_name}"
    else
      sh "cd pkg && zip -9r --quiet #{package_full_name}.zip #{package_full_name}"
    end
    sh "rm -rf #{package_dir}"
  end
end

def download_runtime(target)
  sh "cd tmp && curl -L -O --fail " +
    "http://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz"
end

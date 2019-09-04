require 'rake'

desc "install the dot files into user's home directory"

task :install do
  install_homebrew
  install_homebrew_packages

  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README LICENSE id_dsa.pub].include? file

    if File.exist?(File.join(ENV['HOME'], ".#{file}"))
      if replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file}"
        end
      end
    else
      link_file(file)
    end
  end

  system %Q{mkdir ~/.tmp}
end

def replace_file(file)
  system %Q{rm "$HOME/.#{file}"}
  link_file(file)
end

def link_file(file)
  puts "linking ~/.#{file}"
  system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
end

def install_homebrew
  sh %{brew -v &> /dev/null} do |ok, res|
    puts ok
    puts res
    if !ok
      sh "echo '🍺 Installing Homebrew.'"
      sh '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    end
  end
end

def install_homebrew_packages
  sh %{brew bundle check} do |ok, res|
    if !ok
      sh "echo '📦 Running `brew bundle install` to install desired packages.'"
      sh "brew bundle install"
    end
  end
end

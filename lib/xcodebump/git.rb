require 'colors'
require 'git'
require 'fileutils'

module Xcodebump
  def self.add_new_version_to_git version

    commit_changes version if Dir.exist? "#{Dir.pwd}/.git"
    add_tag version if Dir.exist? "#{Dir.pwd}/.git"
    push_changes version if Dir.exist? "#{Dir.pwd}/.git"
  end

  def self.commit_changes version
    `git add .`
    `git commit -m 'Bump: #{version}'`
  end

  def self.add_tag version
    `git tag -a #{version} -m #{version}`
    `git push --tags`
  end

  def self.push_changes version
    `git push`
  end
end

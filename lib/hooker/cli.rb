require 'thor'
require 'hooker/version'
require 'hooker/repos'
require 'hooker/hooks'
module Hooker
  class CLI < Thor

    desc 'version', 'Show Hooker version'
    map %w(-v --version) => :version
    def version
      puts "Hooker version #{::Hooker::VERSION}"
    end

    desc 'repos', 'List all repos'
    option :user
    option :org
    option :type
    def repos
      puts ::Hooker::Repos.list(options).map(&:full_name).sort.join("\n")
    end

    desc 'repos', 'List hooks'
    option :user
    option :org
    option :type
    option :repo
    def hooks
      if repo = options[:repo]
        print_hooks(repo)
      else
        repos = ::Hooker::Repos.list(options).map(&:full_name).sort
        repos.each { |r| print_hooks(r) }
      end
    end

    private

    def print_hooks(repo)
      puts "#{repo}\n"
      hooks = ::Hooker::Hooks.list(repo)
      longest_url_size = hooks.map { |h| h.config.url ? h.config.url.size : 0 }.max
      hooks.each do |hook|
        puts ::Hooker::Hooks.format_string(hook, longest_url_size)
      end
      puts '-' * 50
    end
  end
end

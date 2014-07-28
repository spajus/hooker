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

    desc 'hooks', 'List hooks'
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

    desc 'ensure_hooks', 'Updates or creates hook'
    option :user
    option :org
    option :type
    option :repo
    option :hook_url
    option :events
    def ensure_hooks
      hook_url = options[:hook_url]
      events = options[:events]
      if hook_url.nil? || events.nil?
        puts 'Please provide --hook_url <url> and --events <comma,separated,events>'
        exit 1
      end
      events = events.split(',')
      if events.empty?
        puts 'Please provide --events <comma,separated,events>'
        exit 1
      end
      if repo = options[:repo]
        ensure_hook(repo, hook_url, events)
      else
        repos = ::Hooker::Repos.list(options).map(&:full_name).sort
        repos.each { |r| ensure_hook(r, hook_url, events) }
      end
    end

    private

    def ensure_hook(repo, hook_url, events)
      puts repo
      puts ::Hooker::Hooks.ensure_exists(repo, hook_url, events, options)
      puts "\n"
    end

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

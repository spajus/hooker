require 'thor'

module Hooker
  class CLI < Thor
    require 'hooker/version'

    desc 'version', 'Show Hooker version'
    map %w(-v --version) => :version
    def version
      puts "Hooker version #{::Hooker::VERSION}"
    end
  end
end

module Hooker
  module Repos
    extend self
    def list(options)
      opts = {}
      if options[:type]
        opts[:type] = options[:type]
      end
      if options[:org]
        Hooker.client.organization_repositories(options[:org], opts)
      elsif options[:user]
        Hooker.client.repositories(options[:user], opts)
      end
    end

  end
end

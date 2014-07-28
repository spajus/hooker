module Hooker
  module Hooks
    extend self
    def list(repo, options = {})
      opts = {}
      Hooker.client.hooks(repo, opts).select { |h| h.name == 'web' }
    end

    def format_string(hook, longest_url_length)
      url_format = "%-#{longest_url_length}s"
      "#{'%-10d' % hook.id} | #{url_format % hook.config[:url]} | #{hook.events.join(',')}"
    end
  end
end

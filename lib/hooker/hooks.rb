module Hooker
  module Hooks
    extend self
    def list(repo, options = {})
      opts = {}
      Hooker.client.hooks(repo, opts).select { |h| h.name == 'web' }
    end

    def ensure_exists(repo, hook_url, events, opts)
      opts = {}
      hooks = Hooker.client.hooks(repo, opts).select { |h| h.name == 'web' }
      hook = hooks.select { |h| h.config.url == hook_url }.first
      if hook
        res = Hooker.client.edit_hook(repo, hook.id, 'web', {
          url: hook_url,
          content_type: 'json'
        },
        {
          events: events,
          active: true
        })
        "updated: #{res.url}"
      else
        res = Hooker.client.create_hook(repo, 'web', {
          url: hook_url,
          content_type: 'json'
        },
        {
          events: events,
          active: true
        })
        "created: #{res.url}"
      end
    end

    def format_string(hook, longest_url_length)
      url_format = "%-#{longest_url_length}s"
      "#{'%-10d' % hook.id} | #{url_format % hook.config[:url]} | #{hook.events.join(',')}"
    end
  end
end

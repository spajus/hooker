require 'hooker/version'
require 'octokit'

Octokit.auto_paginate = true

module Hooker
  extend self
  def client
    @client ||= Octokit::Client.new(access_token: ENV['GITHUB_OAUTH_TOKEN'])
  end
end

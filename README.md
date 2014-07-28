# Hooker

Command line tool to control GitHub repository web hooks in multiple repos in bulk.

### Installing

```console
$ gem install hooker
```

### Before you run it

```console
$ export GITHUB_OAUTH_TOKEN=<your_token>
````

Your token must have `hooks_admin` permission.

## Examples

### Make sure all organization repos have a hook

```console
$ hooker ensure_hooks \
  --org your_org \
  --hook_url http://your.hook.handler/do/stuff \
  --events pull_request,issues
```

### List all hooks in all organization private repos

```console
$ hooker hooks \
  --org your_org \
  --type private
```

### Getting more help

Run `hooker help` or `hooker help <command>`.

name: inverse
layout: true
class: center, middle, inverse
---
# Google cloud shell
How to set up a Cloud based replacement of development environment

.footnote[25.08.2020 Erlend Nossum]
???

Made with: https://github.com/gnab/remark

---
layout: false
# Agenda


1. Introduction
1. Running it
1. Alternatives
1. VSCode
1. Customization
1. Jekyll example
???
---

# Introduction

https://cloud.google.com/shell
- You start a VM remotely within Google's infrastructure
- Secure
- The web interface gives you a **console** and an **editor**
- It is preloaded with tools you might need on the GCP platform
  - gcloud
  - kubernetes
  - psql client
  - docker
  - maven and java-11
  - (and you can install what you might miss...)
- It is free, but with (reasonable) limitations
  - https://cloud.google.com/shell/docs/how-cloud-shell-works
- Automatically connected to your google account
  - ...which you normally want anyway, working with GCP
???
- The limitations are ...
  - e2-small with 2 vCPUS
  - 2 GB RAM
  - 5 GB permanent storage as $HOME
  - Burstable: 24 hours on an e2-medium instance type instead. This
               boosts the 2 vCPU cores to 50% CPU Time and doubles both
               the RAM (to 4GB) and the network connection (to 2Gbps/250MB/s).
- Browser login is equivalent to `gcloud auth login`
- A benefit for developers is that they do not need to install all the tools if the are just going to do a small job
---
# How you start it
- https://console.cloud.google.com/
- iOS and Android app: https://cloud.google.com/console-app
- Open directly in separate tab
  - https://console.cloud.google.com/cloudshell/editor?cloudshell=true&shellonly=true
- Open editor directly
  - https://ssh.cloud.google.com/devshell/proxy?authuser=0&port=970&cloudshell_retry=true&devshellProxyPath=%2F&environment_name=default&environment_id=default
  - Append `#/path/to/directory` to the URL to open that directory in the editor!
  - https://ssh.cloud.google.com/cloudshell/editor?shellonly=true&cloudshell_git_repo={URL LINK TO REPO}
- Bookmark for opening git repo directly
```
javascript:{window.location='https://ssh.cloud.google.com/cloudshell/editor?shellonly=true&cloudshell_git_repo='+encodeURIComponent(window.location.href)}
```
???
- For more parameters, see https://cloud.google.com/shell/docs/open-in-cloud-shell
- The git repository needs to be public, of course
---
# When having gcloud installed

- Ssh into it with `gcloud alpha cloud-shell ssh`
- Copy local file to cloudshell:
```
gcloud alpha cloud-shell scp cloudshell:~/data.txt localhost:~data.txt
```

---
# Alternatives

Besides having a remote VM with shell access over SSH, you
have an editor based on: https://theia-ide.org/

- Alternatives development environments which (probably) uses Theia:
  - https://www.gitpod.io/
  - https://codesandbox.io/
  - https://www.eclipse.org/che/getting-started/cloud/
  - https://codeanywhere.com/
  - https://aws.amazon.com/cloud9
  - https://ide.sourcelair.com/home
???
- https://en.wikipedia.org/wiki/Theia
- Thei and Hyperion were Titans in Greek mythology, and parents of Helios,
  the Sun
---
# Install VSCode server
Instead of Theia, you can run VS-Code
- https://medium.com/google-cloud/how-to-run-visual-studio-code-in-google-cloud-shell-354d125d5748
- https://github.com/cdr/code-server/

```
# curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run | sed 's|~/.cache|/tmp/cache|g'
# Ephemeral installation on cloud shell to save precious space
curl -fsSL https://code-server.dev/install.sh | sed 's|~/.cache|/tmp/cache|g' | sh -s --
```

Start server with:
```
   code-server --auth none --port 8080
```

---
# Customizing the environment
- how to initialize environment with defaults upon instantiation:
  `.customize_environment`
  - Runs as root
  - Can install applications, but you only keep your home area outside of sessions
- Profile content:
```
wget -P /etc/profile.d/ https://URL/path/to/your/init_welcome.sh
chmod +x /etc/profile.d/init_welcome.sh
```
- Examples in https://github.com/nostra/dotfiles

???
- The cloudshell docker image used to be extendable, but now I cannot find any references to it
- https://cloud.google.com/shell/docs/configuring-cloud-shell#environment_customization
- Run cloudshell: `code-server --auth none`

---
# Example: Run jekyll
- https://jekyllrb.com/docs/usage/
- https://hub.docker.com/r/jekyll/jekyll/

Create a new site like this:
```
export JEKYLL_VERSION=3.8
docker run --rm \
--volume="$PWD:/srv/jekyll" \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll new site
```
Expose for editing:
```
cd site
docker run -p4000:4000 --rm \
    --volume="$PWD:/srv/jekyll" \
    -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll serve
```
???
Typically you’ll use `jekyll serve` while developing locally and `jekyll build`
when you need to generate the site for production.

# Docker image
Build docker image from jekyll site
```
FROM nginx:1.19.2-alpine
# https://hub.docker.com/r/library/nginx/tags/

COPY _site /usr/share/nginx/_site
RUN mv /usr/share/nginx/html /usr/share/nginx/original_html \
 && mv /usr/share/nginx/_site /usr/share/nginx/html
```
???
---

# Summary
- This is one alternative among many
- It is probably not the best alternative if you know your specific tasks / goal
- Not a replacement for you powerful laptop
- Approaches used interacting with the shell can be used other places
- Nifty when doing work outside of the comfort of your office
- When you borrow a browser in incognito-mode, and log in with your credentials to perform a cluster task
- If having a locked down laptop - where you cannot install anything
???
---
layout: true
class: center, middle, inverse
---
# Questions?

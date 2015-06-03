# anynines rails4_worker_example
*anynines rails4_worker_example* is a small web app that shows how to use background workers with Rails 4.2 on anynines. Here we use the gem [delayed_job](https://github.com/collectiveidea/delayed_job) for handling the background jobs.

## Supported Database Services
- MySQL

## Additional Required Services
There are no other services required.

## Requirements
- Ruby 2.2.2
- Bundler (`gem install bundler`)
- Rails 4.2

## Getting Started
### Create services in Cloud Foundry
Start by creating the services required by *anynines rails4_worker_example*:

Create a new mysql service (you can see the available service plans by typing `cf m[arketplace]`):
```SHELL
cf create-service mysql <SERVICE PLAN> <SERVICE NAME>
```

### Checkout repository and bundle gems
Checkout this repository:
```SHELL
git clone https://github.com/anynines/rails4_worker_example.git
cd rails4_worker_example
```
Bundle the gems:
```SHELL
bundle install
```

### Adapt manifest files
Adapt the manifest files to suit your installation:

*web-manifest.yml*
```YAML
---
applications:
- name: <APPLICATION NAME>
  memory: 512M
  instances: 1
  buildpack: https://github.com/cloudfoundry/ruby-buildpack.git
  host: <HOST NAME>
  domain: de.a9sapp.eu
  path: .
  services:
  - <MYSQL SERVICE NAME>
```

*workerweb-manifest.yml*
```YAML
---
applications:
- name: <WORKER NAME>
  memory: 128M
  instances: 1
  buildpack: https://github.com/cloudfoundry/ruby-buildpack.git
  path: .
  command: bundle exec rake jobs:work
  no-route: true
  services:
  - <MYSQL SERVICE NAME>
```

### Push anynines rails4_worker_example to Cloud Foundry
Push the app and its background worker:
```SHELL
cf push -f web-manifest.yml
cf push -f worker-manifest.yml
```

Note: Make sure that you use the same database, the same MySQL service name in both files.

### Access web interface
Run `cf apps` to see all apps. You can find the URL of the web interface for *anynines rails4_worker_example* in the `urls` column of your app.

Open the displayed URL in a browser and you can try out background joby on anynines.

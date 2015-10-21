# Sinatra-based dummy application

### Build the docker-container

```
$ docker build -t ruby-dummy-app .
```

Run the container for the first time:
```
$ docker run -it --rm ruby-dummy-app
```

Deamonize the container
```
$ docker run -d --rm ruby-dummy-app
```

https://github.com/travis-ci/dpl

ruby-onbuild kan niet -> zoek het daarin
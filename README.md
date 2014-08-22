# HHVM - Nginx - Laravel
A docker image to run [Laravel](http://laravel.com) apps under [HHVM](http://hhvm.com) compiler
in **FastCGI** mode behind an [NGINX](http://nginx.org) web server.

> This image is based off of [vinelab/base](https://registry.hub.docker.com/u/vinelab/base/)
so all of the features are available here as well.

### Run
- In your laravel project directory: `docker run -p -d 80:80 -v $(pwd):/var/www/app vinelab/hhvm`
- visit `http://localhost` and you should get to your app

#### Composer
[Composer](http://getcomposer.org) is installed in `/usr/local/bin/composer` so you can use it right away.

### Custom Configuration

- To add a virtual host configuration file to nginx mount a file with `.conf` extension to
`/etc/nginx/conf.d/` when running your container as such:

    `docker run -d -p 80:80 -v /path/to/host.conf:/etc/nginx/conf.d/host.conf vinelab/hhvm`

    > The default configuration file is `/etc/nginx/conf.d/app.conf` with
    `/var/www/app/public` as document root.

- If you'd like to alter the base nginx configuration override the file at
`/etc/nginx/nginx.conf` but **make sure to have `daemon off`** so that
supervisor can keep an eye on your nginx process:

    `docker run -d -p 80:80 /path/to/nginx.conf:/etc/nginx/nginx.conf vinelab/hhvm`

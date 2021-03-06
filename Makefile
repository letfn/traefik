SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: bash # Build defn/traefik, traefik-auth
	docker build -t defn/traefik .
	docker build -t defn/traefik-auth -f Dockerfile.auth .

bash:
	curl -sSL -o bash.1 https://github.com/robxu9/bash-static/releases/download/5.1.004-1.2.2/bash-linux-x86_64
	chmod 755 bash.1
	mv bash.1 bash

push: # Push defn/traefik, traefik-auth
	docker push defn/traefik
	docker push defn/traefik-auth

pull : # Pull defn/traefik, traefik-auth
	docker pull defn/traefik
	docker pull defn/traefik-auth

clean:
	docker-compose down --remove-orphans

up:
	docker-compose up -d --remove-orphans

down:
	docker-compose rm -f -s

recreate:
	$(MAKE) clean
	$(MAKE) up

logs:
	docker-compose logs -f

env:
	docker run --rm -v env_traefik:/secrets alpine cat /secrets/.env > .env
	docker run --rm -v env_traefik-auth:/secrets alpine cat /secrets/.env > .env.auth

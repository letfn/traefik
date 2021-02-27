SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: # Build defn/traefik, forward-auth
	docker build -t defn/traefik .
	docker build -t defn/traefik-forward-auth -f Dockerfile.auth .

push: # Push defn/traefik, forward-auth
	docker push defn/traefik
	docker push defn/traefik-forward-auth

pull : # Pull defn/traefik, forward-auth
	docker pull defn/traefik
	docker pull defn/traefik-forward-auth

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

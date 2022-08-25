PHOHY: all
all: build push deploy

PHOHY: build
build:
	docker build -t gcr.io/ssig33-default/selectorfeed:`git rev-parse HEAD` .

PHONY: push
push: build
	docker push gcr.io/ssig33-default/selectorfeed:`git rev-parse HEAD`

PHONY: deploy
deploy: push
	gcloud run deploy selectorfeed --platform managed --image gcr.io/ssig33-default/selectorfeed:`git rev-parse HEAD` --region us-central1

PHONY: login
login:
	gcloud auth activate-service-account --key-file auth.json
	gcloud config set project ssig33-default
	gcloud config set compute/zone us-central1-a
	gcloud auth configure-docker

PHONY: cop
cop:
	bundle exec rubocop -A

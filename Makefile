.PHONY: mix-deps
mix-deps:
	mix local.hex --force
	mix deps.get
	mix compile

.PHONY: up
up:	down build
	docker-compose -f docker-compose.yml up -d

down:
	@docker-compose down --remove-orphans

.PHONY: build
build:
	docker-compose build

.PHONY: local
local: mix-deps
	mix ecto.create
	mix phx.server

.PHONY: docker-image
docker-image:
	docker image build \
		--pull \
		--build-arg MIX_ENV=prod \
		.

.PHONY: test
test: mix-deps
	mix test

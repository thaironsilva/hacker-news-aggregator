.PHONY: prepare
prepare:
	mix local.hex --force
	mix deps.get
	mix compile
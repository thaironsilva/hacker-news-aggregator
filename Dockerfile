FROM elixir:latest

RUN apt-get update

RUN mkdir /app
COPY . /app

RUN mix local.hex --force

WORKDIR /app

RUN mix deps.get
RUN mix do compile

CMD ["./run.sh"]
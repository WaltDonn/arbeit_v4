FROM ruby:2.3.4

ENV port default_port_value
RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
USER appuser
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
RUN rake db:migrate


ADD . .
CMD ["sh", "-c", "puma -p ${port}"]

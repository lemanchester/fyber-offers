FROM ruby:2.3.1-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

ENV RACK_ROOT /var/www/fyber-offers

ENV PORT 3000

WORKDIR $RACK_ROOT

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the Rails application into place
COPY . .

CMD [ "foreman start" ]

ENTRYPOINT ["bundle", "exec"]

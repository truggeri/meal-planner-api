FROM ruby:2.6.5-slim-buster as build-image

# Install container dependencies
ENV BUILD_PACKAGES="wget gnupg2 libgmp-dev make gcc"
RUN set -eux; \
    apt-get update -qq; \
    apt-get install -y --no-install-recommends $BUILD_PACKAGES; \
    rm -rf /var/lib/apt/lists/*

# Install app dependencies
ENV APP_PACKAGES="postgresql-client-11 libpq-dev"
RUN set -eux; \
    echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list; \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -; \
    apt-get update -qq; \
    apt-get install -y --no-install-recommends $APP_PACKAGES; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile* ./
COPY .ruby-version .
RUN gem install bundler --version 2.0.2 --quiet
RUN bundle install --without development test --quiet

FROM build-image as default-image

COPY app/ ./app/
COPY config/ ./config/
COPY config.ru .

ENV RACK_ENV=production
EXPOSE 4000
CMD bundle exec puma --config config/puma.rb



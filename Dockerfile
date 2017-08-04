FROM ruby:2-alpine
RUN apk --update --upgrade add sqlite-dev bash git ruby-json curl-dev ruby-dev build-base nodejs
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
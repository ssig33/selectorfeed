FROM --platform=linux/x86_64 ruby:4.0.1
RUN gem install foreman
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5
COPY . ./
EXPOSE 5000
ENV PORT 5000
ENV RACK_ENV production
CMD ["foreman", "start"]

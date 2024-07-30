# Use a specific Ruby version image
FROM ruby:3.3.4

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler:2.5.11
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets if necessary
# RUN bundle exec rake assets:precompile

# Start the server
CMD ["rails", "server", "-b", "0.0.0.0"]

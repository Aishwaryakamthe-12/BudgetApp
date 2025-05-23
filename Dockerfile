FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set working directory
WORKDIR /budget-app

# Install specific bundler version first
RUN gem install bundler -v 2.3.6

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle _2.3.6_ install

# Copy the application code
COPY . .

# Add entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

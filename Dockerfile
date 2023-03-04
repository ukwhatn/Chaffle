FROM ruby:3.1.2

# create dir
RUN mkdir /app
WORKDIR /app

# create and set user
RUN adduser --disabled-login rails_user && chown -R rails_user /app
USER rails_user

# copy gemfile
COPY --chown=rails_user:rails_user Gemfile /app/Gemfile
COPY --chown=rails_user:rails_user Gemfile.lock /app/Gemfile.lock

# update bundler
RUN gem update --system
RUN bundle update --bundler

# bundle install
RUN bundle install

# copy app files
COPY --chown=rails_user:rails_user . /app

# startup scripts
COPY --chown=rails_user:rails_user entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# start
EXPOSE 3000
ARG mode="development"
CMD ["sh", "-c", "rails", "server", "-b", "0.0.0.0", "-e", "$mode"]

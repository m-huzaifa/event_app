FROM ruby:2.6.3

# set bash terminal
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# EVN variables
ENV NODE_VERSION 14.15.4
ENV NVM_DIR /usr/local/nvm

RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

WORKDIR /app
COPY . /app/
RUN gem install bundler -v 1.17.3
ENV BUNDLE_PATH /gems
RUN bundle install

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0"]

EXPOSE 3000

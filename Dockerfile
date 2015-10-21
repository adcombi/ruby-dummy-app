FROM ruby:2.2.3-onbuild
ENV RACK_ENV production
CMD ["bundle", "exec", "rackup", "-p 5000"]
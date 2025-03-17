FROM ruby:2-alpine

# Setup
RUN set -x && apk update && apk upgrade && apk add --no-cache \
  gnupg gcc g++ make unzip curl openssh-client git bash imagemagick
# 最新版ではなくRuby 2に対応したBundler 2.4.22をインストール
RUN gem install bundler -v 2.4.22

WORKDIR /usr/src/

# RUN git clone https://github.com/jerrywdlee/yaml_2_resume.git app
ADD ./ /usr/src/app/

WORKDIR /usr/src/app

RUN bundle install
RUN curl https://moji.or.jp/wp-content/ipafont/IPAexfont/IPAexfont00401.zip > fonts.zip && \
  unzip -oj fonts.zip -d fonts/ && rm -rf fonts.zip

EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb", "-o", "0.0.0.0", "-p", "4567"]

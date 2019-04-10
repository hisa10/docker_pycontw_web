FROM python:3.6.7-stretch

SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get dist-upgrade -y && apt-get install apt-transport-https && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update && apt-get install -y libjpeg-dev nodejs yarn vim zlib1g-dev sqlite3 && \
    apt-get clean && \
    pip install --upgrade pip && \
    git clone https://github.com/hisa10/pycon.tw.git && \
    cd pycon.tw && git checkout -f i18n-ja && \
    pip install -r requirements.txt && \
    yarn config set ignore-engines true && \
    yarn install --dev && \
    cp -f src/pycontw2016/settings/local.sample.env src/pycontw2016/settings/local.env && \
    sed -i 's/{{ secret_key }}/Replace here to your own secret key/' src/pycontw2016/settings/local.env && \
    sed -i "s/\(ALLOWED_HOSTS = \[\)\(\]\)/\1'*'\2/" src/pycontw2016/settings/base.py

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
    
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

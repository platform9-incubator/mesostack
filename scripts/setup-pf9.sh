#!/bin/bash

set -xe

yum install -y git gcc python-devel mysql-devel openssl-devel libxml2-devel libxslt-devel libffi-devel
curl https://bootstrap.pypa.io/get-pip.py |python -
pip install virtualenv
virtualenv /root/pf9

[ ! -e ~/.ssh/config ] && echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
[ ! -d pf9-glance-store ] && git clone --depth 1 git@github.com:platform9/pf9-glance-store.git
[ ! -d pf9-nova ] && git clone --depth 1 git@github.com:platform9/pf9-nova.git
[ ! -d pf9-glance ] && git clone --depth 1 git@github.com:platform9/pf9-glance.git
[ ! -d pf9-keystone ] && git clone --depth 1 git@github.com:platform9/pf9-keystone.git

source /root/pf9/bin/activate

for i in pf9-glance-store pf9-nova pf9-glance pf9-keystone; do
    pushd $i
    pip install -e .
    popd
done

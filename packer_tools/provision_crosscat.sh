# install crosscat


# settings
crosscat_dir=~/crosscat
sudo_pass=bigdata


# get a subset of ../install.sh
echo $sudo_pass | sudo -S apt-get install -y --force-yes git
# pip, virtualenv, virtualenvwrapper
echo $sudo_pass | sudo -S apt-get build-dep -y python-pip
# install most recent pip, else virtualenv{,wrapper} installs fail
wget -qO- https://raw.github.com/pypa/pip/master/contrib/get-pip.py > get-pip.py
echo $sudo_pass | sudo -S python get-pip.py
source ~/.bashrc
echo $sudo_pass | sudo -S pip install virtualenv==1.10
echo $sudo_pass | sudo -S pip install virtualenvwrapper==3.6


git clone https://github.com/mit-probabilistic-computing-project/crosscat.git $crosscat_dir
echo $sudo_pass | sudo -S bash $crosscat_dir/scripts/install_scripts/install_ubuntu_packages.sh
bash -i $crosscat_dir/scripts/install_scripts/virtualenv_setup.sh


# build cython + docs
# source ~/.bashrc
# workon crosscat
# make cython
# make docs


# # website install
# git checkout website_content
# # will require sudo password
# bash scripts/install_scripts/website_install/install.sh
# deactivate
# 
# # run website
# tmux
# cd website
# bundle install
# bundle exec middleman
# 

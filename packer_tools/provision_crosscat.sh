# install crosscat
crosscat_dir=/home/packer/crosscat


# download
echo packer | sudo -S apt-get install -y --force-yes git
git clone https://github.com/mit-probabilistic-computing-project/crosscat.git $crosscat_dir
(cd $crosscat_dir && git checkout virtualenv_cleanup)


# install
echo packer | sudo -S bash $crosscat_dir/scripts/install_scripts/install.sh


# set up environment
cat -- >> ~/.bashrc <<EOF
export PYTHONPATH=\$PYTHONPATH:$crosscat_dir
EOF


# test building
source ~/.bashrc
(cd $crosscat_dir && make cython)


# from host
# ssh -p 2222 packer@localhost mkdir -p /home/packer/crosscat/www/data
# scp -P 2222 /opt/tabular-predDB/www/data/dha.csv packer@localhost:/home/packer/crosscat/www/data/
# python $crosscat_dir/examples/dha_example.py --num_chains 2 --num_transitions 2


# # website install
# git checkout website_content
# # will require sudo password
# bash scripts/install_scripts/website_install/install.sh
# deactivate


# # run website
# tmux
# cd website
# bundle install
# bundle exec middleman
# 

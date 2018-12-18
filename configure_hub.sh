# https://github.com/github/hub/blob/v2.6.1/share/man/man1/hub.1.ronn#https-instead-of-git-protocol
# conda-clone-latest hub && sactivate hub && conda install --yes hub
# even after this change, seems like 'hub create' doesn't respect this setting but you can run 'hub init -p' first
git config --global hub.protocol https

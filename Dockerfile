# Pull base image.
FROM ubuntu:14.04

# Install (from basic official ubuntu Dockerfile)
RUN \
sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
apt-get update && \
apt-get -y upgrade && \
apt-get install -y build-essential && \
apt-get install -y software-properties-common && \
apt-get install -y byobu curl git htop man unzip vim wget && \
rm -rf /var/lib/apt/lists/*

#for sshd
RUN apt-get update && apt-get install -y openssh-server
RUN echo 'root:screencast' | chpasswd
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

#node related
RUN apt-get install -y npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm install -y -g  nodemon

#vim plugins :
RUN touch ~/.vimrc

#NERDTree
RUN mkdir ~/.vim
RUN wget -O NerdTree.zip http://www.vim.org/scripts/download_script.php?src_id=23731
RUN unzip NerdTree.zip -d ~/.vim
RUN rm NerdTree.zip
RUN echo 'autocmd VimEnter * NERDTree' >> ~/.vimrc && \
    echo 'autocmd BufEnter * NERDTreeMirror' >> ~/.vimrc && \
    echo 'let g:NERDTreeDirArrows=0' >> ~/.vimrc && \
    echo 'autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif' >> ~/.vimrc

#node.vim
RUN mkdir -p ~/.vim/bundle/node
RUN wget https://github.com/moll/vim-node/archive/master.tar.gz -O- | tar -xzf- --strip-components 1 -C ~/.vim/bundle/node
RUN echo ":set runtimepath^=~/.vim/bundle/node" >> ~/.vimrc

#heroku toolbelt
RUN wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Set environment variables.
ENV HOME /root

CMD ["/usr/sbin/sshd", "-D"]

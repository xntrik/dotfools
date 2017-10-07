# Dotfools

This is an archive of how I normally setup my terminal/workstation/whatever.

Includes tmux, tmuxinator, vim, zsh

Mental note, how I've added various sub-modules is through the steps defined at http://usevim.com/2012/03/01/using-pathogen-with-git-submodules/

Paraphrased here:

    # to add a module
    cd dotfools
    git submodule init
    git submodule add <git> <location/of/folder>
    git commit -m 'blah'
    git push origin master
  
    # after you've cloned this repo, you can update all the various submodules with
    cd dotfools
    git submodule init
    git submodule update

Because I'm into a 2+ version of tmux, and I often spin this up on *nix*, I constantly fight installing it on a fresh CentOS/Amazon. https://gist.github.com/pokev25/4b9516d32f4021d945a140df09bf1fde is a fairly reproducible method.

Paraphrased here (although I used *newer* versions than this):

    # Install tmux on Centos release 6.5
    
    # install deps
    yum install gcc kernel-devel make ncurses-devel
    
    # DOWNLOAD SOURCES FOR LIBEVENT AND MAKE AND INSTALL
    curl -OL https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
    tar -xf libevent-2.0.22-stable.tar.gz
    cd libevent-2.0.22-stable
    ./configure --prefix=/usr/local
    make
    make install
    
    # DOWNLOAD SOURCES FOR TMUX AND MAKE AND INSTALL
    
    curl -OL https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
    tar -xf tmux-2.3.tar.gz
    cd tmux-2.3
    LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
    make
    make install
    
    # pkill tmux
    # close your terminal window (flushes cached tmux executable)
    # open new shell and check tmux version
    tmux -V

For OSX - tmux (with the tmux_local) config will look ugly, because iTerm2 doesn't have the nice fonts. I followed the steps from https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x to get my setup nice/consistent. Mostly this involves getting fonts from https://github.com/Lokaltog/powerline-fonts and then setting them up in text settings for iTerm2.

Getting existing vim configuration to work with nvim requires the following:
1. Copy vimrc to ~/.vimrc
2. Create ~/.vim/ folder
3. Symlink vimrc `ln -sf /home/ec2-user/.vimrc init.vim`
4. Continue to setup the autoload and bundle subfolders
5. Create a ~/.config/ folder
6. Symlink the ~/.vim/ folder in there `ln -sf /home/ec2-user/.vim nvim`

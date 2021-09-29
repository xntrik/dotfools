# Dotfools

This is an archive of how I normally setup my terminal/workstation/whatever.

Update 29/9/21
Make sure you clone https://github.com/jimeh/tmux-themepack
Then ensure you have https://github.com/ohmyzsh/ohmyzsh
And then use this .tmux.conf and zshrc file.


CHANGES 26th September 2019
This is now just a tmux setup. I don't use the zshrc or zshuery stuff anymore.

On OSX, brew happens to install the latest tmux, nvim etc. And then using pyenv I setup Python3 globally. This tmux and tmux_local setup has been tested on tmux 2.9a.

Then I install vim from github.com/xntrik/vim

ARCHIVE STUFF BELOW HERE

Includes tmux, tmuxinator, zsh

For (n)vim see: https://github.com/xntrik/vim

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


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

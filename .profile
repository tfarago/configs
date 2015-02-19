if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

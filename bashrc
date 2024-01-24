#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\033[38;5;10m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$\[$(tput sgr0)\] '

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# Add gem binaries to PATH
if [ -d "/home/cam-o/.gem/ruby/2.7.0/bin" ]; then
	PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
fi

if [ -d "$HOME/bin" ]; then
	PATH="$PATH:$HOME/bin"
fi

alias weather="curl wttr.in/Nanaimo?m"

# Enable tmux on terminal start except with intellij
if [[ "$RUNNING_IN_INTELLIJ" -ne 1 ]] ; then
	if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    	tmux attach -t bash || tmux new -s bash
	fi
fi

# Add WebAssembly tools to PATH
if [ -d "$HOME/AURs/selfbuilt/wasm:/home/cam-o/AURs/selfbuilt/wasm/node/12.9.1_64bit/bin:/home/cam-o/AURs/selfbuilt/wasm/upstream/emscripten" ]; then
	PATH="$PATH:$HOME/AURs/selfbuilt/wasm:/home/cam-o/AURs/selfbuilt/wasm/node/12.9.1_64bit/bin:/home/cam-o/AURs/selfbuilt/wasm/upstream/emscripten"
fi

# Add Android's bin dir to PATH
if [ -d "/opt/android-sdk/tools/bin" ] ; then
	PATH="$PATH:/opt/android-sdk/tools/bin"
fi

# Add forgit
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /home/cam-o/development/hacksugar/blinkOS-Installer/node_modules/tabtab/.completions/electron-forge.bash ] && . /home/cam-o/development/hacksugar/blinkOS-Installer/node_modules/tabtab/.completions/electron-forge.bash

if [ -d "$HOME/bin/github" ] ; then
	PATH="$PATH:$HOME/bin/github"
fi

if [ -d "$HOME/bin/messages" ] ; then
	PATH="$PATH:$HOME/bin/messages"
fi

if [ -d "$HOME/.local/bin" ] ; then
	PATH="$PATH:$HOME/.local/bin"
fi

if which ruby >/dev/null && which gem >/dev/null; then
	GEM_PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
	export PATH="$GEM_PATH:$PATH"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# direnv hook: should always be last line
eval "$(direnv hook bash)"

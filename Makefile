XDGC		= $(HOME)/.config
DOTDIR		= dots
LN		= ln
LNFLAGS		=
LINK		= $(LN) -sfn $(LNFLAGS)

HOME_DIRS	= .config bin                               \
		  .local .local/share .local/src .local/bin \
		  doc doc/desk doc/www                      \
		  media media/pic media/vid media/music

# for $XDG_CONFIG_HOME/* type targets
XDGC_TARGETS	= alacritty    \
		  i3           \
		  bspwm        \
		  dunst        \
		  rofi         \
		  sxhkd        \
		  base16-shell \
		  nvim         \
		  git

### Targets
all:		dir xdg

$(XDGC_TARGETS):
	$(LINK) $(PWD)/$@ $(XDGC)/$(@F)


dir:
	cd '$(HOME)'; mkdir -p $(HOME_DIRS)

xdg:
	$(LINK) ../$(DOTDIR)/$@/user-dirs.dirs $(XDGC)

FIREFOX_DIR	= $(HOME)/.mozilla/firefox
firefox:
	mkdir -p '$(FIREFOX_DIR)/profile/chrome'
	cp $@/profiles.ini '$(HOME)/.mozilla/firefox'
	cd '$(FIREFOX_DIR)/profile/chrome' && \
	    $(LINK) ../../../../$(DOTDIR)/$@/*.css .

compton:
	$(LINK) $(PWD)/$@/* $(XDGC)

bin:
	cd $(HOME)/bin && $(LINK) ../$(DOTDIR)/$@/* .

vim:
	mkdir -p $(HOME)/.vim $(HOME)/.cache/vim
	$(LINK) $(DOTDIR)/$@/vimrc ../.vimrc
	$(LINK) ../$(DOTDIR)/$@/vim-plug ../.vim/

sh:
	$(LINK) $(DOTDIR)/$@/profile ../.profile
	$(LINK) ../$(DOTDIR)/$@/shell $(XDGC)

zsh:	base16-shell
	$(LINK) $(DOTDIR)/$@/zshrc ../.zshrc
	$(LINK) ../$(DOTDIR)/$@/zplug $(XDGC)

tmux:
	mkdir -p $(HOME)/.tmux/plugins
	$(LINK) $(DOTDIR)/$@/tmux.conf ../.tmux.conf
	$(LINK) ../../$(DOTDIR)/$@/tpm ../.tmux/plugins/tpm

npm:
	$(LINK) $(DOTDIR)/$@/npmrc ../.npmrc

redshift:
	$(LINK) $(DOTDIR)/$@/redshift.conf $(XDGC)

xorg: xkb
	$(LINK) $(DOTDIR)/$@/Xresources ../.Xresources
	$(LINK) $(DOTDIR)/$@/xprofile ../.xprofile
	$(LINK) $(DOTDIR)/$@/xinitrc ../.xinitrc

xkb:
	(cd / && sudo patch -u -p0 < "$(PWD)/$@/patch")

.PHONY: all dir xdg
.PHONY: $(XDGC_TARGETS)
.PHONY: firefox compton bin vim sh zsh tmux npm xorg xkb

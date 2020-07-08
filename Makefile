.PHONY: all dotfiles etc ipython

all: dotfiles etc fail2ban ipython

dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; 

i3:
	mkdir -p $(HOME)/.config/rofi $(HOME)/.config/i3 $(HOME)/.config/i3status
	ln -sfn $(PWD)/rofi.config $(HOME)/.config/rofi/config
	ln -sfn $(PWD)/i3.config $(HOME)/.config/i3/config
	ln -sfn $(PWD)/i3status.config $(HOME)/.config/i3status/config

etc:
	if [ ! -d "/etc/docker/seccomp" ]; then sudo mkdir /etc/docker/seccomp; fi
	if [ ! -d "/etc/acpi/actions" ]; then sudo mkdir /etc/acpi/actions; fi
	for file in $(shell find $(CURDIR)/etc -type f -not -name ".*.swp"); do \
		f=$$(echo $$file | sed -e 's|$(CURDIR)||'); \
		sudo ln -s $$file $$f; \
	done
	systemctl --user daemon-reload
	sudo systemctl daemon-reload

fail2ban:
	if [ -d "/etc/fail2ban" ]; then sudo ln -s $$(pwd)/jail.local /etc/fail2ban/jail.local; fi

ipython:
	for file in $(shell find $(CURDIR)/ipython/profile_default/startup -name "*.py"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.ipython/profile_default/startup/$$f; \
	done;

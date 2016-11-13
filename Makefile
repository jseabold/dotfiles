.PHONY: all dotfiles etc

all: dotfiles etc

dotfiles:
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".git"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; 

etc:
	if [ ! -d "/etc/docker/seccomp" ]; then sudo mkdir /etc/docker/seccomp; fi
	for file in $(shell find $(CURDIR)/etc -type f -not -name ".*.swp"); do \
		f=$$(echo $$file | sed -e 's|$(CURDIR)||'); \
		sudo ln -s $$file $$f; \
	done
	systemctl --user daemon-reload
	sudo systemctl daemon-reload

SHELL := /bin/bash
TYPE ?= new-service

.PHONY: venv
venv:
	@if [ ! -d .venv ]; then \
		python3 -m venv .venv; \
		@. .venv/bin/activate && python3 -m pip install --upgrade pip; \
		@. .venv/bin/activate && pip install -r requirements.txt;; \
	fi

.PHONY: ansible
ansible: venv
ifdef TAG
	@. .venv/bin/activate && cd ${TYPE} && ansible-playbook -i hosts site.yml --tags "${TAG}"
else
	@. .venv/bin/activate && cd new-service && ansible-playbook -i hosts site.yml
endif

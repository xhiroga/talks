-include .env

OUT_DIR ?= out

.PHONY: dev

dev:
	@FILE=$$(find . -maxdepth 1 -type f -name '*.md' -print | sed 's|^\./||' | sort -r | fzf --prompt='pnpm dev> '); \
	[ -n "$$FILE" ] || { echo "No markdown selected." >&2; exit 1; }; \
	pnpm dev "$$FILE"

fmt:
	@FILE=$$(find . -maxdepth 1 -type f -name '*.md' -print | sed 's|^\./||' | sort -r | fzf); \
	[ -n "$$FILE" ] || { echo "No markdown selected." >&2; exit 1; }; \
	codex --search "AGENTS.mdに従って\"$$FILE\"と依存先のMarkdownファイルを校閲してください"

pdf:
	@FILE=$$(find . -maxdepth 1 -type f -name '*.md' -print | sed 's|^\./||' | sort -r | fzf --prompt='pnpm export> '); \
	[ -n "$$FILE" ] || { echo "No markdown selected." >&2; exit 1; }; \	BASENAME=$$(basename "$$FILE" .md); \
	mkdir -p "$(OUT_DIR)"; \
	BASENAME=$$(basename "$$FILE" .md); \
	pnpm export "$$FILE" --output "$(OUT_DIR)/$$BASENAME.pdf"

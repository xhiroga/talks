.PHONY: dev

dev:
	@FILE="$(FILE)"; [ -n "$$FILE" ] || FILE=$$(find . -maxdepth 1 -type f -name '*.md' -print | sed 's|^\./||' | sort | fzf --prompt='pnpm dev> '); \
	[ -n "$$FILE" ] || { echo "No markdown selected. Use 'make dev FILE=...'" >&2; exit 1; }; \
	pnpm dev "$$FILE"

pdf:
	@FILE="$(FILE)"; [ -n "$$FILE" ] || FILE=$$(find . -maxdepth 1 -type f -name '*.md' -print | sed 's|^\./||' | sort | fzf --prompt='pnpm dev> '); \
	[ -n "$$FILE" ] || { echo "No markdown selected. Use 'make dev FILE=...'" >&2; exit 1; }; \
	pnpm export "$$FILE"

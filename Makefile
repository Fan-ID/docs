# Sync OpenAPI from backend (source of truth).
BACKEND_SPEC ?= ../backend/specs/public-api/soundlink-public-api-v1.yaml
LOCAL_SPEC   := openapi/soundlink-public-api-v1.yaml

.PHONY: sync-openapi
sync-openapi:
	@test -f "$(BACKEND_SPEC)" || (echo "Missing $(BACKEND_SPEC). Adjust BACKEND_SPEC=..." && exit 1)
	cp "$(BACKEND_SPEC)" "$(LOCAL_SPEC)"
	@echo "Synced $(LOCAL_SPEC) from backend"

.PHONY: dev
dev:
	npx mintlify dev

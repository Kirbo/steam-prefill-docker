@echo off
docker compose -f docker-compose.dev.yml run --rm steam-prefill %*

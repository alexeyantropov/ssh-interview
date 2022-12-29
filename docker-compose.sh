#!/bin/bash
rm -rf ./t/__pycache__
rm -rf ./t/.pytest_cache
rm -rf ./__pycache__
docker compose -f docker-compose.yml up --remove-orphans --force-recreate

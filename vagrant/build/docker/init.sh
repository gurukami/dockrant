#!/bin/bash
/usr/local/bin/docker-compose -f /share/docker-compose.yml build
/usr/local/bin/docker-compose -f /share/docker-compose.yml up -d

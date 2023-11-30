#!/bin/bash

# bat themes hash: {{ glob "../dot_config/bat/themes/*" | include | sha256sum }}
bat cache --build

#!/bin/bash
exec journalctl --since "2 hours ago" -u "$@"

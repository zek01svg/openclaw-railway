FROM ghcr.io/openclaw/openclaw:2026.4.22
# Railway injects $PORT; bind lan (0.0.0.0) so Railway routes traffic correctly
CMD ["sh", "-c", "while true; do node openclaw.mjs gateway --allow-unconfigured --bind lan --port \"${PORT:-18789}\"; echo 'gateway stopped, restarting in 3s...'; sleep 3; done"]
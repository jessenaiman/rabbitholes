# ... (builder stage remains the same)

# Production stage
FROM node:18-alpine
WORKDIR /app

# Install envsubst for runtime variable replacement
RUN apk add --no-cache gettext

# Copy built assets
COPY --from=builder /app/backend/dist ./backend/dist
COPY --from=builder /app/frontend/build ./frontend/build

# Add runtime configuration script
COPY runtime-env.sh /app/runtime-env.sh
RUN chmod +x /app/runtime-env.sh

EXPOSE 3000
ENV PORT=3000 NODE_ENV=production

# Use entrypoint to process environment variables
ENTRYPOINT ["/app/runtime-env.sh"]
CMD ["sh", "-c", "cd backend && node dist/server.js"]
# Production image, copy all the files and run next
FROM node:alpine
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# You only need to copy next.config.js if you are NOT using the default configuration
# COPY --from=builder /app/next.config.js ./
COPY /app/public ./public
COPY --chown=nextjs:nodejs /app/.next ./.next
COPY /app/.bin ./node_modules/.bin
COPY /app/package.json ./package.json

USER nextjs

EXPOSE 3000

ENV PORT 3000
ENV HOST 0.0.0.0

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry.
# ENV NEXT_TELEMETRY_DISABLED 1

CMD [".bin/next", "start"]
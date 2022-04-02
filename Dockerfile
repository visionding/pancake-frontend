# Production image, copy all the files and run next
FROM node
WORKDIR /app

ENV NODE_ENV production

# You only need to copy next.config.js if you are NOT using the default configuration
# COPY --from=builder /app/next.config.js ./
COPY ./public ./public
COPY ./.next ./.next
COPY ./node_modules/.bin ./node_modules/.bin
COPY ./package.json ./package.json

EXPOSE 3000

ENV PORT 3000
ENV HOST 0.0.0.0

RUN npm config set registry https://registry.npm.taobao.org
RUN npm i -g next

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry.
# ENV NEXT_TELEMETRY_DISABLED 1

CMD ["node_modules/.bin/next", "start"]
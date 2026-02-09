# Stage 1: Build Docusaurus docs
FROM node:24.11.0-alpine AS docs-builder

WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Production
FROM nginx:stable-alpine

COPY --from=docs-builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

ARG TAKARO_VERSION=unset
ARG TAKARO_COMMIT=unset
ARG TAKARO_BUILD_DATE=unset

ENV TAKARO_VERSION=${TAKARO_VERSION}
ENV TAKARO_COMMIT=${TAKARO_COMMIT}
ENV TAKARO_BUILD_DATE=${TAKARO_BUILD_DATE}

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# Stage 1: Generate TypeDoc from main Takaro repo
FROM node:24.11.0-alpine AS typedoc-builder

WORKDIR /takaro

# Install git and build dependencies needed for native modules
RUN apk add --no-cache git python3 make g++

# Clone the main Takaro repository
ARG TAKARO_REF=main
RUN git clone --depth 1 --branch ${TAKARO_REF} https://github.com/gettakaro/takaro.git .

# Create reports directory (normally done by dev-init.sh)
RUN mkdir -p reports

# Install dependencies
RUN npm ci

# Build packages (required for TypeDoc to resolve types)
RUN npm run build

# Generate TypeDoc (outputs to ./reports/api-docs)
RUN npm run typedoc

# Stage 2: Build Docusaurus docs
FROM node:24.11.0-alpine AS docs-builder

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source files
COPY . .

# Build the documentation
RUN npm run build

# Copy TypeDoc output into Docusaurus build
COPY --from=typedoc-builder /takaro/reports/api-docs ./dist/api-docs

# Stage 3: Production
FROM nginx:stable-alpine

# Copy built files from docs-builder stage
COPY --from=docs-builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Build arguments for versioning
ARG TAKARO_VERSION=unset
ARG TAKARO_COMMIT=unset
ARG TAKARO_BUILD_DATE=unset

ENV TAKARO_VERSION=${TAKARO_VERSION}
ENV TAKARO_COMMIT=${TAKARO_COMMIT}
ENV TAKARO_BUILD_DATE=${TAKARO_BUILD_DATE}

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM node:20-alpine AS build
WORKDIR /app
COPY frontend-react/package*.json ./
RUN npm ci
COPY frontend-react/ .
RUN npm run build

FROM node:20-alpine
RUN npm install -g serve
WORKDIR /app
COPY --from=build /app/dist .
EXPOSE $PORT
CMD sh -c "serve -s . -l tcp://0.0.0.0:${PORT:-3000}"

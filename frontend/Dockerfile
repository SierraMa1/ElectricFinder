# frontend/Dockerfile

# --- Etapa 1: Construcción (Build) ---
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# --- Etapa 2: Servidor de Producción ---
FROM nginx:stable-alpine

# Copia los archivos estáticos generados en la etapa anterior
COPY --from=builder /app/build /usr/share/nginx/html

# Copia la configuración de Nginx para servir estos archivos
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
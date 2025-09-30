# backend/Dockerfile
FROM node:18-alpine

WORKDIR /app

# Copia solo los archivos de dependencias e instala para aprovechar la caché de Docker
COPY package*.json ./
RUN npm install

# Copia el resto del código de tu aplicación
COPY . .

# Expone el puerto en el que corre tu app (ej. 3001)
EXPOSE 3001

# Comando para iniciar la aplicación
CMD ["npm", "start"]
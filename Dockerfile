FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
#we dont need to make use the volume system anymore, it was
#useful in the development environment, we not changing our code
#in production environment
COPY . .
RUN npm run build

# the output is Build folder
# /app/build   <---- all the stuff we care about

# here come second FROM statement
# every single block can have only one FROM statement


FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

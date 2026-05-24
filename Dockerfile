FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY devops-build/build/ .

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
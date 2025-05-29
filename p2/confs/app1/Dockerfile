FROM alpine/git:v2.47.2 AS build

WORKDIR /

RUN git config --global url."https://github.com/".insteadOf git://github.com/

RUN git clone --recurse-submodules https://github.com/dommmel/coffee-snake.git


FROM nginx:stable-alpine3.21

COPY --from=build /coffee-snake /coffee-snake

RUN echo " \
server { \
    listen 8080; \
    location / { \
        root /coffee-snake; \
        autoindex on; \
    } \
}" > /etc/nginx/conf.d/default.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
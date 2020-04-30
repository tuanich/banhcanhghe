version: '3'
services:
  db:
    image: mysql:5.7
    ports:
      - 127.0.0.1:3306:3306
    command: [
        '--default_authentication_plugin=mysql_native_password',
        '--character-set-server=utf8mb4',
        '--collation-server=utf8mb4_unicode_ci'
    ]
    volumes:
      - db_data:/var/lib/mysql
    environment:
      MYSQL_DATABASE: banhcanhtrang
      MYSQL_ROOT_PASSWORD: Alibaba@123
    container_name: db
     
  wp:
    build:
      context: ./docker
      dockerfile: Dockerfile-wp
    ports:
      - 127.0.0.1:80:80
    volumes:
      - ./docker/php.conf.ini:/usr/local/etc/php/conf.d/conf.ini
      - ./app:/var/www/html
    depends_on:
      - db
    links:
      - db
    environment:
      DB_NAME: banhcanhtrang
      DB_USER: root
      DB_PASSWORD: Alibaba@123
      DB_HOST: db
    container_name: wp
    
  #WP_DEBUG: 1
      #LIVE_URL: https://banhcanhghetrang.vn
      #DEV_URL: http://www.banhcanhghetrang.vn
volumes:
  db_data: # store database into a volume so that we can pause the containers

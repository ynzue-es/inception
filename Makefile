# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ynzue-es <ynzue-es@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/18 09:59:49 by yannis            #+#    #+#              #
#    Updated: 2026/04/16 16:41:45 by ynzue-es         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= inception
COMPOSE		= cd srcs && docker compose
DATA_DIR	= /home/$(shell whoami)/data

all: start

start:
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) up -d --build

build:
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) build

up:
	@mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	$(COMPOSE) down --rmi all -v --remove-orphans
	@sudo rm -rf $(DATA_DIR)/mariadb/* $(DATA_DIR)/mariadb/.[!.]* 2>/dev/null || true
	@sudo rm -rf $(DATA_DIR)/wordpress/* $(DATA_DIR)/wordpress/.[!.]* 2>/dev/null || true

re: fclean start

.PHONY: all start build up down clean fclean re
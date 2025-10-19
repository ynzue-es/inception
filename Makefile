# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yannis <yannis@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/18 09:59:49 by yannis            #+#    #+#              #
#    Updated: 2025/10/19 18:35:30 by yannis           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = cd srcs && docker compose

start:
	$(COMPOSE) build && docker compose up

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down

fclean:
	$(COMPOSE) down --rmi all

re: fclean
	$(COMPOSE) build
	$(COMPOSE) up
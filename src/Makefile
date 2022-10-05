# Makefile for compiling and linking .C files with asm files

# -m32 compiles .C to 32bit assembly (Needs package gcc-multilib)
# -masm=att Compiles .C with at&t assembly systax

# Makefile
# 26.08.2022 (Fredrik Mørstad & Fredrik Fasteraune): 
# Added docker sub-command

CC = gcc
CFLAGS = -m32 -masm=att
DOCKER_COMPOSE=.docker/docker-compose.yml
DOCKERFILE=.docker/Dockerfile

all: program

# To change optimization levels on .C file change -O0 to either -O1, -O2, -O3
# Optimization levels GCC https://gcc.gnu.org/onlinedocs/gnat_ugn/Optimization-Levels.html
main: main.c Makefile
	$(CC) $(CFLAGS) -O0 -S -o $@.s $<  

# asm.S and main has to exist before executing compilation targets
program: asm.S main
	$(CC) $(CFLAGS) -E $< > $@_pp.s
	$(CC) $(CFLAGS) main.s $@_pp.s -o $@

docker: $(DOCKERFILE) $(DOCKER_COMPOSE)
	docker compose -f $(DOCKER_COMPOSE) build
	docker compose -f $(DOCKER_COMPOSE) up -d
	docker exec -it assignment-1 bash ; docker compose -f $(DOCKER_COMPOSE) down

clean: 
	rm -rf *.o program program_pp.s main.s

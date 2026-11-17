main: main.c main_helper.c defs.h
	clang -g -D_FILE_OFFSET_BITS=64 -Wall -Wpedantic -Wextra -Werror -Wno-dollar-in-identifier-extension -std=c23 main.c -g main_helper.c `pkg-config fuse-t --cflags --libs` -o main

dump: dump.c main_helper.c defs.h
	clang -g -Wall -Wpedantic -Wextra -Werror -std=c23 dump.c main_helper.c `pkg-config fuse-t --cflags --libs` -o dump

val: main
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt ./main fs

c: clean
clean:
	rm -r main dump data main.dSYM

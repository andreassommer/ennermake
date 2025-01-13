# Directory accessors

sp              := $(sp).x
dirstack_$(sp)  := $(d)
d               := $(dir)


# sp             : stack pointer
# dirstack_$(sp) : directory stack
# d              : current directory
# dir            : directory to descend next



# Directory accessors

ennermake_sp                       := $(ennermake_sp).x
ennermake_dirstack_$(ennermake_sp) := $(ennermake_curdir)
ennermake_curdir                   := $(ennermake_nextdir)
d                                  := $(call ennermake_generate_safe_name, $(ennermake_nextdir))

# d := $(d)
# ennermake_sp            : stack pointer
# ennermake_dirstack_$(sp): directory stack
# ennermake_curdir        : current directory
# d                       : safe name of current directoy
# ennermake_nextdir       : directory to descend next



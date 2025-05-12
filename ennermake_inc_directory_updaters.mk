# Update directory stack

ennermake_curdir   := $(ennermake_dirstack_$(ennermake_sp))
ennermake_sp       := $(basename $(ennermake_sp))
d                  := $(call ennermake_generate_safe_name, $(ennermake_curdir))


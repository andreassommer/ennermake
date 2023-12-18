# Update directory stack

d   := $(dirstack_$(sp))
sp  := $(basename $(sp))

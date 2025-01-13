ENNERMAKE Build System

Directories

./       Main directory with all ennermake_XXX.mk makefiles
./basedirmakefile  template directory with ennermake files to be put in project base dir
./subdirmakefiles  template directory with ennermake files to be put in project subdirectories


Initialization

From the project base directory, invoke
```
./ennermake/ennermake_init.sh .
```
This will generate required config files.
For a re-init, invoke with `--force` flag to overwrite (delete!) existing configuration.





# ENNERMAKE Build System

## Directories

./            main directory with all ennermake_XXX.mk makefiles
./templates   template directory with ennermake files to be put in project base directory or subfolders
./examples    some examples from an existing project (pdo)


## Initialization

From inside the _project base directory_, invoke
```
./ennermake/ennermake.sh init .
```
This will generate required files.
For a re-init, invoke with `--force` flag to overwrite (delete!) existing configuration.

To initialize a _subdirectory_, change to that subdirectory and invoke
```
./ennermake/ennermake.sh initsub .
```
This will generate required files.
For a re-init, invoke with `--force` flag to overwrite (delete!) existing configuration.





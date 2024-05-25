# Repo Check
Repo Check is just a simple script that checks the ahead/behind status for repositories. I use this as I work across multiple machines, across different projects. It is also beneficial as I follow many open source projects.

# How does it work?
## No flags
When executing the script with no parameters, it will check if the current directory is a git repository, if so, it will perform the repo check.

## Run recursively
By providing the `R` flag, the script will recursively run at a depth level of 1. This is a slight modification from the original script as I retain my repositories in a single location under a folder called `Development`.


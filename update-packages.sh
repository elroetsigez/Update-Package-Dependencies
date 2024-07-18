#!/bin/bash

if [ -z "$1" ]; then
  echo "================================================================="
  echo "EditR - Edit files across multiple directories"
  echo "Pass in a directory that contains the package.json, and it will update the outdated packages"
  echo "================================================================="
  echo "  Usage: $(basename $0) <...directories>"
  echo;
  echo "  Example:"
  echo "    $(basename $0) /path/to/directory1 /path/to/directory2"
  echo "-----------------------------------------------------------------"
  exit 1
fi

# Setup Names
branch_name="Update-package-dependencies"
commit_message="Package.json up-to-date"
commit_description="This PR updates the package.json file"

# All remaining parameters are added to the list of directories to edit
directories=$@ 

for directory in "$@"; do
  echo "================================================================="
  echo -e "\n$directory\n"

  # Change the directory to the current directory in the loop
  cd "$directory"

  # Find all directories that contain a package.json file
  for dir in $(find . -type d -name 'test' -exec test -e '{}/client/package.json' ';' -print); do
    echo "...checking for package.json in $dir/client..."
    echo "...found package.json, updating packages..."

    # Rebase from master and create a new branch
    git pull origin master
    git checkout -b "$branch_name"

    # Navigate to the test/client directory- Update package.json -Nav back to directory
    cd "$dir/client"
    npx npm-check-updates -u
    cd -

    # Stage the changes- Commit -Push changes to current branch
    git add -A
    git commit -m "$commit_message"
    git push -u origin "$branch_name"

    # Display message of changes made
    echo "Pushed changes to - $branch_name"

    # Create a pull request
    gh pr create --base master --head $branch_name --title "$commit_message" --body "$commit_description"


  done

  # Change back to the original directory
  cd -

  echo "================================================================="
done;

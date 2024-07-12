# Running Update-package.sh

This script updates test packages for all the repos in a directory. Then creates a branch foreach and pushes it to the branch. All that is left is to create a pull request on Github foreach repo.
To run it, follow these steps:

1. **Prerequisites:**
   - Make sure you have all the repos under a directory.
   - Have the update-package.sh in the same directory as your repos. (not neccesary but preffered)

2. **Usage:**
   - Open a terminal.
   - Navigate to the directory where the script is located.
   - Run the script using the following command:
     ```
     chmod +x update-package.sh
     ```
     ```
     ./update-package.sh . 
     (If the script is not in the same directory as the repos then replace the '.' with the path to the directory of the repos)
     ```
   - Wait for the script to run
   - You'll see different repos and dependacies needed foreach package  printed on the screen. 
   - In adition, you will see branch created for each repo after package.json is up-to-date and pushed to the branch with a commit message.

3. **Customization:**
   - Modify the script as needed for your specific use case.

---


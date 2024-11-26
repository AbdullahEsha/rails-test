The error occurs because the Ruby version specified in your project's `.ruby-version` file (`3.2.2`) is not installed on your system via `rbenv`. Here's how to resolve it:

### Steps to Solve:
1. **Check Available Ruby Versions**
   ```bash
   rbenv install -l
   ```
   This will list all available Ruby versions. Ensure that `3.2.2` is listed.

2. **Install Ruby 3.2.2**
   Install the required version of Ruby:
   ```bash
   rbenv install 3.2.2
   ```

3. **Set the Ruby Version for Your Project**
   Navigate to your project's directory and reinitialize `rbenv`:
   ```bash
   cd /Users/islamnymul/DEVELOP/rails-test
   rbenv local 3.2.2
   ```

4. **Rehash rbenv**
   Update `rbenv` to ensure the new version is recognized:
   ```bash
   rbenv rehash
   ```

5. **Verify Installation**
   Confirm the correct Ruby version is being used:
   ```bash
   ruby -v
   ```
   It should display `3.2.2`.

6. **Install Bundler**
   After setting the correct Ruby version, install `bundler` if it's not already installed:
   ```bash
   gem install bundler
   ```

7. **Install Project Dependencies**
   Inside your project directory, run:
   ```bash
   bundle install
   ```

### Notes:
- If the installation of Ruby fails, ensure you have the necessary dependencies installed on your system. For example, on macOS:
  ```bash
  brew install openssl readline zlib
  ```
- Restart your terminal session or use `exec $SHELL` after installing a new Ruby version to refresh your environment.

This should resolve the issue! Let me know if you encounter any errors during these steps.

- execute seed command for roles
 
    ```bash
    rails db:seed
    ```
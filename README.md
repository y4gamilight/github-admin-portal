# PROFILE GITHUB ADMIN PORTAL PROJECT

### Information
**Author:** Le Tan Thanh  
**Email:** thanhlt.ios.36@gmail.com  
**Description:** This app demonstrates the usage of the GitHub API. It fetches users and displays their repositories.

**Main Features:**
- Fetch GitHub users with load more and pull-to-refresh functionality.
- Open GitHub user details upon clicking a user.
- Support for local database storage and offline access.
- Open GitHub profiles when clicking GitHub links.
- Implement unit tests.
- Support for iOS 12 and later.
- Support for localization.

### 1. Prerequisites
- macOS 14.7 (23H124)
- Xcode 15.1 
Note: My MacBook upgraded Sanoma OS, and it doesn't allow run XCode 14 anymore 

### 2. Setup
1. Create a Personal Access Token (PAT) with your GitHub account. Follow the documentation [here](https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens).
2. Open the `APIEnvironment` file and replace `<YOUR_TOKEN>` with the PAT you created.

### 3. Technical Stack
- **Language:** Swift
- **Pattern:** MVVM-C, Clean Architecture, DIContainer

### 4. Known Issues
- Migration between remote and local storage have some issues, it can replace fully data by lack of data
- The index items and local storage data are different, causing a flash of changes when the app opens due to remote data updating and replacing local data.
- Network errors and some error cases are not handled.

### 5. Areas for Improvement
- Support for GitHub API token refresh.
- Allow token input and storage using Keychain.
- Integrate build tools.
- Refactor code in `DatabaseManager` and `DataSource` classes.
- Implement a `UseCase` class to handle storage and manage logic for session timeouts or network issues.

# PROFILE GITHUB ADMIN PORTAL PROJECT
### Information
Author: Le Tan Thanh
Email: thanhlt.ios.36@gmail.com
Description: App demo about using Github API. App will try to request fetching users and show their repositories.
Main Features
- Get Github's users, user can load more and pull to refresh.
- Open Github User detail when click one of user 
- Support store local db, and open when offline
- Open github profile when user click github's link
- Implement unit tests
- Support iOS 12 and later
- Support Localization

### 1.Prerequisite
Mac OS 14.7 (23H124)
XCode 15.1

### 2.Setup
Step 1: Create Personal Access Token with your github's account. Follow document [https://docs.github.com/en/enterprise-server@3.9/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens](Managing your personal access tokens
)
Step 2: Open file APIEnviroment and replace <YOUR_TOKEN> by PAT which was created.

### 3. Technical stacks
Language: Swift
Patern: MVVM-C, CLEAN ARCHITECTURE, DIContainer

### 4. Known issues
- Haven't migrated between remote and local yet.
- Haven't catch network error and miss something error case

### 5. Need Improvement 
- Support refresh token github API.
- Allow input token and store by Keychain
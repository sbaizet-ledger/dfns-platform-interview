# Design decision
## Module usage
The use of a module to generate the required resources for this application seems to be the right choice here.
All the resources needed for this application are created from 1 module, making it easy to re-use, and easy to adapt to
each env by changing some parameters.

Note : I do not use versioning for this module as this is an exercice, but module versioning would be required.

## Loop or dedicated terraform for each env ?
Regarding how to easily spin up a new environment, I had a choice.
I could see 2 options : 
- loop over a list of environment
- have a dedicated terraform state and folder for each environment

## Loop option
The first option would have been to loop over a list of environment.
In that case, creating a new environment is as easy as adding a string to this list.
But with this approach, it is a bit harder to differentiate each env, for example if production needs other resources.
We could add this logic to the module though.
Another issue is the terraform state file which may grow exponentially, taking more and more time to create a 
`terraform plan` and `terraform apply` as the number of resources controlled by this terraform instance grows.
A final issue is the fact that this is more error prone, a mistake on development environment could spread to production
easily.

## Dedicated folder and terraform state
This approach makes it a bit more complicated to spin up a new env, it basically requires someone to copy/paste the terraoform folder
and change the required parameters.
But it reduces the terraform state, clearly dedicate a folder for each environment and make the config looks cleaner.

I decided to go with this second option


Note : 
- maybe we can improve VAGRANT_USER by creating a local variable
- docker network

# CI/CD pipeline
## CI
I would usually add the following CI for terraform 
- terraform linting : using the tflint tool, this help linting the code and with the help of plugins can also help
ensuring the resources are correcly configured.
- terraform fmt : this terraform command can check if the terraform code is correctly formated

## CD
For CD, the use of a tool such as Atlantis could help, or it could be re-coded in a github action. 
The idea is when a PR is created, to see in a comment the `terraform plan` and when merged, to automatically run 
`terraform apply`
I usually use Atlantis tool for this.
https://www.runatlantis.io/

## Extra
An extra CI could be added to detect potential code drift, for instance if someone changed something manually on the 
cloud but not by code.
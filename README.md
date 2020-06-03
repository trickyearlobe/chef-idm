# chef-idm Gem

## What is it?
It's a widget for syncing users from Active Directory (AD) to Chef server.

- Registers the users and their details with Chef server
- Associates users with the correct Chef Orgs using AD groups
- Creates Chef groups in the correct Orgs
- Adds users to the correct groups
- Removes users from Orgs/Groups when they are removed in AD

## Installation
On your Chef server
* Install a recent ChefDK or Chef Workstation.
* Set up any paths needed to be able to use the embedded ruby/rake that belong to the ChefDK/Workstation
* Get the sourcecode, built it and install it

``` bash
# Get the source code
git clone git@github.com:trickyearlobe/chef-idm.git

# Build and install the GEM
cd chef-idm
rake install
```

**PLEASE DON'T** `rake install` this GEM directly into the embedded ruby that belongs to Chef server.
Doing so may prevent your Chef server restarting until you fix the permissions.

## Usage

Make a config file at `~/.chef-idm/config.json` (~/ is the user's home directory)

Fill it with config like this

``` json
{
  "ad_bind_dn":       "CN=chefidm,OU=users,DC=contoso,DC=local",
  "ad_base_dn":       "dc=contoso,dc=local",
  "ad_bind_password": "secret_bind_password!",
  "ad_fqdn":          "dc1.contoso.local",
  "ad_port":          "389",
  "chef_user":        "pivotal",
  "chef_pem":         "/etc/opscode/pivotal.pem",
  "chef_fqdn":        "chef.contoso.local",
  "chef_default_user_password": "secretuserpassword!",
  "organizations": {
    "contoso": {
        "allowed": "CN=Chef Users,OU=chef,DC=contoso,DC=local",
        "ignore": ["delivery","admin"],
        "groups": {
          "admins": "CN=contoso-chef-admins,OU=chef,DC=contoso,DC=local",
          "group1": "CN=group1,OU=chef,DC=contoso,DC=local",
          "group2": "CN=group2,OU=chef,DC=contoso,DC=local"
        }
    }
  }
}
```

* `organizations` contains the list of Chef orgs to be managed
* `allowed` is the AD group that allows membership of a specific org.
* `ignore` stops the tool managing certain users in an org
* `groups` is a mapping of Chef Groups and AD groups to be created/populated
* `chef_default_user_password` is the Chef default local user password. It's only used when AD/LDAP is disabled. If not set, a randomised password will be used.

## Syncing with AD

``` bash
chef-idm
```

## Updating user data from AD

If you somehow managed to get users with no/incorrect data for names, emails etc. you can repopulate the ones managed by `chef-idm` from LDAP like this

``` bash
chef-update-users
```

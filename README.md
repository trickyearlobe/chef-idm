# chef-idm Gem

## Installation

``` bash
cd path/to/chef-idm
rake install
```

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

## Syncing with AD

``` bash
chef-idm
```

## Updating user data from AD

If you somehow managed to get users with no/incorrect data for names, emails etc. you can repopulate the ones managed by `chef-idm` from LDAP like this

``` bash
chef-update-users
```
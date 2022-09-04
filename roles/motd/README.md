Role Name
=========

Ansible role to manage MOTD

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

|Variable Name|Default Value|Required|Description|Example|
|:---:|:---:|:---:|:---:|:---:|
|`motd_default_message`|""|no|Defines a default message to apply above any custom messages|'Welcome to my server'|
|`motd_static`|"true"|no|Defines if static configured motd info using Ansible facts is enabled|'false'|
|`etc_profile_d_dymotd_file_src`|"etc/profile.d/dymotd.sh"|no|Defines dynamic MOTD variables|''|
|`etc_profile_d_dymotd_file_dest`|"{ path: '/etc/profile.d/dymotd.sh', owner: 'root', group: 'root', mode: '0775' }"|no|Dictionary that defines dynamic MOTD destination file variables||''|


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).

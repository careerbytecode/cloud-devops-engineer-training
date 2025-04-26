## scenario 1: Bulk User Creation & Bulk user Deletion Using Role ?


```
cd roles
ansible-galaxy init usermgmt
```

```
vim usermgmt/vars/main.yml
```

```
staff:
        - alice
        - fred
        - robin
        - natasha
        - eric
guests:
        - rob
        - bob
        - michael
        - williams
        - julia
revoke:
        - sara
        - frank
        - larry
        - lisa
        - roger
```

- save the file


```
vim usermgmt/tasks/main.yml
```

```
---
- name: User Creation progress
  debug:
   msg: "All users will be created and added to the respective groups"
```

- go to parent directory where you have ansible.cfg file is there.
- create new playbook like below

```
vim user.yml
```

```
---
- name: create user and groups
  hosts: all
  roles:
   - usermgmt
  tasks:
   - name: create group
     group: 
      name: "{{ item }}"
      state: present
     with_items:
      - administrators
      - developers
      - managers
   - name: create STAFF USER
     user:
      name: "{{ item }}"
      state: present
      groups: administrators,developers
     with_items:
      - "{{ staff }}"
   - name: create guests USER
     user:
      name: "{{ item }}"
      state: present
      groups: developers,managers
     with_items:
      - "{{ guests }}"
   - name: revoke the USER
     user:
      name: "{{ item }}"
      state: absent
     with_items:
      - "{{ revoke }}"
```

```
ansible-playbook user.yml
```


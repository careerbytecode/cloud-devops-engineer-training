# Installing ansible server and setting up the client1,client 2 environments

## create ubuntu 20 lts - 3 servers - 1 Ansible server and 2 Ansible clients

## below u need to install only in ansible server

```
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible rpm tree vim -y 
```

## Run the command on Client1 and Client2 server

```
sudo apt update
sudo apt install sshpass tree rpm vim -y
```

# add DNS entries manually in all 3 nodes

```
vi /etc/hosts
```
```
10.128.15.203 client1
10.128.15.204 client2
10.128.15.202 server
```

## SSH connection need to be enabled if you are using cloud machines

## Step 1: SSH Configuration
## Ensure SSH Access: Make sure direct SSH access is enabled on both machines.

## For Google Cloud (GCP):
## Update the SSH configuration file on both machines.
```
sudo vim /etc/ssh/sshd_config
```
## Ensure these lines are present:
```
PasswordAuthentication yes
ChallengeResponseAuthentication yes
```
## Save and exit the file, then restart SSH service:
```
sudo service sshd restart
```
## For Azure Cloud (Ubuntu VM):
Update the SSH configuration file.
```
sudo vim /etc/ssh/sshd_config
```
## Ensure these lines are present:
```
PasswordAuthentication yes
KbdInteractiveAuthentication yes
```
## Save and exit the file, then restart SSH service:
```
sudo service sshd restart
```
## Create user called ansible in all machines
```
adduser ansible
```

- Enter the password as 
```
ranga12345
```
## Login to all servers and enable sudo permission for ansible user with no password

- Run visudo command

```
visudo
```

```
ansible	ALL=(ALL:ALL) NOPASSWD: ALL
```

- in ubuntu press ctrl + o and then press enter to write , to exit press ctrl +  x


## Login as ansible user into ansible server 

```
sudo su - ansible
```

## Create ssh keys in ansible server.Run this command only in ansible server as ansible user

```
ssh-keygen
```

## Copy SSH keys from ansible server to clients as ansible user 

- go to ansible server and perform the below steps as ansible user.It will ask for the password, Please provide the password

```
ssh-copy-id client1
```
```
ranga12345
```
```
ssh-copy-id client2
```


Perform the below steps only on ansible server

- login ansible user in ansible server, Its should login into client 1 and client 2 wihtout the password

```
ssh client1
```
```
ssh client2
```


## to see the ansible version in the ansible server
```
ansible --version
````

## Create your environment directories in the ansible server

  
Create dev directory. 
````
mkdir dev
````
````
cd dev
````
Create ansible.cfg file like below
 ```
   vim ansible.cfg
```
```
[defaults]
inventory=hosts
remote_user=ansible
timeout=3000

[privilege_escalation]
become=True
become_method=sudo
become_user=root
become_ask_pass=False
```

- in hosts file add your servers like below. (static inventory file)

```
vim hosts
```
```
[dev1]
client1
[dev2]
client2

```



## Test your ansible environment is correctly configured or not ?

```
ansible all --list
```

```
hosts (2):
    client1
    client2

```

## Test your client servers connectivity from ansible ?

```
ansible all -m ping
ansible client1 -m ping
ansible client2 -m ping
ansible client1,client2 -m ping

```

- --> you must receive ping / pong in green


##  Configure VIM Editor purpose .To Avoid intend issues

- go to /home/ansible/ home directory

```
vim .vimrc
```

```
set ai
set tabstop=2
set expandtab
```

- save this file .Then logoff and login .

- Or 

```
source ~/.vimrc
```


*******************************************************************************************************************

- Step 1.	Ansible-doc
- Step 2.	yaml or .yml files
- Step 3.	How to construct playbook
- Step 4.	To ensure syntax issues in playbook before you execute playbooks
- Step 5.	To see detailed output while playbook getting execute dry run
- Step 6.	To execute the playbook
- Step 7.	View and identify the log files for the client 1 and client 2
- Step 8.	Install multiple packages using ansible
- Step 9.	Stop and start services using ansible
- Step 10.	Install packages and restart the services using ansible
- Step 11.	Create a directory and copy the file in to that directory using ansible
- Step 12.	Introduction to handlers
- Step 13.	Introduction to tags
- Step 14.	Introduction to group condition
- Step 15.	Introduction to Adoc commands
- Step 16.	Copy files from ansible server to clients
- Step 17.	Copy files between the client machines using the remote_src command
- Step 18. singleurl and multipleurl check using the roles with examples





## Step 1 : ansible-doc

- to check the ansible doc contents

```
ansible-doc -l
```

- to check the contents word count 

```
ansible-doc -l | wc -l
```

- ansible-doc -l | grep package

```
ansible-doc yum
ansible-doc -l | grep -i file
```


## Step 2: .yaml or .yml files

- **YAML Ain't Markup Language**

- **Yet Another Markup Language**

## Step 3 : How to construct playbook

```
vim install_zip.yaml
```

```
---  
- name: i am going to sleep
  hosts: all
  tasks:
  - name: install zip package
    apt:
         name: zip
         state: latest
```

## Step 4:To ensure syntax issues in playbook before you execute playbooks
```
ansible-playbook install_zip.yaml --syntax-check
```

## Step 5: To see detailed output while playbook getting executeddry run

```
ansible-playbook install_zip.yaml -C
```

## Step 6: To execute the playbook 

```
ansible-playbook install_zip.yaml
```


## Step 7: View and identify the log files for the client 1 and client 2 

- before you execute ansible-playbook command login client 1 and client 2 and run the below command.The execute ansible-playbook command which you will get very good idea how ansible servers is talking to ansible client and implementing via playbook

````````
sudo tail -f /var/log/syslog
````````


## Step 8 : Install multiple packages using ansible

```
vim install_multiplep.yaml
```

```
---
- name: i am going to install multiple softwares
  hosts: all
  tasks:
   - name: install packages
     apt:
      pkg:
       - apache2
       - vim
```

```
ansible-playbook install_multiplep.yaml --syntax-check
```
```
ansible-playbook install_multiplep.yaml -C
```
```
ansible-playbook install_multiplep.yaml
```

-------------------------------------------------------

## Step 9 : Stop and start services using ansible 


```
vim install_start_stop.yaml
```

```
---
- name: i am going to install multiple softwares
  hosts: all
  tasks:
   - name: install packages
     apt:
      pkg:
       - apache2
       - vim
   - name: start the apache2 service
     ansible.builtin.service:
      name: apache2
      state: started
```
```
ansible-playbook install_start_stop.yaml --syntax-check
```
```
ansible-playbook install_start_stop.yaml -C
```
```
ansible-playbook install_start_stop.yaml
```


------------------------------------------------------

## Step 9 : Install packages and restart the services using ansible

```
vim install_soft_restart_services.yaml
```
- vim install_soft_restart_services.yaml


```
---
- name: install httpd
  hosts: all
  tasks:
   - name: install httpd
     apt:
      name: apache2
      state: latest
   - name: restart web service
     service:
      name: apache2
      state: restarted
   - name: install vsftpd
     apt:
      name: vsftpd
      state: latest
   - name: restart web service
     service:
      name: vsftpd
      state: restarted
```

```
ansible-playbook install_start_stop.yaml --syntax-check
```

```
ansible-playbook install_start_stop.yaml -C
```

```
ansible-playbook install_start_stop.yaml
````````

---------------------------------------------------------------------------------------
## Step 10 : create adirectory and copy the file in to that directory uisng ansible 

```
vim createdir_copypdf.yaml
```

```
---
- name: create adirectory and copy the file in to that directory
  hosts: all
  tasks:
   - name: create a directory
     ansible.builtin.file:
      path: /var/tmp/ranga
      state: directory
      mode: '0755'
   - name: download the file and copy to the above directory
     get_url:
      url: https://www.tempestns.com/wp-content/uploads/2021/04/Engineering-DevOps.pdf
      dest: /var/tmp/ranga
      mode: '0440'
```

```
ansible-playbook createdir_copypdf.yaml --syntax-check
```

```
ansible-playbook createdir_copypdf.yaml -C
```

```
ansible-playbook createdir_copypdf.yaml
````````

--------------------------------------------

## Step 11 : Introduction to handlers

```
vim handlers.yaml
```

```
---
- name: install httpd
  hosts: all
  tasks:
   - name: install httpd
     apt:
      name: apache2
      state: latest
     notify:
      - restart web service
   - name: install vsftpd
     apt:
      name: vsftpd
      state: latest
     notify:
     - restart vsftpd service
  handlers:
   - name: restart web service
     service:
      name: apache2
      state: restarted
   - name: restart vsftpd service
     service:
      name: vsftpd
      state: restarted
```


## testing 1 - run this command from client 1

```
sudo apt remove apache2 -y

```

## testing 2 - run this command from client 2

```
sudo apt remove vsftpd -y

```

## checking - execute the playbook now.See now you can see the handlers working

```
ansible-playbook handlers.yaml --syntax-check
```

```
ansible-playbook handlers.yaml -C
```

```
ansible-playbook handlers.yaml
````````


## Step 12 : Introduction to tags

```
ansible-playbook <playbook name>  --list-tags
```

```
vim handlers_tags.yaml
```


```
---
- name: install httpd
  hosts: all
  tasks:
   - name: install httpd
     apt:
      name: apache2
      state: latest
     notify:
      - restart web service
     tags:
      - apache2
   - name: install vsftpd
     apt:
      name: vsftpd
      state: latest
     notify:
     - restart vsftpd service
     tags:
      - vsftpd
  handlers:
   - name: restart web service
     service:
      name: apache2
      state: restarted
   - name: restart vsftpd service
     service:
      name: vsftpd
      state: restarted
```


```
ansible-playbook handlers_tags.yaml  --list-tags
```

```
ansible-playbook handlers_tags.yaml  --tags apache2
```

- now only apache 2 tasks will be executed.

- just for reference - ansible-playbook <playbook name>   --skip-tags

- now you want to run playbook step by step with your each confirmation

```
ansible-playbook <playbook name>  --step
```


## Step 13 : Introduction to groupcondition

```
vim groupcondition.yaml
```


```
---
- name: install httpd
  hosts: all
  tasks:
   - name: install httpd
     apt:
      name: apache2
      state: latest
     notify:
      - restart web service
     tags:
      - apache2
     when: inventory_hostname in groups ['prod']
   - name: install vsftpd
     apt:
      name: vsftpd
      state: latest
     notify:
     - restart vsftpd service
     tags:
      - vsftpd
     when: inventory_hostname in groups ['dev']
  handlers:
   - name: restart web service
     service:
      name: apache2
      state: restarted
   - name: restart vsftpd service
     service:
      name: vsftpd
      state: restarted
```


```
ansible-playbook groupcondition.yaml
```

- now client 2 will be skipped in task1.client 1 will be skipped in task 2


## Step 14 : Introduction to Adoc commands 

### Using the shell module looks like this:

```
ansible all -m shell -a 'echo $TERM'
```

### To transfer a file directly to many servers:

```
echo "my name is rangaraj" > /var/tmp/test.txt
```
```
ansible all -m copy -a "src=/var/tmp/test.txt dest=/var/tmp/testing.txt"
```


- now go to client 1 and client 2 check /var/tmp/testing.txt this file is there and what is inside ?



### File Transfer

- The file module allows changing ownership and permissions on files. These same options can be 
  passed directly to the copy module as well:

```
ansible webservers -m file -a "dest=/var/tmp/testing.txt mode=600"
ansible webservers -m file -a "dest=/var/tmp/testing.txt mode=600 owner=ansible group=users"
```

- The file module can also create directories, similar to mkdir -p:

```
ansible webservers -m file -a "dest=/var/tmp/testing12 mode=755 owner=ansible group=users state=directory"
```

As well as delete directories (recursively) and delete files:

```
ansible webservers -m file -a "dest=/var/tmp/testing state=absent"
```


Here are the commands you can use to get the uptime. All three commands would yield you the same results.

```
ansible all -m command -a uptime 
ansible all -m shell -a uptime 
ansible all -a uptime
```

- ansible ad hoc command to check memory usage

```
ansible all -a "free -m"
```


- ansible ad hoc command to get physical memory allocated to the host

```
ansible all -m shell -a "cat /proc/meminfo|head -2"
```


- ad hoc command to Create a unix user group

```
ansible all -m group -a "name=weblogic state=present" 
```

- adhoc command to Create a unix user

```
ansible all -m user -a "name=weblogic group=weblogic" -b
```


## Step 15 : Copy files from ansible server to clients

```
vim copy.yaml
```

```
---
- name: Copy file with owner and permissions
  hosts: all
  tasks:
   - name: Copy a new "ntp.conf file into place, backing up the original if it differs from the copied version
     copy:
      src: /etc/hosts
      dest: /var/tmp/hosts
      owner: ansible
      group: ansible
      mode: '0644'
      backup: yes
```

## Step 16 : Copy files between the client machines using the remote_src command

- Ansible copy allows you to copy the files from one directory to another on the same remote machine. But this is only for files, not for the directories. You can use the remote_src parameter to let Ansible know your intentions.

- The below code will copy /tmp/test.txt to the home directory of the user (/home/[username]/).

```
--- 
- name: copy the file within client machines itself
  hosts: all
  tasks:
   - name: create a file with some content
     copy:
      content: "local file"
      dest: /var/tmp/test.txt
   - name: copy the file within client machines itself
     copy:
      src: /var/tmp/test.txt
      dest: /var/tmp/test.{{ansible_date_time.date}}.txt
      remote_src: yes

```

- remote_src option is very important


## Step 17 - Ansible Register

- **condition** 
- need to check the package
- if package is not there print message that package is not installed
- if package is there means print message that package has been installed
- if package is not there then install the package


- note : manually install vsftpd in client 1.dont install vsftpd in client 2.Then start this lab

```
vim package.yaml
```

```
---
- name: check the pakcage and register and install if necessary
  hosts: all
  ignore_errors: true
  tasks:
   - name: check the package
     command: dpkg-query -l vsftpd
     register: checkpackage
   - name: print register output
     debug:
      var: checkpackage
   - name: print package is not installed
     debug: 
      msg: "vsftpd package not installed"
     when: checkpackage.rc == 1
   - name: print package is installed
     debug:
      msg: "vsftpd package has been installed."
     when: checkpackage.rc == 0
   - name: print package has been installed
     debug:
      msg: "vsftpd package has been installed"
     when: checkpackage.msg == ""
   - name: print package not installed
     debug:
      msg: "vsftpd package not installed"
     when: checkpackage.msg != ""
   - name: install vsftpd package if not installed.if installed leave it.
     apt:
      name: vsftpd
      state: latest
     when: checkpackage.msg != ""
```

```
vim file.yaml 
```

```
---
- name: check directory if not created then create it
  hosts: all
  ignore_errors: true
  tasks:
   - name: check directory
     command: ls -ltrh /var/tmp/ranga
     register: checkdir
   - name: print json output
     debug:
      var: checkdir
   - name: print filesystem is not present
     debug :
      msg : "filesystem is not present in the server"
     when : checkdir.rc == 2
   - name: print filesystem is present
     debug :
      msg : "filesystem is present in the server"
     when : checkdir.rc == 0
   - name: Create a directory if it does not exist
     ansible.builtin.file:
      path: /var/tmp/ranga
      state: directory
      mode: '0755'
     when: checkdir.rc == 2
```

```
vim service.yaml 
```

```
---
- name: To check the service status 
  hosts: all
  ignore_errors: true
  tasks:
   - name: check the service status
     command: service vsftpd status 
     register: checkvsftpdservice
   - name: print the json output
     debug: 
      var: checkvsftpdservice
   - name: service is running 
     debug:
      msg: "vsftpd service is running"
     when: checkvsftpdservice.rc == 0
   - name: service is not running 
     debug:
      msg: "vsftpd service not running"
     when: checkvsftpdservice.rc == 3
   - name: Start service vsftpd, if not started
     ansible.builtin.service:
       name: vsftpd
       state: started
     when: checkvsftpdservice.rc == 3
```

Step 18. singleurl and multipleurl check using the roles

# Ansible Roles

## 1: What is role
-  **Role:** Ansible role is a set of tasks to configure a host to serve a certain purpose like configuring a service. Roles are defined using YAML files with a predefined directory structure. A role directory structure contains directories: defaults, vars, tasks, files, templates, meta, handlers.

## 2: use of Ansible roles?
 - **What is the use of Ansible roles??:** Roles let you automatically load related vars, files, tasks, handlers, and other Ansible artifacts based on a known file structure. After you group your content in roles, you can easily reuse them and share them with other users.
 
 - **What is the default behavior when an ansible task fails?:** When Ansible receives a non-zero return code from a command or a failure from a module, by default it stops executing on that host and continues on other hosts. However, in some circumstances you may want different behavior. Sometimes a non-zero return code indicates success.
 
## 3: What is the difference between roles and playbook in Ansible?
- ** Role is a set of tasks and additional files to configure host to serve for a certain role. Playbook is a mapping between hosts and roles **.

## 4: How do you write an Ansible role?
- ** To create a Ansible roles, use ansible-galaxy command which has the templates to create it. This will create it under the default directory /etc/ansible/roles and do the modifications else we need to create each directories and files manually. where, ansible-glaxy is the command to create the roles using the templates **.

## 5: What is role and task in Ansible?

- Roles provide a framework for fully independent, or interdependent collections of variables, tasks, files, templates, and modules. In Ansible, the role is the primary mechanism for breaking a playbook into multiple files. This simplifies writing complex playbooks, and it makes them easier to reuse.

## 6: What is the file structure of Ansible roles?
- Roles are defined using YAML files with a predefined directory structure. A role directory structure contains directories: defaults, vars, tasks, files, templates, meta, handlers. Each directory must contain a main. yml file which contains relevant content.

## 7:  How do I install Ansible roles?
**Installing roles **
- Set the environment variable ANSIBLE_ROLES_PATH in your session.
- Use the --roles-path option for the ansible-galaxy command.
- Define roles_path in an ansible. cfg file.

## 7:  Folder Structure ?
**Ansible roles Directory Structure**

![ScreenShot](https://github.com/careerbytecode/cloud-devops-engineer-training/blob/main/3-ansible/Ansible-Roles-Structure.png)

To start this handson lab,you need following resources.



## 4: Prerequisites

Install the tree package in ansible server

```
apt install tree
```
this above ping command should return with ping / pong green color.

## scenario 1: How to monitor many urls ?

- create roles dirdctory
```
vim urlmonitor.yml
```

- create sample role and learn how directory structure are ?.
```
---
- name: check the url's reachable and working
  hosts: all
  tasks:
   - name: check url1
     uri:
      url: http://www.google.com/
     register: googleurl
   - name: print json output
     debug:
      var: googleurl
   - name: print google url1 is working
     debug:
      msg: google url1 is reahable and working
     when: googleurl.status == 200
   - name: check url2
     uri:
      url: http://www.microsoft.com/
     register: microsofturl
   - name: print json output
     debug:
      var: microsofturl
   - name: print microsoft url2 is working
     debug:
      msg: microsoft url2 is reahable and working
     when: microsofturl.status == 200
```

- execute the playbook

```
ansible-playbook urlmonitor.yml
```


## scenario 2: How to create ansible role folder structure

- create roles dirdctory
```
mkdir roles
cd roles
```

- create sample role and learn how directory structure are ?.
```
ansible-galaxy init singleurl
```

- Type below command to see how the folder structure looks like ?.
- make sure you are in roles directory.

```
tree
```

- Declare your roles path in your environnment related ansible.cfg file.


```
vim ansible.cfg
[defaults]
inventory=hosts
remote_user=ansible
timeout=3000
roles_path=/home/ansible/dev/roles

[privilege_escalation]
become=True
become_method=sudo
become_user=root
become_ask_pass=False
```

## scenario 3: single url test

![ScreenShot](https://github.com/careerbytecode/cloud-devops-engineer-training/blob/main/3-ansible/multi-url.JPG)

- single url is just dummy skeleton

- goto singleurl folder.
- we are going to test http://www.google.com/ url is rechable and working or not ?.

- go to defaults folder and set the variable

```
mkdir singleurl
cd singleurl
mkdir defaults
cd defaults
```
```
vim /home/ansible/dev/roles/singleurl/defaults/main.yml 
---
url: http://www.google.com/

```
Now go to tasks folder and enter what you want to test and print.


```
cd singleurl
mkdir tasks
cd tasks
```

```
vi /home/ansible/dev/roles/singleurl/tasks/main.yml
```

```
---
- name: check url is reachable or not
  uri:
   url: "{{ url }}"
- name: print the {{ url }} is working
  debug:
   msg: "{{ url }} is working and reachble"

```

- come out of roles folder.

- create new yaml playbook

```
vim /home/ansible/dev/singleurltesting.yml
---
- name: test the url reachablity
  hosts: all
  roles:
   - singleurl
```

## scenario 4: Now perform the same above test and need to test 100's of urls

![ScreenShot](https://github.com/cloudnloud/Ansible_Automation/blob/main/Class21/multi-url.JPG)

- multiurl is just actual where you need to mention all the urls you want to monitor.

- goto multiurl folder.
- we are going to test many url's are rechable and working or not ?.

- go to meta folder and list all the urls which you want to monitor

```
cd roles
mkdir multiurl
cd multiurl
mkdir meta
cd meta
```
```
vim /home/ansible/dev/roles/multiurl/meta/main.yml 

dependencies: 
 - { role: singleurl, url: "http://cloudnloud.com/"}
 - { role: singleurl, url: "http://youtube.com/"}
 - { role: singleurl, url: "http://www.tcs.com/"}
 - { role: singleurl, url: "http://www.infosys.com/"}
 - { role: singleurl, url: "http://www.wipro.com/"}
 - { role: singleurl, url: "http://www.irctc.com/"}
 - { role: singleurl, url: "http://www.redbus.com/"}
 - { role: singleurl, url: "http://www.emirates.com/"}
 - { role: singleurl, url: "http://www.skyscanner.com/"}
 - { role: singleurl, url: "http://www.redhat.com/"}
 - { role: singleurl, url: "http://www.airfrance.com/"}

```
- Now go to tasks folder and enter what you want to test and print.

```
cd multiurl
mkdir tasks
cd tasks
```

```
vim /home/ansible/dev/roles/multiurl/tasks/main.yml 
---
- name: print all url monitoring tasks has been completed.
  debug:
   msg: "we now have good confidence on what is role and what is dummy role and what is meta depedencies"
```

- come out of roles folder.

- create new yaml playbook

```
vim /home/ansible/dev/multiurltesting.yml
---
- name: test the url reachablity
  hosts: all
  roles:
   - multiurl
```

```
ansible-playbook /home/ansible/dev/multiurltesting.yml
```


## Create a singleuser role
- go to roles directory

```
ansible-galaxy init singleuser
```
```
cd /home/ansible/dev/roles/singleuser/tasks
```
```
vi  main.yml
```
```
---
# tasks file for singleuser
- name: creating "{{ user }}"
  ansible.builtin.user:
    name: "{{ user }}"
    comment: "{{ user }}"
    shell: /bin/bash
    groups: staff,users

```
```
cd /home/ansible/dev/roles/singleuser/defaults
```
```
vi main.yml
```
```
---
# defaults file for singleuser
user: ranga
```
```
cd /home/ansible/dev
```
```
vi singleuser.yml
```
```
---
- name: create one user using single user role 
  hosts: all
  roles:
   - singleuser
```

## Create a Mutliuser role
- go to roles directory

```
ansible-galaxy init multipleuser
```
```
cd /home/ansible/dev/roles/multipluser/meta
```
```
vi main.yml
```
```
dependencies: 
 - { role: singleuser, user: "arun"}
 - { role: singleuser, user: "suresh"}
 - { role: singleuser, user: "ramesh"}
 - { role: singleuser, user: "krishna"}
 - { role: singleuser, user: "kabir"}
 - { role: singleuser, user: "jesus"}
 - { role: singleuser, user: "rahul"}
 - { role: singleuser, user: "ram"}
 - { role: singleuser, user: "bad"}
 - { role: singleuser, user: "notepad"}
 - { role: singleuser, user: "good"}
```

```
cd /home/ansible/dev/roles/multipleuser/tasks

```
```
vi main.yml
```

```
---
# tasks file for multipleuser
- name: user has been created 
  debug:
   msg: user has been created and added to users and staff groups
```

```
cd /home/ansible/dev
```

```
vi multipleuser.yml
```

```
---
- name: To create the multiple users
  hosts: all
  roles:
   - multipleuser
```



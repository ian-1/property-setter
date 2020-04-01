# Property Setter #

A property Management tool for the UK residential lettings market.

## User Stories ##

As a Property Manager\
So I can keep track of my portfolio\
I want to know how many Properties I have

As a Property Manager\
So I can change my portfolio size\
I want to be able to add a new Property and have my property number increase

As a Property Manager\
So I can change my portfolio size\
I want to be able to remove a Property and have my property number decrease

As a Property Manager\
So I know where a property is\
I want to set the address when I add a new property

As a Property Manager\
So I can choose which property to remove from my portfolio\
I want to be able to specify which property to remove using a unique code

As a Property Manager\
So I can see what repair jobs there are for a Property\
I want to be able to link a Property to its Repair jobs 

---

As a Property Manager\
So I can keep track of my repairs\
I want to know how many Open Repair Jobs I have

As a Property Manager\
So I can deal with new repair issues\
I want to be able to add a new Repair Job and have my Active Repair Jobs increase

As a Property Manager\
So I can remove an unwanted repair\
I want to be able to remove a Repair Job and have my Active Repair Jobs decrease

As a Property Manager\
So I can concentract on just active jobs\
I want to be able to mark a Repair Job as Closed and have my Active Repair Jobs decrease

As a Property Manager\
So I know what the repair job is for\
I want to set the Job Title when I add a new Repait Job

As a Property Manager\
So I can choose which Repair Job to remove\
I want to be able to specify which Repair Job to remove using a unique code

As a Property Manager\
So I can choose which Repair Job to close\
I want to be able to specify which Repair Job to close using a unique code

As a Property Manager\
So I can see which Property a repair job is for\
I want to be able to link a Repair job to a Property

---

As a Property Manager\
So I can keep information I have enterred\
I want to be able to save data inputted into Property-Setter

As a Property Manager\
So I can reuse information I have eterred\
I want to be able to load previously saved data into Property-Setter

## Domain Model ##

|Property Manager|
|-|
| |

|Portfolio| <--- |Property|
|-| |-|
|how_many_properties| |add_repair(repair)|
|property_from_code(code)|
|add_property(address)|
|remove_property(code)|
|save_properties|
|load_properties|

|Maintenance| <--- |Repair|
|-| |-|
|how_many_repairs| |close_repair|
|how_many_active_repairs| |add_property(code)|
|add_repair(title)|
|remove_repair(code)|
|close_repair(code)|
|save_repairs|
|load_repairs|


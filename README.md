# Property Setter #

A property Management tool for the UK residential lettings market.

## User Stories ##

As a Property Manager
So I can keep track of my portfolio
I want to know how many Properties I have

As a Property Manager
So I can change my portfolio size
I want to be able to add a new Property and have my property number increase

As a Property Manager
So I can change my portfolio size
I want to be able to remove a Property and have my property number decrease

As a Property Manager
So I know where a property is
I want to set the address when I add a new property

As a Property Manager
So I can choose which property to remove from my portfolio
I want to be able to specify which property to remove using a unique code

-----------------

As a Property Manager
So I can keep track of my repairs
I want to know how many Open Repair Jobs I have

As a Property Manager
So I can deal with new repair issues
I want to be able to add a new Repair Job and have my Active Repair Jobs increase

As a Property Manager
So I can remove an unwanted repair
I want to be able to remove a Repair Job and have my Active Repair Jobs decrease

As a Property Manager
So I can concentract on just active jobs
I want to be able to mark a Repair Job as Closed and have my Active Repair Jobs decrease

As a Property Manager
So I know what the repair job is for
I want to set the Job Title when I add a new Repait Job

As a Property Manager
So I can choose which Repair Job to remove
I want to be able to specify which Repair Job to remove using a unique code

As a Property Manager
So I can choose which Repair Job to close
I want to be able to specify which Repair Job to close using a unique code

## Domain Model ##

|Property Manager|
|-|
| |

|Portfolio| <--- |Property|
|-| |-|
|how_many_properties| | |
|add_property(address)|
|remove_property(code)|

|Maintenance|
|-|
|how_many_repairs|
|how_many_active_repairs|
|add_repair(title)|
|remove_repair(code)|
|close_repair(code)|

|Repair|
|-|
|close_repair|

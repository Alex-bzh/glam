# Glam

The *Glam bibliography* is a multilingual shared bibliography project dedicated to the field of gender and language studies that brings together resources in order to:
- provide an overview of the gender and language landscape and the different research traditions, in different parts of the world, different disciplines, and different languages;
- provide students and researchers with a powerful bibliographic research tool;
- create an evolving and collaborative bibliography.

## How to run this application on local?

There are two prerequisites you need to run this application:
- a *MariaDB* database;
- a *Node.js* server.

First, create a database untitled *glam* in MariaDB, then:

```
$ cd glam
$ mysql -u [user] -p glam < ./private/glam.sql
```

Be sure to have *Node.js* 14.x on your computer before installing the dependencies and starting the application:

```
$ cd glam
$ npm install
$ npm start
```

Then, open your web browser and navigate to the URL:  
http://localhost:3002.

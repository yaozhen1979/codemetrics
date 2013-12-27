#Grails Note#

---

**簡易Grails app installation note**

##Creating Your First Application##

1. Run the command grails create-app gTunes to create the application (with “gTunes” being the application’s name).

        $ grails create-app [app name]
    

2. Navigate into the gTunes directory by issuing the command cd gtunes.
3. Create a storefront controller with the command grails create-controller
store.

        $ grails create-controller store

4. Write some code to display a welcome message to the user.

        package gtunes
        class StoreController {
          def index() {
            render 'Welcome to the gTunes store!'
          }
        }

5. Test your code and run the tests with grails test-app.

        grails test-app

6. Run the application with grails run-app.

        $ grails run-app

    or

        $ grails -Dserver.port=8087 run-app

---

##Grails Interactive Mode##

    $ grails
    grails>

**example**

    $ grails
	grails> create-domain-class com.gtunes.Store
	| Created file grails-app/domain/com/gtunes/Store.groovy
	| Created file test/unit/com/gtunes/StoreTests.groovy
	grails>

---


##Creating a Domain##

**example**

    package com.gtunes
    class Song {
	  String title
	  String artist
	  static constraints = {
	    title blank: false
	    artist blank: false
	  }
	}

##Introducing Dynamic Scaffolding##

> Scaffolding comes in two flavors: dynamic (or runtime) and static     (or template-driven). First, we’ll look at dynamic scaffolding, where a CRUD application’s controller logic and views are generated at runtime. Dynamic scaffolding does not involve boilerplate code or templates; it uses advanced techniques such as reflection and Groovy’s metaprogramming capabilities to achieve its goals. However, <u>**before you can dynamically scaffold your Song class, you need a controller.**</u>

    grails> create-scaffold-controller com.gtunes.Song
	| Created file grails-app/controllers/com/gtunes/SongController.groovy
	| Created file grails-app/views/song
	| Created file test/unit/com/gtunes/SongControllerTests.groovy
	grails>

> To enable dynamic scaffolding, the SongController defines a scaffold property with a value of true, as
shown in Listing 2-5.

**Listing 2-5**

    package com.gtunes
    class SongController {
      static scaffold = true
    }

**TODO：static scaffold = true ???**

Creating the Album Domain Class

    grails> create-domain-class com.gtunes.Album
    | Created file grails-app/domain/com/gtunes/Album.groovy
    | Created file test/unit/com/gtunes/AlbumTests.groovy
    grails>

Defining a One-to-Many Relationship

    package com.gtunes
	class Album {
	  String title
	  static hasMany = [songs:Song]
	}

>The preceding association is **unidirectional**. In other words, only the Album class knows about the
association, while the Store class remains blissfully unaware of it. To make the association **bidirectional**,
modify the Store class to include an Album local property, as shown in Listing 2-8. Now Album and Song have
a bidirectional, one-to-many association.

Making the Relationship Bidirectional

	package com.gtunes
	class Song {
	  String title
	  String artist
	  Album album
	}

>For now, let’s create another scaffolded controller that can deal with the creation of Album
instances. Use the ``grails create-controller com.myApp.Album`` command and add the static scaffold = true property to
the class definition.

Scaffolding the Album Class

	package com.gtunes
	class AlbumController {
	  static scaffold = true
	}

##Static Scaffolding##

Grails provides the ability to take a domain class and generate a
controller and associated views from the command line through the following targets:

+  ``grails generate-controller``: Generates a controller for the        specified domain class.

    generate-controller takes a domain-class name as its first argument.

        grails> generate-controller com.gtunes.Album
        | Generating controller for domain class com.gtunes.Album
        > File /grails-app/controllers/com/gtunes/AlbumController.groovy already exists.
		Overwrite?[y,n,a] y
		> File /test/unit/com/gtunes/AlbumControllerTests.groovy already exists. Overwrite?[y,n,a] y
		| Finished generation for domain class com.gtunes.Album
		grails>

+  ``grails generate-views``: Generates views for the specified domain class.

    Generating the Views

        grails> generate-views com.gtunes.Album
        | Finished generation for domain class com.gtunes.Album
        grails>

    All in all, you can generate four views:
    - ``list.gsp``: Used by the list action to display a list of Album instances.
    - ``show.gsp``: Used by the show action to display an individual Album instance.
    - ``edit.gs``p: Used by the edit action to edit a Album instance’s properties.
    - ``create.gsp``: Used by the create action to create a new Album instance.
    - ``_form.gsp``: Used by the create and edit views.

+  ``grails generate-all``: Generates both a controller and associated views.

> **Note All the views use the main layout found at grails-app/views/layouts/main.gsp. This includes the
placement of title, logo, and any included style sheets. Layouts are discussed in detail in Chapter 5.**





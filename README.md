# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!-- Local Dev -->

http://polymorphic-organization.localhost:3000/

```mermaid
---
title: Polymorphic organization
---
classDiagram
  namespace Subscribers {
    class Feed {
      string name
    }

    class User {
      string name
      string email_address
      string password_digest
    }
  }

  namespace Subscribables {
    class Podcast {
      string name
    }

    class Newspaper {
      string name
    }
  }

  class Subscription {
    bigint subscriber_id
    bigint subscriber_type
    bigint subscribable_id
    string subscribable_type
  }

  class FeedUser {
    bigint user_id
    bigint feed_id
    boolean active
    string role
  }

  User --> FeedUser : has_many
  Feed --> FeedUser : has_many

  User --> Subscription : has_many
  Feed --> Subscription : has_many
  Podcast --> Subscription : has_many
  Newspaper --> Subscription : has_many
```

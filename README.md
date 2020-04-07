# JSON REST API for a hypothetical mobile app
## Resources

The API provides the following REST resources:

### Posts

Blog posts. The main (root) collection of the app.

Route: `/posts(/:id)`

Supported controller actions: `all`

Significant member resource fields:

* `id` - record id
* `body` - post body
* `likes_count` - numer of likes the post has, cached and recalculated when likes get created/destroyed
* `is_liked` - wether or not the post has been liked by a current user
* `created_at` - creation (publication) date
* `commented_at` - date/time of a latest comment added to the post

### Like

Like by a current user to a post. Singleton resource. Doesn't exist (i.e. returns `404` error) if the post hasn't been liked by the current user.

Route: `/posts/:post_id/like`

Supported controller actions: `show|create|destroy`

Significant member resource fields: `(none)`

### Comments

Comments to a post.

Route: `/posts/:post_id/comments(/:id)`

Supported controller actions: `all`

Significant member resource fields:

* `id` - record id
* `body` - comment body

## Setup

A side note on warnings. At the moment, the latest version of Rails (`6.0.2.2`) gives a lot of warnings when used with the latest version of Ruby (`2.7.1`).

To prevent showing warnings on each run of each command (setup, tests, server, etc) the commands should be prepended with `RUBYOPT='-W:no-deprecated'` (which is how they are shown below).

The following list of commands executed from the app dir gives a working local version of the app.

1. Install dependencies: `RUBYOPT='-W:no-deprecated' bundle install`
2. Setup dev/test databases: `RUBYOPT='-W:no-deprecated' bundle exec rails db:setup`
3. Populate dev database with randomly generated data: `RUBYOPT='-W:no-deprecated' bundle exec rails test_data:generate`

## CI

The app uses `RSpec` as test framework and `Rubocop` for static code analysis.

You can run them via the following commands:

1. Run tests: `RUBYOPT='-W:no-deprecated' bundle exec rspec`
2. Run static code analysis: `RUBYOPT='-W:no-deprecated' bundle exec rubocop`

## Using the app

The app runs as a regular rails API-only server that accepts/responds with JSONs.

To start server, execute `RUBYOPT='-W:no-deprecated' bundle exec rails s`

Below is a sample list of shell commands you can use to test the app behavior:

1. List posts (first 25 records): `curl http://localhost:3000/posts`
2. List posts starting from a specific id (25 records): `curl http://localhost:3000/posts?after=25`
3. List posts ordered by publication date/time starting from a specific date/time (25 records): `curl "http://localhost:3000/posts?order=created_at&after=2020-04-07T09:36:18.355Z"`
4. Like post (returns `302` status if already liked): `curl -X POST http://localhost:3000/posts/1/like -H "Content-Type: application/json"`
5. Unlike post (returns `404` status if not liked): `curl -X DELETE http://localhost:3000/posts/1/like -H "Content-Type: application/json"`
6. Publish post: `curl -X POST http://localhost:3000/posts -d '{"body": "test post"}' -H "Content-Type: application/json"`
7. Comment post: `curl -X POST http://localhost:3000/posts/1/comments -d '{"body": "test comment"}' -H "Content-Type: application/json"`

DROP TABLE question_likes;
DROP TABLE replies;
DROP TABLE question_follows;
DROP TABLE questions;
DROP TABLE users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  parent_reply_id INTEGER REFERENCES replies(id),
  replier_id INTEGER NOT NULL REFERENCES users(id),
  body TEXT NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  liker_id INTEGER NOT NULL REFERENCES users(id),
  liked_id INTEGER NOT NULL REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Austin', 'Gatlin'), ('David', 'Carter');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How many?', 'Is there?', 1), ('Why?', 'Is the sky blue?', 2),
  ('When was?', 'It?', 1);

INSERT INTO
  question_follows (follower_id, question_id) --try leaving col vars out.
VALUES
  (1, 1), (2, 1);

INSERT INTO
  replies (question_id, parent_reply_id, replier_id, body)
VALUES
  (2, NULL, 1, 'Nitrogen molecules absorb then readmit blue light.'),
  (2, 1, 2, 'Thanks, I did not know that!');

INSERT INTO
  question_likes (liker_id, liked_id)
VALUES
  (1, 2), (2, 1);

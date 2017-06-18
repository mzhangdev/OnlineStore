# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create(name: "C Programming Language, 2nd Edition",
              description: "The authors present the complete guide to ANSI standard C language programming. Written by the developers of C, this new version helps readers keep up with the finalized ANSI standard for C while showing how to take advantage of C's rich set of operators, economy of expression, improved control flow, and data structures. The 2/E has been completely rewritten with additional examples and problem sets to clarify the implementation of difficult language constructs.",
              price: 38.91,
              image: "c_programming_language.png")
Product.create(name: "Head First Design Patterns: A Brain-Friendly Guide",
              description: "At any given moment, someone struggles with the same software design problems you have. And, chances are, someone else has already solved your problem. This edition of Head First Design Patterns—now updated for Java 8—shows you the tried-and-true, road-tested patterns used by developers to create functional, elegant, reusable, and flexible software. By the time you finish this book, you’ll be able to take advantage of the best design practices and experiences of those who have fought the beast of software design and triumphed.",
              price: 35.89,
              image: "head_first_design_patterns.jpg")
Product.create(name: "SQL Cookbook: Query Solutions and Techniques for Database Developers",
              description: "SQL is a deceptively simple language to learn, and many database developers never go far beyond the simple statement: SELECT columns FROM table WHERE conditions. But there is so much more you can do with the language. In the SQL Cookbook, experienced SQL developer Anthony Molinaro shares his favorite SQL techniques and features.",
              price: 29.16,
              image: "sql_cookbook.jpg")
Product.create(name: "Programming Ruby 1.9 & 2.0",
              description: "This book is the only complete reference for both Ruby 1.9 and Ruby 2.0, the very latest version of Ruby.",
              price: 37.78,
              image: "programming_ruby.jpg")

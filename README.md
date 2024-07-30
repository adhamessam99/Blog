# Blog Application

This Blog Application is a RESTful API built with Ruby on Rails, designed to provide users with a platform to create and manage blog posts and comments. The application uses JWT for secure user authentication, PostgreSQL for database management, and Sidekiq for background processing tasks, all containerized with Docker.

## Features

- **User Authentication**
  - Secure sign-up and log-in functionality using JWT tokens.
  - Authentication required to access all API endpoints.
  
- **Post Management**
  - Users can create, read, update, and delete their own posts.
  - Each post includes a title, body, author, and associated tags.
  - Posts are automatically deleted 24 hours after creation using Sidekiq.

- **Comments and Tags**
  - Users can comment on any post and manage their own comments.
  - Posts must have at least one tag, and users can update these tags.

- **User Permissions**
  - Users can only modify their own posts and comments.

## Tech Stack

- **Framework**: Ruby on Rails
- **Database**: PostgreSQL
- **Background Processing**: Sidekiq with Redis
- **Authentication**: JSON Web Tokens (JWT)
- **Containerization**: Docker, Docker Compose


## Installation and Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/blog-application.git
   cd blog-application
   
2. **Build and Start the Application**

  Use Docker Compose to build and start all services: **docker-compose up --build**
  
  **This will start the Rails application, PostgreSQL database, Redis for Sidekiq, and the Sidekiq worker**
  


## Usage

Once the application is running, you can access the API at `http://localhost:3000`. Below are the main endpoints available for interaction:

### User Authentication

- **Sign Up**  
  - **Method**: `POST`
  - **Endpoint**: `/signup`
  - **Description**: Register a new user to access the application.
  - **Request Body**:  
    ```json
    {
      "name": "Your Name",
      "email": "user@example.com",
      "password": "password",
      "password_confirmation": "password",
      "image": "URL_or_base64_encoded_image"
    }
    ```

- **Log In**  
  - **Method**: `POST`
  - **Endpoint**: `/login`
  - **Description**: Authenticate an existing user and receive a JWT token for further requests.
  - **Request Body**:  
    ```json
    {
      "email": "user@example.com",
      "password": "password"
    }
    ```

### Post Endpoints

> **Note**: A valid JWT token is required in the `Authorization` header for all requests to the following endpoints.

- **Create Post**  
  - **Method**: `POST`
  - **Endpoint**: `/posts`
  - **Description**: Create a new blog post with a title, body, and tags.
  - **Request Body**:  
    ```json
    {
      "title": "Post Title",
      "body": "Post content goes here.",
      "tags": ["tag1", "tag2"]
    }
    ```
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

- **Get All Posts**  
  - **Method**: `GET`
  - **Endpoint**: `/posts`
  - **Description**: Retrieve a list of all blog posts.
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

- **Update Post**  
  - **Method**: `PUT`
  - **Endpoint**: `/posts/:id`
  - **Description**: Update an existing post. The `:id` parameter should be replaced with the specific post ID.
  - **Request Body**:  
    ```json
    {
      "title": "Updated Post Title",
      "body": "Updated content goes here.",
      "tags": ["tag1", "tag2"]
    }
    ```
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

- **Delete Post**  
  - **Method**: `DELETE`
  - **Endpoint**: `/posts/:id`
  - **Description**: Delete a specific post. The `:id` parameter should be replaced with the specific post ID.
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

### Comment and Tag Endpoints

> **Note**: A valid JWT token is required in the `Authorization` header for all requests to the following endpoints.

- **Add Comment**  
  - **Method**: `POST`
  - **Endpoint**: `/posts/:post_id/comments`
  - **Description**: Add a comment to a specific post. The `:post_id` parameter should be replaced with the specific post ID.
  - **Request Body**:  
    ```json
    {
      "content": "This is a comment."
    }
    ```
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

- **Update Comment**  
  - **Method**: `PUT`
  - **Endpoint**: `/posts/:post_id/comments/:id`
  - **Description**: Update an existing comment. The `:post_id` and `:id` parameters should be replaced with the specific post ID and comment ID, respectively.
  - **Request Body**:  
    ```json
    {
      "content": "Updated comment content."
    }
    ```
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

- **Delete Comment**  
  - **Method**: `DELETE`
  - **Endpoint**: `/posts/:post_id/comments/:id`
  - **Description**: Delete a specific comment. The `:post_id` and `:id` parameters should be replaced with the specific post ID and comment ID, respectively.
  - **Headers**:  
    ```plaintext
    Authorization: Bearer <your_jwt_token>
    ```

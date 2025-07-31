# TinyURL Service

A URL shortening service built with Spring Boot that provides short aliases for long URLs, similar to bit.ly or tinyurl.com. The service includes user management, click tracking, and analytics.

## Features

- **URL Shortening**: Convert long URLs into short, manageable links
- **User Management**: Create and manage users who can own shortened URLs
- **Click Tracking**: Track clicks on shortened URLs with detailed analytics
- **Real-time Analytics**: Monitor URL usage with monthly click statistics
- **Multi-Database Architecture**: Utilizes Redis, MongoDB, and Cassandra for optimal performance

## Architecture

The application uses a multi-database architecture for different data types:

- **Redis**: Fast caching and storage of URL mappings
- **MongoDB**: User data and URL metadata storage
- **Cassandra**: Time-series data for click tracking and analytics

## Technology Stack

- **Backend**: Spring Boot 2.5.2
- **Databases**: 
  - Redis (URL caching)
  - MongoDB (User data)
  - Cassandra (Click analytics)
- **Documentation**: Swagger/OpenAPI
- **Build Tool**: Maven
- **Java Version**: 11
- **Containerization**: Docker & Docker Compose

## API Endpoints

### Basic Operations
- `GET /hello` - Health check endpoint
- `GET /getkey?key={key}` - Retrieve value from Redis cache
- `GET /setkey?key={key}&value={value}` - Set key-value pair in Redis

### User Management
- `POST /user?name={name}` - Create a new user
- `GET /user/{name}?name={name}` - Get user information

### URL Operations
- `POST /tiny` - Create a shortened URL
  ```json
  {
    "longUrl": "https://example.com/very/long/url",
    "userName": "john_doe"
  }
  ```
- `GET /{tinyCode}/` - Redirect to original URL (also tracks the click)

### Analytics
- `GET /user/{name}/clicks?name={name}` - Get click history for a user

## Quick Start

### Prerequisites
- Docker and Docker Compose
- Java 11 or higher
- Maven

### Running with Docker Compose

1. Clone the repository
2. Build the application:
   ```bash
   mvn clean package
   ```

3. Start all services:
   ```bash
   docker-compose up
   ```

This will start:
- Redis on port 6379
- MongoDB on port 27017  
- Cassandra on port 9042
- TinyURL service on port 8080

### Manual Setup

If you prefer to run databases separately:

1. **Start Redis**:
   ```bash
   docker run -d -p 6379:6379 redis
   ```

2. **Start MongoDB**:
   ```bash
   docker run -d -p 27017:27017 mongo:4.0
   ```

3. **Start Cassandra**:
   ```bash
   docker run -d -p 9042:9042 -e MAX_HEAP_SIZE=256M -e HEAP_NEWSIZE=128M cassandra:3.11.9
   ```

4. **Run the application**:
   ```bash
   mvn spring-boot:run
   ```

## Usage Examples

### 1. Create a User
```bash
curl -X POST "http://localhost:8080/user?name=john_doe"
```

### 2. Shorten a URL
```bash
curl -X POST "http://localhost:8080/tiny" \
  -H "Content-Type: application/json" \
  -d '{
    "longUrl": "https://www.example.com/very/long/url/path",
    "userName": "john_doe"
  }'
```

Response: `http://localhost:8080/abc123/`

### 3. Use the Shortened URL
Visit `http://localhost:8080/abc123/` in your browser - you'll be redirected to the original URL.

### 4. Get Click Analytics
```bash
curl "http://localhost:8080/user/john_doe/clicks?name=john_doe"
```

## Configuration

The application can be configured via `application.properties`:

```properties
# Redis Configuration
spring.redis.host=redis
spring.redis.port=6379

# MongoDB Configuration  
spring.data.mongodb.uri=mongodb://mongo:27017/tinydb

# Cassandra Configuration
spring.data.cassandra.keyspace-name=tiny_keyspace
spring.data.cassandra.contact-points=cassandra
spring.data.cassandra.port=9042

# Base URL for shortened links
base.url=http://localhost:8080/
```

## Database Schema

### MongoDB (Users Collection)
```javascript
{
  "_id": "ObjectId",
  "name": "username",
  "allUrlClicks": 0,
  "shorts": {
    "tinyCode": {
      "clicks": {
        "2024/01": 15,
        "2024/02": 23
      }
    }
  }
}
```

### Cassandra (UserClick Table)
```sql
CREATE TABLE userclick (
  user_name text,
  click_time timestamp,
  tiny text,
  long_url text,
  PRIMARY KEY (user_name, click_time)
) WITH CLUSTERING ORDER BY (click_time DESC);
```

## API Documentation

Once the application is running, you can access the Swagger UI at:
`http://localhost:8080/swagger-ui.html`

## Development

### Project Structure
```
src/
├── main/
│   ├── java/com/handson/tinyurl/
│   │   ├── config/          # Configuration classes
│   │   ├── controller/      # REST controllers
│   │   ├── model/          # Data models
│   │   ├── repository/     # Data access layer
│   │   ├── service/        # Business logic
│   │   └── util/           # Utility classes
│   └── resources/
│       └── application.properties
└── test/
```

### Building
```bash
mvn clean package
```

### Running Tests
```bash
mvn test
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).

## Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 6379, 27017, 9042, and 8080 are available
2. **Database connections**: Wait for all databases to fully start before running the application
3. **Memory issues with Cassandra**: The docker-compose includes memory limits for Cassandra

### Logs
Check application logs for detailed error information:
```bash
docker-compose logs tinyurl
```

## Performance Considerations

- Redis provides fast lookups for URL redirections
- Cassandra handles high-volume click tracking efficiently
- MongoDB indexes are automatically created for user lookups
- Short codes are 6 characters long, providing 62^6 ≈ 56 billion possible combinations

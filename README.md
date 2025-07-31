# TinyURL - URL Shortener Service

A simple and efficient URL shortening service that converts long URLs into short, easy-to-share links.

## 🚀 Features

- **URL Shortening**: Convert long URLs into short, manageable links
- **Custom Aliases**: Create personalized short URLs with custom aliases
- **Analytics**: Track click statistics and usage metrics
- **QR Code Generation**: Generate QR codes for shortened URLs
- **Bulk Operations**: Shorten multiple URLs at once
- **API Access**: RESTful API for programmatic access
- **Responsive Design**: Mobile-friendly web interface
- **Link Management**: View, edit, and delete your shortened links

## 🛠️ Tech Stack

- **Backend**: Node.js, Express.js
- **Database**: MongoDB / Redis
- **Frontend**: HTML, CSS, JavaScript
- **Authentication**: JWT
- **Deployment**: Docker, AWS/Heroku

## 📋 Prerequisites

Before running this application, make sure you have the following installed:

- Node.js (v14 or higher)
- npm or yarn
- MongoDB (if using MongoDB)
- Redis (if using Redis)

## 🔧 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Evyatar831/tinyurl.git
   cd tinyurl
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   Create a `.env` file in the root directory:
   ```env
   PORT=3000
   MONGODB_URI=mongodb://localhost:27017/tinyurl
   JWT_SECRET=your_jwt_secret_here
   BASE_URL=http://localhost:3000
   REDIS_URL=redis://localhost:6379
   ```

4. **Start the application**
   ```bash
   # Development mode
   npm run dev
   
   # Production mode
   npm start
   ```

## 🐳 Docker Setup

1. **Build and run with Docker Compose**
   ```bash
   docker-compose up --build
   ```

2. **Or build manually**
   ```bash
   docker build -t tinyurl .
   docker run -p 3000:3000 tinyurl
   ```

## 📖 API Documentation

### Base URL
```
http://localhost:3000/api
```

### Endpoints

#### Create Short URL
```http
POST /api/shorten
Content-Type: application/json

{
  "url": "https://www.example.com/very/long/url",
  "customAlias": "my-link" // optional
}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "originalUrl": "https://www.example.com/very/long/url",
    "shortUrl": "http://localhost:3000/abc123",
    "shortCode": "abc123",
    "qrCode": "data:image/png;base64,..."
  }
}
```

#### Get URL Info
```http
GET /api/info/{shortCode}
```

**Response:**
```json
{
  "success": true,
  "data": {
    "originalUrl": "https://www.example.com/very/long/url",
    "shortCode": "abc123",
    "clicks": 42,
    "createdAt": "2024-01-01T00:00:00.000Z"
  }
}
```

#### Redirect to Original URL
```http
GET /{shortCode}
```

#### Get Analytics
```http
GET /api/analytics/{shortCode}
```

## 🎯 Usage Examples

### Web Interface
1. Visit `http://localhost:3000`
2. Enter your long URL in the input field
3. Optionally add a custom alias
4. Click "Shorten URL"
5. Copy and share your short URL

### Using cURL
```bash
# Shorten a URL
curl -X POST http://localhost:3000/api/shorten \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.example.com"}'

# Get URL information
curl http://localhost:3000/api/info/abc123

# Redirect (in browser)
curl -L http://localhost:3000/abc123
```

### Using JavaScript
```javascript
// Shorten URL
const response = await fetch('/api/shorten', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    url: 'https://www.example.com/very/long/url',
    customAlias: 'my-link'
  })
});

const data = await response.json();
console.log(data.data.shortUrl);
```

## 📊 Features Overview

### URL Shortening Algorithm
- Uses base62 encoding for short codes
- Collision detection and resolution
- Custom alias validation
- URL validation and sanitization

### Analytics & Tracking
- Click counting
- Geographic location tracking
- Referrer tracking
- Device and browser detection
- Daily/weekly/monthly statistics

### Security Features
- Rate limiting
- Input validation
- XSS protection
- CSRF protection
- URL blacklist checking

## 🧪 Testing

Run the test suite:
```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

## 📁 Project Structure

```
tinyurl/
├── src/
│   ├── controllers/     # Route controllers
│   ├── models/         # Database models
│   ├── middleware/     # Custom middleware
│   ├── routes/         # API routes
│   ├── services/       # Business logic
│   ├── utils/          # Utility functions
│   └── validators/     # Input validation
├── public/             # Static files
├── views/              # HTML templates
├── tests/              # Test files
├── docker-compose.yml  # Docker configuration
├── Dockerfile         # Docker build file
├── package.json       # Dependencies and scripts
└── README.md          # This file
```

## 🚀 Deployment

### Heroku
1. Create a Heroku app
2. Set environment variables
3. Deploy:
   ```bash
   git push heroku main
   ```

### AWS/Digital Ocean
1. Set up your server
2. Install dependencies
3. Configure environment variables
4. Use PM2 for process management:
   ```bash
   pm2 start npm --name "tinyurl" -- start
   ```

## 🔒 Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Server port | `3000` |
| `MONGODB_URI` | MongoDB connection string | `mongodb://localhost:27017/tinyurl` |
| `REDIS_URL` | Redis connection string | `redis://localhost:6379` |
| `JWT_SECRET` | JWT signing secret | Required |
| `BASE_URL` | Base URL for shortened links | `http://localhost:3000` |
| `RATE_LIMIT_WINDOW` | Rate limit window (ms) | `900000` (15 min) |
| `RATE_LIMIT_MAX` | Max requests per window | `100` |

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow ESLint configuration
- Write tests for new features
- Update documentation as needed
- Use meaningful commit messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Express.js](https://expressjs.com/) - Web framework
- [MongoDB](https://www.mongodb.com/) - Database
- [Redis](https://redis.io/) - Caching layer
- [QR Code](https://www.npmjs.com/package/qrcode) - QR code generation

## 📞 Support

If you have any questions or run into issues, please:
- Check the [Issues](https://github.com/Evyatar831/tinyurl/issues) page
- Create a new issue if your problem isn't already listed
- Contact the maintainer at [your-email@example.com]

## 🔧 Troubleshooting

### Common Issues

**Port already in use**
```bash
lsof -ti:3000 | xargs kill -9
```

**Database connection issues**
- Ensure MongoDB/Redis is running
- Check connection strings in `.env`
- Verify network connectivity

**High memory usage**
- Monitor Redis memory usage
- Implement TTL for cached URLs
- Consider scaling database

---

⭐ **Star this repository if you found it helpful!**

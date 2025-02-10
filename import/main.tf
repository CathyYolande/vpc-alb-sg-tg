provider "aws" {
    region = "us-east-1"
}

import {
  to = aws_instance.web
  id = "i-072bfbd7c26f356ad"
}


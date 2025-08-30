provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAEXAMPLE123456"   # hardcoded secret (bad practice)
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-insecure-bucket"
  acl    = "public-read"   # Public bucket (misconfiguration)

  versioning {
    enabled = false        # Versioning disabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = ""      # No logging enabled
  }
}

resource "aws_security_group" "insecure_sg" {
  name        = "allow_all"
  description = "Security group with open ingress"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Open to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

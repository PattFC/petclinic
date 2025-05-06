terraform {
    backend "s3" {
        bucket         	   = "..."
        key                = "terraform.tfstate"
        region         	   = "eu-north-1"
        encrypt        	   = true
        dynamodb_table     = "..."
    }
}

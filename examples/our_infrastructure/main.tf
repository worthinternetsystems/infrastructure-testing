terraform {
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.12.26"
}

module "our_infrastructure" {
  source = "../../"
}

resource "aws_iam_user" "internal" {
  name = "internal-user"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_s3_bucket" "company_documents" {
  bucket = "worth-company-docs-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.company_documents
  key    = "mountains"
  source = "../../s3-files"
}

# resource "aws_s3_object" "objects" {
#   for_each = fileset("${path.module}/tech-test", "**/*.html")
#   bucket = aws_s3_bucket.b1.id
#   key    = each.value
#   source = "${path.module}/../../${each.value}"
#   content_type = "text/html" 
# }

output "company_document_bucket_tag" {
  value = module.our_infrastructure.instance_tags
}
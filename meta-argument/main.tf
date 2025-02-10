/*
count = 2
depends_on = 
for each
lifecycle

*/
/*
provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "s1" {
    count = 1
    ami = "ami-04681163a08179f28"
    instance_type = "t2.micro"

    tags = {
      Name = "dev-server${count.index  +1}"
    }

}
resource "aws_iam_user" "us1" {
    name = "cloudadmin"
    depends_on = [ aws_instance.s1 ]
}
output "ip" {
  value = aws_instance.s1[*].public_ip
} 
*/

/* locals {
  typeofinstance = ["t2.micro", "t3.small"]
} 

variable "typeofinstance" {
    type = list(string)
    default = ["t2.micro", "t3.small"]
}

variable "info" {
    type = map(string)
    default = {
        dev = {ami: "ami-04681163a08179f28",  instance: "t2.micro"}
        qa = {ami: "ami-04681163a08179f28l", instance: "t2.micro" }
        
    }
    
}

/* resource "aws_instance" "s2" {
    for_each = toset(var.typeofinstance)
    ami = "ami-04681163a08179f28"
    instance_type = each.key
    
} 

resource "aws_instance" "s2" {
    for_each = var.info
    ami = each.key[ami]
    instance_type = each.key[instance]

    tags = {
      Name = each.key
    }
    
} 

provider "aws" {
    region = "us-east-1"
}
variable "region" {
    description = "value of region"
    type = string
    sensitive = true
    // default = "us-east-1"
}


provider "aws" {
    region = "us-east-1"
    alias = "us1"
}

provider "aws" {
    region = "us-east-1"
    alias = "usw1"
}
resource "aws_instance" "server1" {
    provider = aws.us1
    ami = "ami-04681163a08179f28"
    instance_type = "t2.micro"
} */

provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "noella" {
    ami = "ami-045269a1f5c90a6a0"  //apply, then change ami to do create before destroy
    instance_type = "t2.micro"
    lifecycle {
     // create_before_destroy = true
     prevent_destroy = true
    }
}
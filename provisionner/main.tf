provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "server1" {
    ami = "ami-04681163a08179f28"
    instance_type = "t2.micro"
    key_name = aws_key_pair.key.key_name
}

#key pair
resource "tls_private_key" "tls" {
    algorithm = "RSA"
    rsa_bits = 2048
    
}
resource "aws_key_pair" "key" {
    public_key = tls_private_key.tls.public_key_openssh
    key_name = "pro-key"
}
resource "local_file" "key1" {
    filename = "pro-key.pem"
    content = tls_private_key.tls.private_key_pem
}

#null resource
resource "null_resource" "name" {

    provisioner "local-exec" {
        command = "echo ${aws_instance.server1.public_ip} > ip_address.txt"
        
    }
    provisioner "file" {
         source = "ip_address.txt" //path to the file to be copied
        destination = "/home/ec2-user/ip_address.txt"
        
    }
    connection {
      type = "ssh" // ssh -i pro-key.pem ec2-user@${aws_instance.server1.public_ip}
      user = "ec2-user"
      private_key = file("${local_file.key1.filename}")
      host = aws_instance.server1.public_ip
    }
    provisioner "remote-exec" {
        inline = [ 
            "sudo yum install -y httpd",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd",
            "sudo chmod -R 666 /var/www/html",
            "sudo echo '<h1>Welcome to Terraform</h1>' | sudo tee /var/www/html/index.html"

         ]
    }
    depends_on = [ aws_instance.server1, local_file.key1 ]
}
#Create a private key which can be used to login into the webserver
resource "tls_private_key" "key-pair" {
  algorithm = "RSA"
}


#Save public key attributes from the generated key to AWS
resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = tls_private_key.key-pair.public_key_openssh
}


#Save the key to your local system
resource "local_file" "key-pair" {
    content     = tls_private_key.key-pair.private_key_pem
    filename = "webserver-key.pem"
}

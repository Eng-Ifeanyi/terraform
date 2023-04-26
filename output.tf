#CREATE AN OUTPUT RESOURCE
output "website_url" {
  value = "http://${aws_lb.application_load_balancer.dns_name}" #resource type and resource name to output the website name
}
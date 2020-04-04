variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "AMI_ID" {}
variable "KEY_NAME" {}

provider "aws" {
	access_key = var.ACCESS_KEY
	secret_key = var.SECRET_KEY
	region = "us-east-1"
}

resource "aws_alb" "alb" {
	name = "AppColetaTwiter"
        internal = false
        load_balancer_type = "application"
        security_groups = ["sg-0a9dc6760875a9dab"]
        subnets = ["subnet-bdb6429c", "subnet-bd784583"]
}

resource "aws_lb_target_group_attachment" "albt" {
	target_group_arn = "${aws_lb_target_group.alb.arn}"
	target_id = "${aws_instance.AppColetaTwiter.id}"
	port = 80
}

resource "aws_alb_listener" "alb" {
	load_balancer_arn = "${aws_alb.alb.arn}"
	port = "80"
	protocol = "HTTP"
	default_action {
		type = "forward"
		target_group_arn = "${aws_lb_target_group.alb.arn}"
		}
	}

resource "aws_lb_target_group" "alb" {
	name = "alb"
	port = 80
	protocol = "HTTP"
	vpc_id = "vpc-25271d5f"
}

resource "aws_instance" "AppColetaTwiter" {
	ami = var.AMI_ID
	instance_type = "t2.micro"
	key_name = var.KEY_NAME
	subnet_id = "subnet-bdb6429c"
	security_groups = ["sg-0a9dc6760875a9dab"]
	associate_public_ip_address = false 
	tags = {
		Name = "AppColetaTwiter"
	 }
}

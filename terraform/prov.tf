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
	name = "AppColetaTwiterALB"
        internal = false
        load_balancer_type = "application"
        security_groups = ["sg-0a9dc6760875a9dab"]
        subnets = ["subnet-bdb6429c", "subnet-bd784583"]
}

resource "aws_alb_listener" "alb" {
        load_balancer_arn = "${aws_alb.alb.arn}"
        port = "80"
        protocol = "HTTP"
        default_action {
                type = "forward"
                target_group_arn = "${aws_alb_target_group.alb.arn}"
                }
}

resource "aws_alb_target_group" "alb" {
        name = "alb"
        port = 80
        protocol = "HTTP"
        target_type = "instance"
        vpc_id = "vpc-25271d5f"
}

resource "aws_autoscaling_attachment" "asg" {
	autoscaling_group_name = "${aws_autoscaling_group.Scaling.id}"
	alb_target_group_arn = "${aws_alb_target_group.alb.arn}"
}

resource "aws_launch_configuration" "AppColetaTwiter" {
	name_prefix = "AppColetaTwiter"
	image_id = var.AMI_ID
	instance_type = "t2.micro"
	key_name = var.KEY_NAME
	security_groups = ["sg-0a9dc6760875a9dab"]
	associate_public_ip_address = false
}

resource "aws_autoscaling_group" "Scaling" {
	availability_zones = ["us-east-1"]
	desired_capacity = 1
	max_size = 1
	min_size = 1
	vpc_zone_identifier = ["subnet-bdb6429c", "subnet-bd784583"]
	launch_configuration =  "${aws_launch_configuration.AppColetaTwiter.name}"
	force_delete = true
	tag {
		key = "Name"
		value = "AppColetaTwiter"
		propagate_at_launch = true
	}
}


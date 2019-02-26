resource "aws_alb_listener" "http" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${module.https_redirection_ecs_service.target_group_arn}"
    type             = "forward"
  }
}

module "https_redirection_container_definition" {
  source = "github.com/mergermarket/tf_ecs_container_definition.git?ref=no-secrets"

  name           = "https-redirection"
  image          = "mergermarket/https-redirector"
  cpu            = "16"
  memory         = "16"
  container_port = "80"
}

module "https_redirection_task_definition" {
  source = "github.com/mergermarket/tf_ecs_task_definition"

  family                = "${join("", slice(split("", var.name), 0, length(var.name) > 22 ? 23 : length(var.name)))}-https-redirection"
  container_definitions = ["${module.https_redirection_container_definition.rendered}"]
}

module "https_redirection_ecs_service" {
  source = "github.com/mergermarket/tf_load_balanced_ecs_service"

  name                 = "${format("%s-https-redirection", var.name)}"
  container_name       = "https-redirection"
  container_port       = "80"
  vpc_id               = "${var.vpc_id}"
  task_definition      = "${module.https_redirection_task_definition.arn}"
  desired_count        = "2"
  alb_listener_arn     = "${aws_alb_listener.http.arn}"
  alb_arn              = "${var.alb_arn}"
  health_check_matcher = "300-399"
}

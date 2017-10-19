resource "aws_alb_listener" "http" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${module.https_redirector_ecs_service.target_group_arn}"
    type             = "forward"
  }
}

module "https_redirector_container_definition" {
  source = "github.com/mergermarket/tf_ecs_container_definition.git"

  name           = "https-redirector"
  image          = "mergermarket/https-redirector"
  cpu            = "16"
  memory         = "16"
  container_port = "80"
}

module "https_redirector_task_definition" {
  source = "github.com/mergermarket/tf_ecs_task_definition"

  family                = "${join("", slice(split("", format("%s-%s", var.env, var.component)), 0, length(format("%s-%s", var.env, var.component)) > 22 ? 23 : length(format("%s-%s", var.env, var.component))))}-https-redirector"
  container_definitions = ["${module.https_redirector_container_definition.rendered}"]
}

module "https_redirector_ecs_service" {
  source = "github.com/mergermarket/tf_load_balanced_ecs_service"

  name                 = "${format("%s-%s-https-redirector", var.env, var.component)}"
  container_name       = "https-redirector"
  container_port       = "80"
  vpc_id               = "${var.platform_config["vpc"]}"
  task_definition      = "${module.https_redirector_task_definition.arn}"
  desired_count        = "${var.env == "live" ? 2 : 1}"
  alb_listener_arn     = "${aws_alb_listener.http.arn}"
  alb_arn              = "${var.alb_arn}"
  health_check_matcher = "300-399"
}

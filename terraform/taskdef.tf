resource "aws_ecs_task_definition" "app_task" {
  family                   = "melodicmind-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn

  container_definitions = jsonencode([
    {
      name      = "melodicmind"
      image     = "${aws_ecr_repository.app_repo.repository_url}:latest"
      essential = true
      portMappings = [{
        containerPort = 8000
        hostPort      = 8000
      }]
    }
  ])
}

resource "aws_ecs_service" "app_service" {
  name            = "melodicmind-service"
  cluster         = aws_ecs_cluster.app_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.app_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "melodicmind"
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.app_listener]
}

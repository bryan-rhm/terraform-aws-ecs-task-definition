resource "aws_ecs_task_definition" "this" {
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  family                   = var.name
  network_mode             = var.network_mode
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.task_execution_role
  container_definitions    = var.container_definitions
  requires_compatibilities = var.requires_compatibilities
  
  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = try(placement_constraints.value.expression, null)
      type       = placement_constraints.value.type
    }
  }

  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = try(proxy_configuration.value.properties, null)
      type           = try(proxy_configuration.value.type, null)
    }
  }
  
  dynamic "volume" {
    for_each = var.volumes
    content {
      name = volume.value.name

      host_path = lookup(volume.value, "host_path", null)

      dynamic "docker_volume_configuration" {
        for_each = try(volume.value.docker_volume_configuration, null) != null ? ["enable_docker_volume"] : []
        content {
          autoprovision = lookup(volume.value.docker_volume_configuration, "autoprovision", null)
          driver        = lookup(volume.value.docker_volume_configuration, "driver", null)
          driver_opts   = lookup(volume.value.docker_volume_configuration, "driver_opts", null)
          labels        = lookup(volume.value.docker_volume_configuration, "labels", null)
          scope         = lookup(volume.value.docker_volume_configuration, "scope", null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = try(volume.value.efs_volume_configuration, null) != null ? ["enable_efs"] : []
        content {
          file_system_id          = lookup(volume.value.efs_volume_configuration, "file_system_id", null)
          root_directory          = lookup(volume.value.efs_volume_configuration, "root_directory", null)
          transit_encryption      = lookup(volume.value.efs_volume_configuration, "transit_encryption", null)
          transit_encryption_port = lookup(volume.value.efs_volume_configuration, "transit_encryption_port", null)
          dynamic "authorization_config" {
            for_each = try(volume.value.efs_volume_configuration.authorization_config,null) != null ? ["authorization_config"] : []
            content {
              access_point_id = lookup(volume.value.efs_volume_configuration.authorization_config, "access_point_id", null)
              iam             = lookup(volume.value.efs_volume_configuration.authorization_config, "iam", null)
            }
          }
        }
      }
    }
  }

  tags = var.tags
}
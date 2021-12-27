# Terraform ECS Task Definition Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.43.0 |


## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_definitions"></a> [container\_definitions](#input\_container\_definitions) | A list of valid container definitions provided as a single valid JSON document. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A unique name for your task definition. | `string` | n/a | yes |
| <a name="input_placement_constraints"></a> [placement\_constraints](#input\_placement\_constraints) | (Optional) Configuration block for rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression". | `list(any)` | `[]` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | (Optional) Configuration block for the App Mesh proxy. | `list(any)` | `[]` | no |
| <a name="input_requires_compatibilities"></a> [requires\_compatibilities](#input\_requires\_compatibilities) | Set of launch types required by the task. The valid values are EC2 and FARGATE. | `list` | <pre>[<br>  "FARGATE"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Key-value map of resource tags. | `map(string)` | `{}` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | (Optional) Number of cpu units used by the task. If the requires\_compatibilities is FARGATE this field is required. | `number` | `null` | no |
| <a name="input_task_execution_role"></a> [task\_execution\_role](#input\_task\_execution\_role) | (Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string` | `null` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | (Optional) Amount (in MiB) of memory used by the task. If the requires\_compatibilities is FARGATE this field is required. | `number` | `null` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | (Optional) ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | (Optional) Configuration block for volumes that containers in your task may use. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | Task definition attributes |

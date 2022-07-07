variable "name" {
  description = "A unique name for your task definition."
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions provided as a single valid JSON document."
  type        = string
}

variable "tags" {
  description = "(Optional) Key-value map of resource tags."
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
#------------------------------------------------------------------------------
variable "task_role_arn" {
  description = "(Optional) ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
  type        = string
  default     = null
}

variable "task_execution_role" {
  description = "(Optional) ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume."
  type        = string
  default     = null
}

variable "placement_constraints" {
  description = "(Optional) Configuration block for rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\"."
  type        = list(any)
  default     = []
}

variable "task_cpu" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = null
}

variable "task_memory" {
  description = "(Optional) Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required."
  type        = number
  default     = null
}

variable "proxy_configuration" {
  description = "(Optional) Configuration block for the App Mesh proxy."
  type        = list(any)
  default     = []
}

variable "volumes" {
  description = "(Optional) Configuration block for volumes that containers in your task may use."
  type = list(object({
    host_path = optional(string)
    name      = string
    docker_volume_configuration = optional(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = optional(object({
      file_system_id          = string
      root_directory          = optional(string)
      transit_encryption      = optional(string)
      transit_encryption_port = optional(string)
      authorization_config = optional(object({
        access_point_id = optional(string)
        iam             = optional(string)
      }))
    }))
  }))
  default = []
}

variable "network_mode" {
  description = "(Optional) Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host."
  type        = string
  default     = "awsvpc"
}

variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE."
  type        = list(string)
  default     = ["FARGATE"]
}
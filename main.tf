resource "null_resource" "local" {
  provisioner "local-exec" {
    command = "python3"

    environment = {
      PYTHON_SCRIPT_CONTENT = var.python_script_content
    }

    interpreter = ["bash", "-c"]
    command = <<-EOT
      echo "$PYTHON_SCRIPT_CONTENT" > script.py
      python3 script.py
    EOT
  }

  triggers = {
    always_run = var.executed_repeatedly == true ? "${timestamp()}" : null
  }
}

resource "null_resource" "local" {
  provisioner "local-exec" {
    environment = {
      PYTHON_SCRIPT_CONTENT = var.python_script_content
    }
    command = <<-EOT
      echo "$PYTHON_SCRIPT_CONTENT" > script.py
      python3 script.py
    EOT
  }

  triggers = {
    always_run = var.executed_repeatedly == true ? "${timestamp()}" : null
  }
}

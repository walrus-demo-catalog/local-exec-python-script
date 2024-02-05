variable "python_script_content" {
  type        = string
  description = "Python script to run in Terraform local execution environment."
  default     = <<-EOT
              import requests
              import json
              import argparse

              def create_user(username, password, user_type='user'):
                  # Set variables
                  WALRUS_URL = "https://localhost"
                  WALRUS_TOKEN = "du7cbzafkvnw-EHUPB7u82ChS4DBpid81LizQChB5cTrv5ihKUuwaDdw7uIoiaTaWbdzAkmYFAi6iFo6B3ZY9PqSbHq53ok81x8l2VgHOhnpd9iFfd1XxgDFRsZ0xz9fTmg"

                  # Define data based on user_type
                  if user_type == 'manager':
                      data = {
                          "kind": "user",
                          "domain": "builtin",
                          "name": username,
                          "password": password,
                          "roleId": "system/manager",
                          "roles": [
                              {
                                  "role": {
                                      "id": "system/manager"
                                  }
                              }
                          ]
                      }
                  else:
                      data = {
                          "kind": "user",
                          "domain": "builtin",
                          "name": username,
                          "password": password,
                          "roleId": "0",
                          "roles": []
                      }

                  # Make the request headers
                  headers = {
                      'content-type': 'application/json',
                      'Authorization': f'Bearer {WALRUS_TOKEN}'
                  }

                  # Send POST request
                  response = requests.post(f'{WALRUS_URL}/v1/subjects', headers=headers, json=data, verify=False)

                  # Print response
                  print("Status code:", response.status_code, response.text)

              if __name__ == "__main__":
                  # Parsing command arguments with argparse
                  parser = argparse.ArgumentParser(description='Create user or manager in Walrus')
                  parser.add_argument('--user', type=str, help='Username', default='ops')
                  parser.add_argument('--password', type=str, help='Password', default='Seal@123')
                  parser.add_argument('--user-type', choices=['user', 'manager'], default='user', help='User type (default: user)')

                  args = parser.parse_args()

                  # Call function and pass arguments
                  create_user(args.user, args.password, user_type=args.user_type)
              EOT
}

variable "executed_repeatedly" {
  type        = bool
  description = "Allow command to be executed repeatedly."
  default     = true
}

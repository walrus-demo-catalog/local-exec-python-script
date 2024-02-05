## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.local](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_executed_repeatedly"></a> [executed\_repeatedly](#input\_executed\_repeatedly) | Allow command to be executed repeatedly. | `bool` | `true` | no |
| <a name="input_python_script_content"></a> [python\_script\_content](#input\_python\_script\_content) | Python script to run in Terraform local execution environment. | `string` | `"import requests\nimport json\nimport argparse\n\ndef create_user(username, password, user_type='user'):\n    # Set variables\n    WALRUS_URL = \"https://localhost\"\n    WALRUS_TOKEN = \"du7cbzafkvnw-EHUPB7u82ChS4DBpid81LizQChB5cTrv5ihKUuwaDdw7uIoiaTaWbdzAkmYFAi6iFo6B3ZY9PqSbHq53ok81x8l2VgHOhnpd9iFfd1XxgDFRsZ0xz9fTmg\"\n\n    # Define data based on user_type\n    if user_type == 'manager':\n        data = {\n            \"kind\": \"user\",\n            \"domain\": \"builtin\",\n            \"name\": username,\n            \"password\": password,\n            \"roleId\": \"system/manager\",\n            \"roles\": [\n                {\n                    \"role\": {\n                        \"id\": \"system/manager\"\n                    }\n                }\n            ]\n        }\n    else:\n        data = {\n            \"kind\": \"user\",\n            \"domain\": \"builtin\",\n            \"name\": username,\n            \"password\": password,\n            \"roleId\": \"0\",\n            \"roles\": []\n        }\n\n    # Make the request headers\n    headers = {\n        'content-type': 'application/json',\n        'Authorization': f'Bearer {WALRUS_TOKEN}'\n    }\n\n    # Send POST request\n    response = requests.post(f'{WALRUS_URL}/v1/subjects', headers=headers, json=data, verify=False)\n\n    # Print response\n    print(\"Status code:\", response.status_code, response.text)\n\nif __name__ == \"__main__\":\n    # Parsing command arguments with argparse\n    parser = argparse.ArgumentParser(description='Create user or manager in Walrus')\n    parser.add_argument('--user', type=str, help='Username', default='ops')\n    parser.add_argument('--password', type=str, help='Password', default='Seal@123')\n    parser.add_argument('--user-type', choices=['user', 'manager'], default='user', help='User type (default: user)')\n\n    args = parser.parse_args()\n\n    # Call function and pass arguments\n    create_user(args.user, args.password, user_type=args.user_type)\n"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_python_script_content"></a> [python\_script\_content](#output\_python\_script\_content) | n/a |

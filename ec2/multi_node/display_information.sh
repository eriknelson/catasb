#!/bin/sh
[ -z "$AWS_ACCESS_KEY_ID" ] && echo "Missing environment variable:  AWS_ACCESS_KEY_ID" && exit 1;
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo "Missing environment variable:  AWS_SECERT_ACCESS_KEY" && exit 1;
[ -z "$AWS_SSH_PRIV_KEY_PATH" ] && echo "Missing environment variable:  AWS_SSH_PRIV_KEY_PATH\nPlease set this to the path for your SSH private key\n" && exit 1;
[ ! -r "$AWS_SSH_PRIV_KEY_PATH" ] && echo -e "Unable to read file pointed to by, AWS_SSH_PRIV_KEY_PATH, $AWS_SSH_PRIV_KEY_PATH" && exit 1;

source ./export_ec2_hosts

source ../../gather_config

source ./get_ec2_username

ansible-playbook \
  -u ${EC2_USER} \
  --private-key ${AWS_SSH_PRIV_KEY_PATH} \
  -i ${ANS_CODE}/library/inventory/ec2.py \
  ${ANS_CODE}/display_aws_multi_node_information.yml \
  --extra-vars "${EXTRA_VARS}" \
  ${extra_args} $@

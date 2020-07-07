resource "aws_iam_instance_profile" "relay_node_profile" {
  name = "CARDANO-RELAY-PROFILE"
  role = aws_iam_role.relay_ssm_role.name
}

resource "aws_iam_role" "relay_ssm_role" {
  name = "CARDANO-RELAY-IAM-ROLE-1"
  description = "Allows EC2 instances to call AWS services like CloudWatch and SSM on your behalf."

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "s3.amazonaws.com",
          "ec2.amazonaws.com",
          "ssm.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3policy" {
  name = "CARDANO-RELAY-S3POLICY"
  role = aws_iam_role.relay_ssm_role.id
  policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Action": [
           "s3:ListBucket",
           "s3:HeadBucket"
         ],
         "Resource": ["arn:aws:s3:::*"]
       },
       {
         "Effect": "Allow",
         "Action": [
           "s3:PutObject",
           "s3:ListObjects",
           "s3:GetObject"
         ],
         "Resource": ["arn:aws:s3:::*"]
       }
     ]
   }
EOF
}
data "aws_iam_policy_document" "relay_eip" {
  statement {
    actions = [
      "ec2:DescribeAddresses",
      "ec2:AssociateAddress",
      "ec2:AllocateAddress",
      "kms:CreateGrant"
    ]

    resources = [
      "*"]
    effect = "Allow"
  }
}

data "aws_iam_policy_document" "relay_ssm_access" {
  statement {
    effect = "Allow"

    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameterHistory",
      "ssm:GetParametersByPath",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:LabelParameterVersion"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_prefix}/cardano/users/server_username",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter${local.parameter_prefix}/cardano/users/server_password",
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/cardano/s3_backup_bucket"
    ]
  }
}

resource "aws_iam_role_policy_attachment" "ssm-attach" {
  role       = aws_iam_role.relay_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  depends_on = [aws_iam_role.relay_ssm_role]
}

resource "aws_iam_role_policy_attachment" "writetocloudwatch" {
  role       = aws_iam_role.relay_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  depends_on = [aws_iam_role.relay_ssm_role]
}

resource "aws_iam_role_policy_attachment" "CloudWatchAgentServerPolicy" {
  role       = aws_iam_role.relay_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  depends_on = [aws_iam_role.relay_ssm_role]
}

resource "aws_iam_policy" "relay_ssm_access_policy" {
  name        = "relay-ssm-parameter-access-policy"
  description = "Allows the Relay server to access SSM parameters"
  policy      = data.aws_iam_policy_document.relay_ssm_access.json
}

resource "aws_iam_policy" "relay_eip_associate_policy" {
  name        = "relay-eip-associate-policy"
  description = "Allows the Relay server to associate Eip"
  policy      = data.aws_iam_policy_document.relay_eip.json
}

resource "aws_iam_role_policy_attachment" "relay_ssm_access" {
  role       = aws_iam_role.relay_ssm_role.name
  policy_arn = aws_iam_policy.relay_ssm_access_policy.arn
  depends_on = [aws_iam_role.relay_ssm_role]
}

resource "aws_iam_role_policy_attachment" "relay_eip_associate" {
  role       = aws_iam_role.relay_ssm_role.name
  policy_arn = aws_iam_policy.relay_eip_associate_policy.arn
  depends_on = [aws_iam_role.relay_ssm_role]
}

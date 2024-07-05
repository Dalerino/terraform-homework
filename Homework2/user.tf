resource "aws_iam_user" "users" {
  for_each = toset(["jenny","rose","lisa","jisoo"])
  name = each.key
}

resource "aws_iam_group" "blackpink" {
  name = "blackpink"
}

resource "aws_iam_group_membership" "team" {
  name = "blackpink-group"
  group = aws_iam_group.blackpink.name
  users = [for user in aws_iam_user.users : user.name]
}

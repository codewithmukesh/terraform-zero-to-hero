resource "null_resource" "build_dotnet_lambda" {
  provisioner "local-exec" {
    command     = <<EOT
      dotnet restore ../HelloAPI/HelloAPI.csproj
      dotnet publish ../HelloAPI/HelloAPI.csproj -c Release -r linux-x64 --self-contained false -o ../HelloAPI/publish
    EOT
    interpreter = ["PowerShell", "-Command"]
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

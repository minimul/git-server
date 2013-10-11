Vagrant.configure("2") do |config|
  config.vm.hostname = "git-server"
  config.vm.box = "aws-basic"
  config.vm.boot_timeout   = 120
  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      misc: {
        ssh_key: File.read(ENV['MY_PUBLIC_SSH_KEY_PATH'])
      },
      s3cmd: {
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      }
    }

    chef.run_list = [
      'recipe[git-server::default]'
    ]
  end

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_KEYPAIR_NAME']
    aws.security_groups = ['put-in-your-security-group']
    aws.instance_type = "t1.micro"
    #aws.ami = "ami-c30360aa"
    aws.ami = "ami-d0f89fb9"
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV['MY_PRIVATE_AWS_SSH_KEY_PATH']
  end
end

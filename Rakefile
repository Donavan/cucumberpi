task :default => [:image_disk]

def list_devices
  sh 'diskutil list | grep -e "[#1-9]:"'
end

def ask_yn? (question, default=false)
  print question
  while true
    response = gets.chomp
    case response
    when /^y|^Y/
      return true
    when /^n|^N/
      return false
    when /^$/
      return default
    end
  end
end

def ask_question? (question, default="")
  print question
  response = gets.chomp
  return default if response == ""
  response
end

def ask_disk?
  list_devices
  ask_question?("Enter the identifier of the disk you wish to use (Press enter to cancel): ")
end

def safe_ask_disk?
  while true
    disk = ask_disk?
    if disk.start_with?("disk0")
      print "\n\n\n*********************************************\n\nCowardly refusing to use your primary disk...\n\n"
    else
      return disk if disk == ""
      return disk if ask_yn?("Use #{disk} (All contents will be replaced.) [y/N]? ", false)
    end
  end
end

file "raspbian.zip" do
  print "Fetching raspbian diskimage zip..."
  sh "curl -L -o raspbian.zip http://files.velocix.com/c1410/images/raspbian/2012-09-18-wheezy-raspbian/2012-09-18-wheezy-raspbian.zip"
  print "done!\n"
end


task :image_disk => ["raspbian.zip"] do
  disk = safe_ask_disk?
  if disk != ""
    sh "mount | grep disk6s1 | cut -d ' ' -f 1 | sudo xargs diskutil unmount"
    raw_disk = "/dev/r" + disk.scan(/(disk\d+)(s\d+|$)/)[0][0] 
    print "Creating disk image on #{raw_disk}...\n"
    sh "unzip -p raspbian.zip | sudo dd of=#{raw_disk} bs=1m"
  end
end

def raw_add_disk(disk_name, disk_size_mb, options = {})
    raise _("VM has no EMS, unable to add disk") unless ext_management_system
    if options[:datastore]
      datastore = ext_management_system.hosts.collect do |h|
        h.writable_storages.find_by(:name => options[:datastore])
      end.uniq.compact.first
      raise _("Datastore does not exist or cannot be accessed, unable to add disk") unless datastore
    end

    run_command_via_parent(:vm_add_disk, :diskName => disk_name, :diskSize => disk_size_mb,
        :thinProvisioned => options[:thin_provisioned], :dependent => options[:dependent],
        :persistent => options[:persistent], :bootable => options[:bootable], :datastore => datastore,
        :interface => options[:interface])
  end

  def add_disk(disk_name, disk_size_mb, options = {})
    raw_add_disk(disk_name, disk_size_mb, options)
  end

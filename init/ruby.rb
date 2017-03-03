if !ENV.has_key?('MODULE_VERSION') then
  ENV['MODULE_VERSION_STACK'] = "3.2.10"
  ENV['MODULE_VERSION']       = "3.2.10"
else
  ENV['MODULE_VERSION_STACK'] = ENV['MODULE_VERSION']
end
ENV['MODULESHOME'] = "/usr/share/modules"

if !ENV.has_key?('MODULEPATH') then
  ENV['MODULEPATH'] = File.open("#{ENV['MODULESHOME']}/init/.modulespath","r").readlines.reject {|e| e =~ /^(\s*#|$)/}.join(":") 
end


if !ENV.has_key?('LOADEDMODULES') then
	ENV['LOADEDMODULES'] = ''
end

class ENVModule
  def ENVModule.module(*args)
    if args[0].kind_of?(Array) then
      args = args[0].join(" ")
    else
      args = args.join(" ")
    end
    exec_prefix = "/usr/share/modules/#{ENV['MODULE_VERSION']}"
    eval  `/usr/bin/modulecmd ruby #{args}`


  end
  
  def ENVModule.load(args)
     ENVModule.module "load #{self.get_args(args)}"
  end
  
  def ENVModule.unload(args)
     ENVModule.module "unload #{self.get_args(args)}"
  end
  def ENVModule.list
    ENVModule.module 'list'
  end
  private
  def ENVModule.get_args(args)
    if args.kind_of?(Array) then
      arg = args.join(" ")
    else
      arg = args
    end
    return arg
  end
end

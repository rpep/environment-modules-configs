import os, re, subprocess

if not os.environ.has_key('MODULE_VERSION'):
	os.environ['MODULE_VERSION_STACK'] = '3.2.10'
	os.environ['MODULE_VERSION'] = '3.2.10'
else:
	os.environ['MODULE_VERSION_STACK'] = os.environ['MODULE_VERSION']
os.environ['MODULESHOME'] = '/usr/share/modules'

if not os.environ.has_key('MODULEPATH'):
	f = open(os.environ['MODULESHOME'] + "/init/.modulespath", "r")
	path = []
	for line in f.readlines():
		line = re.sub("#.*$", '', line)
		if line is not '':
			path.append(line)
	os.environ['MODULEPATH'] = ':'.join(path)

if not os.environ.has_key('LOADEDMODULES'):
	os.environ['LOADEDMODULES'] = ''
	
def module(*args):
	if type(args[0]) == type([]):
		args = args[0]
	else:
		args = list(args)
	(output, error) = subprocess.Popen(['/usr/bin/modulecmd' % os.environ['MODULE_VERSION'], 'python'] + 
			args, stdout=subprocess.PIPE).communicate()
	exec output


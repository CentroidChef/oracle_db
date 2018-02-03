#
# Cookbook Name:: oracle
# Attributes::default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

## Settings specific to the Oracle user.
default[:oracle_db][:user][:uid] = 54321
default[:oracle_db][:user][:gid] = 54321
default[:oracle_db][:user][:shell] = '/bin/ksh'
default[:oracle_db][:user][:sup_grps] = {'dba' => 54322, 'bckpdba' => 54324, 'dgdba' => 54325, 'kmdba' => 54326}
default[:oracle_db][:user][:pw_set] = false
default[:oracle_db][:user][:edb] = 'oracle'
default[:oracle_db][:user][:edb_item] = 'foo'

## Settings specific to the Oracle Client user.
default[:oracle_db][:cliuser][:uid] = 301
default[:oracle_db][:cliuser][:gid] = 301
default[:oracle_db][:cliuser][:shell] = '/bin/ksh'
default[:oracle_db][:cliuser][:sup_grps] = {'oinstall' => 201}
default[:oracle_db][:cliuser][:pw_set] = false
default[:oracle_db][:cliuser][:edb] = 'oracli'
default[:oracle_db][:cliuser][:edb_item] = 'foo'

# General Oracle settings.
default[:oracle_db][:ora_base] = '/opt/oracle'
default[:oracle_db][:ora_inventory] = '/opt/oraInventory'

## Settings specific to the Oracle RDBMS proper.
default[:oracle_db][:rdbms][:dbbin_version] = '11g'
default[:oracle_db][:rdbms][:ora_home] = "#{node[:oracle_db][:ora_base]}/11R23"
default[:oracle_db][:rdbms][:ora_home_12c] = "#{node[:oracle_db][:ora_base]}/12R1"
default[:oracle_db][:rdbms][:is_installed] = false
default[:oracle_db][:rdbms][:install_info] = {}
default[:oracle_db][:rdbms][:install_dir] = "#{node[:oracle_db][:ora_base]}/install_dir"
default[:oracle_db][:rdbms][:response_file_url] = ''
default[:oracle_db][:rdbms][:db_create_template] = 'default_template.dbt'

## Settings specific to the Oracle Client proper.
default[:oracle_db][:client][:ora_home] = "#{node[:oracle_db][:ora_base]}/11R23cli"
default[:oracle_db][:client][:is_installed] = false
default[:oracle_db][:client][:install_info] = {}
default[:oracle_db][:client][:install_dir] = "#{node[:oracle_db][:ora_base]}/install_dir_client"
default[:oracle_db][:client][:response_file_url] = ''

# Dependencies for Oracle 11.2.
# Source: <http://docs.oracle.com/cd/E11882_01/install.112/e24321/pre_install.htm#CIHFICFD>
# We omit version-release info by design, as their requirements are satisfied by
# CentOS 6.4, which is the minimum version targeted by oracle.
default[:oracle_db][:rdbms][:deps] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc',
                                   'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio',
                                   'libaio-devel', 'make', 'sysstat']

# Oracle dependencies for 12c
default[:oracle_db][:rdbms][:deps_12c] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'gcc', 'gcc-c++', 'glibc',
                                   'glibc-devel', 'ksh', 'libgcc', 'libstdc++', 'libstdc++-devel', 'libaio',
                                   'libaio-devel', 'libXext', 'libXtst', 'libX11', 'libXau', 'libxcb', 'libXi', 'make', 'sysstat']

# Oracle environment for 11g
default[:oracle_db][:rdbms][:env] = {'ORACLE_BASE' => node[:oracle_db][:ora_base],
                                  'ORACLE_HOME' => node[:oracle_db][:rdbms][:ora_home],
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle_db][:ora_base]}/dba/bin:#{node[:oracle_db][:rdbms][:ora_home]}/bin:#{node[:oracle_db][:rdbms][:ora_home]}/OPatch"}

# Oracle environment for 12c
default[:oracle_db][:rdbms][:env_12c] = {'ORACLE_BASE' => node[:oracle_db][:ora_base],
                                  'ORACLE_HOME' => node[:oracle_db][:rdbms][:ora_home_12c],
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle_db][:ora_base]}/dba/bin:#{node[:oracle_db][:rdbms][:ora_home_12c]}/bin:#{node[:oracle_db][:rdbms][:ora_home_12c]}/OPatch"}

default[:oracle_db][:rdbms][:install_files] = ['http://chef-assets.centroid.com/software/oracle_db/linuxx64_12201_database.zip']

# Client dependencies
default[:oracle_db][:client][:deps] = ['binutils', 'compat-libcap1', 'compat-libstdc++-33', 'compat-libstdc++-33.i686', 'gcc', 'gcc-c++', 'glibc', 'glibc.i686',
                                   'glibc-devel', 'glibc-devel.i686', 'ksh', 'libgcc', 'libgcc.i686', 'libstdc++', 'libstdc++.i686', 'libstdc++-devel', 'libstdc++-devel.i686', 'libaio', 'libaio.i686', 'libaio-devel', 'libaio-devel.i686', 'make', 'sysstat']

# Client environment parameters
default[:oracle_db][:client][:env] = {'ORACLE_BASE' => node[:oracle_db][:ora_base],
                                  'ORACLE_HOME' => node[:oracle_db][:client][:ora_home],
                                  'LD_LIBRARY_PATH' => "#{node[:oracle_db][:client][:ora_home]}/lib",
                                  'PATH' => "/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/sbin:#{node[:oracle_db][:ora_base]}/dba/bin:#{node[:oracle_db][:client][:ora_home]}/bin:#{node[:oracle_db][:client][:ora_home]}/OPatch"}

# Install media file for the Oracle Client
default[:oracle_db][:client][:install_files] = ['https://https-server.example.localdomain/path/to/p10404530_112030_Linux-x86-64_4of7.zip']

# Passwords set by createdb.rb for the default open database users.
# By order of appearance, those are: SYS, SYSTEM and DBSNMP.
# The latter is for the OEM agent.
default[:oracle_db][:rdbms][:sys_pw] = 'sys_pw_goes_here'
default[:oracle_db][:rdbms][:system_pw] = 'system_pw_goes_here'
default[:oracle_db][:rdbms][:dbsnmp_pw] = 'dbsnmp_pw_goes_here'

# Settings related to patching.
default[:oracle_db][:rdbms][:opatch_update_url] = 'http://10.0.2.2/~georgezhang/p6880880_121010_Linux-x86-64.zip'
default[:oracle_db][:rdbms][:latest_patch][:url] = 'http://10.0.2.2/~georgezhang/p25171037_121020_Linux-x86-64.zip'

# Settings related to client patching.
default[:oracle_db][:client][:opatch_update_url] = 'https://https-server.example.localdomain/path/to/p6880880_112000_Linux-x86-64.zip'
default[:oracle_db][:client][:latest_patch][:url] = 'https://https-server.example.localdomain/path/to/p16619892_112030_Linux-x86-64.zip'

# Typically the latest patch's expanded directory's name will match
# the part of the latest patch's filename following the initial 'p', 
# up until , and excluding, the first '_', but this is not guaranteed to
# always be the case.
default[:oracle_db][:rdbms][:latest_patch][:dirname] = '16619892'
default[:oracle_db][:rdbms][:latest_patch][:dirname_12c] = '25171037'
default[:oracle_db][:rdbms][:latest_patch][:is_installed] = false

# Client patch folder
default[:oracle_db][:client][:latest_patch][:dirname] = '16619892'
default[:oracle_db][:client][:latest_patch][:is_installed] = false

# Hash of DBs to create; the keys are the DBs' names, the values are Booleans,
# with true indicating the DB has already been created and should be skipped
# by createdb.rb. We don't create any DBs by default, hence the attribute's
# value is set to an empty Hash.
default[:oracle_db][:rdbms][:dbs] = {}
# The directory under which we install the DBs.
default[:oracle_db][:rdbms][:dbs_root] = "/oradata"

# Local emConfiguration
# Attributes for the local database dbcontrol for all databases.
default[:oracle_db][:rdbms][:dbconsole][:emconfig] = true
default[:oracle_db][:rdbms][:dbconsole][:sysman_pw] = 'sysman_pw_goes_here'
default[:oracle_db][:rdbms][:dbconsole][:notification_email] = 'foo@bar.inet'
default[:oracle_db][:rdbms][:dbconsole][:outgoing_mail] = 'mailhost'

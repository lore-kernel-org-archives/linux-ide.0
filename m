From: Daniele <kailed@kailed.net>
Subject: Rapidly increasing Load_Cycle_Count on Acer 2930z
Date: Tue, 15 Dec 2009 19:56:02 +0100
Message-ID: <200912151956.02364.kailed@kailed.net>
Reply-To: kailed@kailed.net
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cp-out8.libero.it ([212.52.84.108]:57770 "EHLO
	cp-out8.libero.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbZLOS7O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Dec 2009 13:59:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: teheo@novell.com

Hi folks,
on my acer2930z Load_Cycle_Count increase every 5 seconds when idle.

Setting APM_LEVEL to 200 (default 128) fix the issue, LCC doesn't not 
increase anymore.

## hdparm -I output:
/dev/sda:

ATA device, with non-removable media
        Model Number:       Hitachi HTS543225L9A300                 
        Serial Number:      090312FB2D06LJGP00RH                    
        Firmware Revision:  FBEOC40C                                
        Transport:          Serial, ATA8-AST, SATA 1.0a, SATA II 
Extensions, SATA Rev 2.5, SATA Rev 2.6; Revision: ATA8-AST T13 Project 
D1697 Revision 0b
Standards:                                                                                                                                               
        Used: ATA-8-ACS revision 3f                                                                                                                      
        Supported: 8 7 6 5                                                                                                                               
Configuration:                                                                                                                                           
        Logical         max     current                                                                                                                  
        cylinders       16383   16383                                                                                                                    
        heads           16      16                                                                                                                       
        sectors/track   63      63                                                                                                                       
        --                                                                                                                                               
        CHS current addressable sectors:   16514064                                                                                                      
        LBA    user addressable sectors:  268435455                                                                                                      
        LBA48  user addressable sectors:  488397168                                                                                                      
        Logical/Physical Sector size:           512 bytes                                                                                                
        device size with M = 1024*1024:      238475 MBytes                                                                                               
        device size with M = 1000*1000:      250059 MBytes (250 GB)                                                                                      
        cache/buffer size  = 7114 KBytes (type=DualPortCache)                                                                                            
        Nominal Media Rotation Rate: 5400                                                                                                                
Capabilities:                                                                                                                                            
        LBA, IORDY(can be disabled)                                                                                                                      
        Queue depth: 32                                                                                                                                  
        Standby timer values: spec'd by Vendor, no device specific 
minimum                                                                               
        R/W multiple sector transfer: Max = 16  Current = 16                                                                                             
        Advanced power management level: 128                                                                                                             
        Recommended acoustic management value: 128, current value: 254                                                                                   
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
*udma6                                                                                
             Cycle time: min=120ns recommended=120ns                                                                                                     
        PIO: pio0 pio1 pio2 pio3 pio4                                                                                                                    
             Cycle time: no flow control=120ns  IORDY flow control=120ns                                                                                 
Commands/features:                                                                                                                                       
        Enabled Supported:                                                                                                                               
           *    SMART feature set                                                                                                                        
                Security Mode feature set                                                                                                                
           *    Power Management feature set                                                                                                             
           *    Write cache                                                                                                                              
           *    Look-ahead                                                                                                                               
           *    Host Protected Area feature set                                                                                                          
           *    WRITE_BUFFER command                                                                                                                     
           *    READ_BUFFER command                                                                                                                      
           *    NOP cmd                                                                                                                                  
           *    DOWNLOAD_MICROCODE                                                                                                                       
           *    Advanced Power Management feature set                                                                                                    
                Power-Up In Standby feature set                                                                                                          
           *    SET_FEATURES required to spinup after power up                                                                                           
                SET_MAX security extension                                                                                                               
                Automatic Acoustic Management feature set                                                                                                
           *    48-bit Address feature set                                                                                                               
           *    Device Configuration Overlay feature set                                                                                                 
           *    Mandatory FLUSH_CACHE                                                                                                                    
           *    FLUSH_CACHE_EXT                                                                                                                          
           *    SMART error logging                                                                                                                      
           *    SMART self-test                                                                                                                          
           *    General Purpose Logging feature set                                                                                                      
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT                                                                                                             
           *    64-bit World wide name                                                                                                                   
           *    IDLE_IMMEDIATE with UNLOAD                                                                                                               
           *    WRITE_UNCORRECTABLE_EXT command                                                                                                          
           *    Segmented DOWNLOAD_MICROCODE                                                                                                             
           *    Gen1 signaling speed (1.5Gb/s)                                                                                                           
           *    Gen2 signaling speed (3.0Gb/s)                                                                                                           
           *    Native Command Queueing (NCQ)                                                                                                            
           *    Host-initiated interface power management                                                                                                
           *    Phy event counters
           *    NCQ priority information
                Non-Zero buffer offsets in DMA Setup FIS
                DMA Setup Auto-Activate optimization
                Device-initiated interface power management
                In-order data delivery
           *    Software settings preservation
           *    SMART Command Transport (SCT) feature set
           *    SCT LBA Segment Access (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        100min for SECURITY ERASE UNIT. 102min for ENHANCED SECURITY 
ERASE UNIT.
Logical Unit WWN Device Identifier: 5000cca55ec98be1
        NAA             : 5
        IEEE OUI        : 000cca
        Unique ID       : 55ec98be1
Checksum: correct


## smartctl -a output:
=== START OF INFORMATION SECTION ===
Device Model:     Hitachi HTS543225L9A300
Serial Number:    090312FB2D06LJGP00RH   
Firmware Version: FBEOC40C               
User Capacity:    250,059,350,016 bytes  
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   8                                                     
ATA Standard is:  ATA-8-ACS revision 3f                                 
Local Time is:    Sun Dec 13 11:44:15 2009 CET                          
SMART support is: Available - device has SMART capability.              
SMART support is: Enabled                                               

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.              
                                        Auto Offline Data Collection: 
Disabled.
Self-test execution status:      (   0) The previous self-test routine 
completed
                                        without error or no self-test 
has ever  
                                        been run.                               
Total time to complete Offline                                                  
data collection:                 ( 645) seconds.                                
Offline data collection                                                         
capabilities:                    (0x5b) SMART execute Offline immediate.        
                                        Auto Offline data collection 
on/off support.
                                        Suspend Offline collection upon 
new         
                                        command.                                    
                                        Offline surface scan supported.             
                                        Self-test supported.                        
                                        No Conveyance Self-test 
supported.          
                                        Selective Self-test supported.              
SMART capabilities:            (0x0003) Saves SMART data before entering            
                                        power-saving mode.                          
                                        Supports SMART auto save timer.             
Error logging capability:        (0x01) Error logging supported.                    
                                        General Purpose Logging 
supported.          
Short self-test routine                                                             
recommended polling time:        (   2) minutes.                                    
Extended self-test routine                                                          
recommended polling time:        ( 102) minutes.                                    
SCT capabilities:              (0x003d) SCT Status supported.                       
                                        SCT Feature Control supported.              
                                        SCT Data Table supported.                   

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:  
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   062    Pre-fail  Always       
-       0        
  2 Throughput_Performance  0x0005   100   100   040    Pre-fail  
Offline      -       0        
  3 Spin_Up_Time            0x0007   253   253   033    Pre-fail  Always       
-       0        
  4 Start_Stop_Count        0x0012   100   100   000    Old_age   Always       
-       39       
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail  Always       
-       0        
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail  Always       
-       0        
  8 Seek_Time_Performance   0x0005   100   100   040    Pre-fail  
Offline      -       0        
  9 Power_On_Hours          0x0012   100   100   000    Old_age   Always       
-       48       
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail  Always       
-       0        
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       
-       39       
191 G-Sense_Error_Rate      0x000a   100   100   000    Old_age   Always       
-       0        
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       
-       5        
193 Load_Cycle_Count        0x0012   100   100   000    Old_age   Always       
-       3636
194 Temperature_Celsius     0x0002   152   152   000    Old_age   Always       
-       36 (Lifetime Min/Max 22/53)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       
-       0
197 Current_Pending_Sector  0x0022   100   100   000    Old_age   Always       
-       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age   Always       
-       0
223 Load_Retry_Count        0x000a   100   100   000    Old_age   Always       
-       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]


SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute 
delay.


## ps ax output while idle:
  PID TTY      STAT   TIME COMMAND 
    1 ?        Ss     0:00 init [5]  
    2 ?        S<     0:00 [kthreadd]
    3 ?        S<     0:00 [migration/0]
    4 ?        S<     0:01 [ksoftirqd/0]
    5 ?        S<     0:00 [watchdog/0] 
    9 ?        S<     0:00 [events/0]   
   11 ?        S<     0:00 [khelper]    
   12 ?        S<     0:00 [netns]      
   13 ?        S<     0:00 [async/mgr]  
   14 ?        S<     0:00 [kintegrityd/0]
   16 ?        S<     0:00 [kblockd/0]    
   18 ?        S<     0:00 [kacpid]       
   19 ?        S<     0:00 [kacpi_notify] 
   20 ?        S<     0:00 [kacpi_hotplug]
   21 ?        S<     0:00 [ata/0]        
   23 ?        S<     0:00 [ata_aux]      
   24 ?        S<     0:00 [ksuspend_usbd]
   25 ?        S<     0:00 [khubd]        
   26 ?        S<     0:00 [kseriod]      
   27 ?        S<     0:00 [kondemand/0]  
   29 ?        S      0:00 [khungtaskd]   
   30 ?        S      0:00 [pdflush]      
   31 ?        S      0:00 [pdflush]      
   32 ?        S<     0:00 [kswapd0]      
   33 ?        S<     0:00 [aio/0]        
   40 ?        S<     0:00 [scsi_eh_0]    
   41 ?        S<     0:01 [scsi_eh_1]    
   42 ?        S<     0:00 [scsi_eh_2]    
   43 ?        S<     0:00 [scsi_eh_3]    
   56 ?        S<     0:00 [kpsmoused]    
   57 ?        S<     0:00 [usbhid_resumer]
  291 ?        S<     0:00 [kjournald2]    
  388 ?        S<s    0:00 /sbin/udevd --daemon
  457 ?        S<     0:00 [hd-audio0]         
  459 ?        S<     0:00 [kmmcd]             
  466 ?        S<     0:00 [kmemstick]         
  687 ?        S<     0:00 [kstriped]          
  731 ?        S<     0:00 [kjournald2]        
  732 ?        S<     0:00 [kjournald2]        
 1086 ?        Ss     0:00 /sbin/acpid         
 1144 ?        Ss     0:02 /bin/dbus-daemon --system
 1176 ?        Sl     0:00 /sbin/rsyslogd -c 4 -f /etc/rsyslog.conf
 1241 ?        S<     0:00 [kconservative/0]                       
 1244 ?        Ss     0:00 /usr/sbin/hald --daemon=yes             
 1257 ?        Ssl    0:00 /usr/sbin/console-kit-daemon            
 1326 ?        S      0:00 hald-runner                             
 1339 ?        S      0:00 hald-addon-input: Listening on 
/dev/input/event0 /dev/input/event8 /dev/input/event5 /dev/input/event3 
/dev/input/event2 /dev/input/event4 /dev/input/event9                                                                                                                                           
 1354 ?        S      0:00 /usr/lib/hal/hald-addon-cpufreq                                                                                                       
 1355 ?        S      0:00 hald-addon-acpi: listening on acpid socket 
/var/run/acpid.socket                                                                      
 1369 ?        Ss     0:00 /usr/bin/kdm                                                                                                                          
 1373 ?        S      0:01 hald-addon-storage: polling /dev/sr0 (every 2 
sec)                                                                                    
 1384 tty7     Ss+    8:44 /usr/bin/Xorg -br -nolisten tcp :0 vt7 -auth 
/var/lib/xdm/authdir/authfiles/A:0-r6ZgCG                                                
 1406 ?        Ss     0:00 /sbin/rpcbind                                                                                                                         
 1413 ?        S<sl   0:00 /sbin/auditd -s disable                                                                                                               
 1415 ?        S<sl   0:00 /sbin/audispd                                                                                                                         
 1416 ?        S<     0:00 [kauditd]                                                                                                                             
 1419 ?        S<     0:00 [i915/0]                                                                                                                              
 1444 ?        S      0:00 /usr/lib/hal/hald-addon-generic-backlight                                                                                             
 1537 ?        Ss     0:00 /usr/sbin/cron                                                                                                                        
 1546 ?        Ss     0:00 avahi-daemon: running [mordor.local]                                                                                                  
 1600 ?        Ss     0:00 /usr/sbin/nscd                                                                                                                        
 1618 ?        S      0:00 -:0                                                                                                                                   
 1630 ?        Ss     0:00 /usr/sbin/sshd -o 
PidFile=/var/run/sshd.init.pid                                                                                      
 1633 ?        Ssl    0:01 /usr/sbin/NetworkManager                                                                                                              
 1638 ?        S      0:00 dbus-launch --autolaunch 
a9d72ddec698510152e118064b1be47a --binary-syntax --close-stderr                                              
 1641 ?        S      0:00 /usr/sbin/modem-manager                                                                                                               
 1645 ?        S      0:01 /usr/sbin/wpa_supplicant -c 
/etc/wpa_supplicant/wpa_supplicant.conf -u -f 
/var/log/wpa_supplicant.log                                 
 1647 ?        S      0:00 /usr/sbin/nm-system-settings --config 
/etc/NetworkManager/nm-system-settings.conf                                                     
 1648 ?        Ss     0:00 /bin/dbus-daemon --fork --print-pid 5 --
print-address 7 --session                                                                     
 1672 ?        S      0:00 /usr/sbin/smartd                                                                                                                      
 1678 ?        S      0:00 /usr/sbin/hddtemp -d -f /etc/hddtemp.db -p 
7634 /dev/sda                                                                              
 1698 tty1     Ss+    0:00 /sbin/mingetty --noclear tty1                                                                                                         
 1700 tty2     Ss+    0:00 /sbin/mingetty tty2                                                                                                                   
 1703 tty3     Ss+    0:00 /sbin/mingetty tty3                                                                                                                   
 1705 tty4     Ss+    0:00 /sbin/mingetty tty4                                                                                                                   
 1707 tty5     Ss+    0:00 /sbin/mingetty tty5                                                                                                                   
 1709 tty6     Ss+    0:00 /sbin/mingetty tty6                                                                                                                   
 2696 ?        Ss     0:00 /bin/sh /usr/bin/startkde                                                                                                             
 2765 ?        Ss     0:00 /usr/bin/ssh-agent /bin/bash 
/etc/X11/xinit/xinitrc                                                                                   
 2808 ?        S      0:00 dbus-launch --sh-syntax --exit-with-session                                                                                           
 2809 ?        Ss     0:00 /bin/dbus-daemon --fork --print-pid 5 --
print-address 7 --session                                                                     
 2817 ?        Ss     0:00 kdeinit4: kdeinit4 Running...                                                                                                         
 2818 ?        S      0:00 kdeinit4: klauncher [kdeinit] --fd=8                                                                                                  
 2820 ?        S      0:01 kdeinit4: kded4 [kdeinit]                                                                                                             
 2874 ?        S      0:00 kwrapper4 ksmserver                                                                                                                   
 2875 ?        Sl     0:00 kdeinit4: ksmserver [kdeinit]                                                                                                         
 2877 ?        S      3:12 kwin -session 
10147ccd3ec000126012357500000096690000_1260750232_889233                                                                
 2879 ?        S      0:00 kdeinit4: kglobalaccel [kdeinit]                                                                                                      
 2883 ?        Sl     0:16 kdeinit4: plasma-desktop [kdeinit]                                                                                                    
 2885 ?        Sl     0:02 /usr/bin/knotify4                                                                                                                     
 2892 ?        S      0:00 kdeinit4: kaccess [kdeinit]                                                                                                           
 2899 ?        Sl     0:01 kdeinit4: krunner [kdeinit]
 2902 ?        S      0:00 kdeinit4: nepomukserver [kdeinit]
 2913 ?        S      0:02 kdeinit4: kmix [kdeinit] -session 
10147ccd3ec000126012358500000096690010_1260750232_715395
 2914 ?        S      0:00 /usr/lib/polkit-gnome/polkit-gnome-
authentication-agent-1
 2918 ?        S      0:01 /usr/bin/knetworkmanager
 2922 ?        S      0:00 /usr/lib/polkit-1/polkitd
 4022 ?        S      0:00 kdeinit4: kio_file [kdeinit] file 
local:/tmp/ksocket-dan/klauncherMT2818.slave-socket local:/tmp/ksocket-
dan/kaffeineXF4013.slave-socket
26142 ?        S<     0:00 [migration/1]
26143 ?        S<     0:00 [ksoftirqd/1]
26144 ?        S<     0:00 [watchdog/1]
26145 ?        S<     0:00 [i915/1]
26146 ?        S<     0:00 [kconservative/1]
26147 ?        S<     0:00 [aio/1]
26148 ?        S<     0:00 [kondemand/1]
26149 ?        S<     0:00 [ata/1]
26150 ?        S<     0:00 [kblockd/1]
26151 ?        S<     0:00 [kintegrityd/1]
26152 ?        S<     0:00 [events/1]
26154 ?        S<     0:00 /sbin/udevd --daemon
26155 ?        S<     0:00 /sbin/udevd --daemon
26365 ?        Rl     0:01 kdeinit4: konsole [kdeinit]
26368 pts/1    Ss     0:00 /bin/bash
26378 pts/1    S      0:00 su root
26381 pts/1    S      0:00 bash
26484 pts/1    R+     0:00 ps ax


## mounted filesystem:
/dev/sda5 on / type ext4 (rw,acl,user_xattr,barrier=0)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
debugfs on /sys/kernel/debug type debugfs (rw)
udev on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/sda6 on /home type ext4 (rw,acl,user_xattr,barrier=0)
/dev/sda8 on /local type ext4 (rw,noatime,noacl,barrier=0)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
securityfs on /sys/kernel/security type securityfs (rw)


## uname -a:
Linux mordor 2.6.31.5-0.1-desktop #1 SMP PREEMPT 2009-10-26 15:49:03 
+0100 i686 i686 i386 GNU/Linux

openSUSE 11.2

related bug in novell bugzilla:
https://bugzilla.novell.com/show_bug.cgi?id=545024

Bye.
-- 
*** Linux user # 198661 ---_ ICQ 33500725 ***
    ***  Home  http://www.kailed.net  ***
        ***  Powered by openSUSE  ***

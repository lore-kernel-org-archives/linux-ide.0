From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: libata and sata_promise errors when using multiple disks on the same controller simultaneously
Date: Tue, 5 Jul 2005 12:12:15 -0600
Message-ID: <4789af9e050705111263cc6f7b@mail.gmail.com>
Reply-To: Jim Ramsay <jim.ramsay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:62948 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261939AbVGESMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Jul 2005 14:12:15 -0400
Received: by zproxy.gmail.com with SMTP id r28so515793nza
        for <linux-ide@vger.kernel.org>; Tue, 05 Jul 2005 11:12:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

I'm wondering if anyone can shed some light on the following error.

The software I am running is a 2.6.11 kernel from the CVS at
www.linux-mips.org, using the sata_promise driver.  I believe the
libata and sata_promise drivers are exactly the same as the vanilla
2.6.11 kernel.  I have also applied the following patch to the kernel:

http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-libata-dev1.patch.gz

The hardware I am using is a Promise Sata II 150 TX4 card.  I have 2
drives hooked up to it at a time.  Drive pairs I have tried:

- Seagate Baracuda 7200.7 120GB & Seagate Barracuda 7200.7 80GB
 
- Maxtor DiamondMax Plus 9 80GB & Western-Digital WD Cavlar SE 80GB

This seems to work fine for single drive operations, such as running
'badblocks -w' or fdisk, mkfs, mount, and file operations.  The error
only seems to pop up when I start using both drives simultaneously.

An example of the error with the seagate drives from dmesg (full dmesg
output below):

ata2: command timeout
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: called with no error (51)!
SCSI error : <1 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
    ASC=0xc ASCQ=0x2
end_request: I/O error, dev sda, sector 10702399

An example of the error with the Maxtor / WD drives:

ata1: command timeout                                                           
ata1: status=0x51 { DriveReady SeekComplete Error }                             
ata1: called with no error (51)!                                                
SCSI error : <0 0 0 0> return code = 0x8000002                                  
sda: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sda, sector 9316480

This error may occur multiple times on either disk, each time with a
different sector listed.

Way to cause the error #1:

Create a level-1 'md' softraid device.  The error will occur as it
rebuilds the array.  After it fails, remove and re-add the device that
had the error.  The error will occurr again, but it will list a
different sector as the problem sector.

Way to cause the error #2:

Run 'badblocks -w' on one drive.  Everything is fine until you start a
second 'badblocks -w' simultaneously on the other drive.  Suddenly the
errors start popping up.

Here is my dmesg output, with a couple comments about what I did at
the time.  Comments are of the format:
  << This is a comment >>

# dmesg                                                                         
Linux version 2.6.11 (ramsay@sw-63) (gcc version 3.3.6) #50 Tue Jul 5 09:26:50 C
ST 2005                                                                         
memsize: 128                                                                    
Memory size: 128MB                                                              
CPU revision is: 00002751                                                       
FPU revision is: 00002750                                                       
Found IT8712 Super IO                                                           
Determined physical RAM map:                                                    
 memory: 08000000 @ 00000000 (usable)                                           
On node 0 totalpages: 32768                                                     
  DMA zone: 32768 pages, LIFO batch:8                                           
  Normal zone: 0 pages, LIFO batch:1                                            
  HighMem zone: 0 pages, LIFO batch:1                                           
Built 1 zonelists                                                               
Kernel command line: root=/dev/nfs ip=dhcp console=ttyS0,115200                 
Primary instruction cache 16kB, physically tagged, 4-way, linesize 32 bytes.    
Primary data cache 16kB, 4-way, linesize 32 bytes.                              
Secondary cache size 256K, linesize 32 bytes.                                   
Synthesized TLB refill handler (23 instructions).                               
Synthesized TLB load handler fastpath (35 instructions).                        
Synthesized TLB store handler fastpath (35 instructions).                       
Synthesized TLB modify handler fastpath (34 instructions).                      
PID hash table entries: 1024 (order: 10, 16384 bytes)                           
calculating r4koff... 000493d7(299991)                                          
CPU frequency 599.98 MHz                                                        
Using 299.992 MHz high precision timer.                                         
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)                 
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)                   
Memory: 124160k/131072k available (3244k kernel code, 6760k reserved, 988k data,
 148k init, 0k highmem)                                                         
Calibrating delay loop... 598.01 BogoMIPS (lpj=299008)                          
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)                      
Checking for 'wait' instruction...  available.                                  
NET: Registered protocol family 16                                              
SCSI subsystem initialized                                                      
usbcore: registered new driver usbfs                                            
usbcore: registered new driver hub                                              
Returning IRQ 0 for 0000:00:00.0                                                
Returning IRQ 40 for 0000:00:10.0                                               
Returning IRQ 38 for 0000:00:11.0                                               
Returning IRQ 39 for 0000:00:12.0                                               
SGI XFS with no debug enabled                                                   
Generic RTC Driver v1.07                                                        
GPIO at 0x14013800 (irq = 20)                                                   
Serial: 8250/16550 driver $Revision: 1.2 $ 8 ports, IRQ sharing disabled        
ttyS0 at I/O 0x14011800 (irq = 23) is a 16550A                                  
ttyS1 at I/O 0x140003f8 (irq = 4) is a 16550A                                   
ttyS2 at I/O 0x14012000 (irq = 24) is a 16550A                                  
ttyS3 at I/O 0x14012800 (irq = 25) is a 16550A                                  
io scheduler noop registered                                                    
io scheduler anticipatory registered                                            
io scheduler deadline registered                                                
io scheduler cfq registered                                                     
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize           
loop: loaded (max 8 devices)                                                    
8139too Fast Ethernet driver 0.9.27                                             
eth0: RealTek RTL8139 at 0xad04b000, 00:e0:04:00:20:32, IRQ 39                  
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'                              
physmap flash device: 2000000 at 8000000                                        
CFI: Found no phys_mapped_flash device at location zero                         
Initializing USB Mass Storage driver...                                         
usbcore: registered new driver usb-storage                                      
USB Mass Storage support registered.                                            
mice: PS/2 mouse device common for all mice                                     
i2c /dev entries driver                                                         
Initialize ITE IIC adapter module                                               
 found device at 0x14014030 irq 0.                                              
ITE iic (i2c) algorithm module                                                  
NET: Registered protocol family 2                                               
IP: routing cache hash table of 1024 buckets, 8Kbytes                           
TCP established hash table entries: 8192 (order: 4, 65536 bytes)                
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)                       
TCP: Hash tables configured (established 8192 bind 8192)                        
NET: Registered protocol family 1                                               
NET: Registered protocol family 17                                              
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1                                 
Sending DHCP requests ., OK                                                     
IP-Config: Got DHCP answer from 192.107.131.180, my address is 192.107.131.213  
IP-Config: Complete:                                                            
      device=eth0, addr=192.107.131.213, mask=255.255.255.0, gw=192.107.131.1,  
     host=192.107.131.213, domain=sedsystems.ca, nis-domain=(none),             
     bootserver=192.107.131.180, rootserver=192.107.131.180, rootpath=/home/pmc/
new/rootfs                                                                      
Looking up port of RPC 100003/2 on 192.107.131.180                              
Looking up port of RPC 100005/1 on 192.107.131.180                              
VFS: Mounted root (nfs filesystem) readonly.                                    
Freeing unused kernel memory: 148k freed                                        
<< Here I ran 'modprobe sata_promise' >>
libata version 1.10 loaded.                                                     
sata_promise version 1.01                                                       
  Disabling parity checking for 0000:00:10.0                                    
ata1: SATA max UDMA/133 cmd 0xAD049200 ctl 0xAD049238 bmdma 0x0 irq 40          
ata2: SATA max UDMA/133 cmd 0xAD049280 ctl 0xAD0492B8 bmdma 0x0 irq 40          
ata3: SATA max UDMA/133 cmd 0xAD049300 ctl 0xAD049338 bmdma 0x0 irq 40          
ata4: SATA max UDMA/133 cmd 0xAD049380 ctl 0xAD0493B8 bmdma 0x0 irq 40          
ata1: dev 0 cfg 49:2f00 82:346b 83:5b01 84:4003 85:3469 86:1801 87:4003 88:007f 
ata1: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA                         
ata1: dev 0 configured for UDMA/133                                             
scsi0 : sata_promise                                                            
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:007f 
ata2: dev 0 ATA-7, max UDMA/133, 160086528 sectors: LBA                         
ata2: dev 0 configured for UDMA/133                                             
scsi1 : sata_promise                                                            
ata3: no device found (phy stat 00000000)                                       
scsi2 : sata_promise                                                            
ata4: no device found (phy stat 00000000)                                       
scsi3 : sata_promise                                                            
  Vendor: ATA       Model: WDC WD800JD-00JN  Rev: 05.0                          
  Type:   Direct-Access                      ANSI SCSI revision: 05             
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)                     
SCSI device sda: drive cache: write back                                        
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)                     
SCSI device sda: drive cache: write back                                        
 sda: unknown partition table                                                   
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0                         
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0             
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5                          
  Type:   Direct-Access                      ANSI SCSI revision: 05             
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)                     
SCSI device sdb: drive cache: write back                                        
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)                     
SCSI device sdb: drive cache: write back                                        
 sdb: unknown partition table                                                   
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0                         
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0             
  << Here I ran 'fdisk /dev/sda' to create a partition >>
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)                     
SCSI device sda: drive cache: write back                                        
 sda: sda1                                                                      
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)                     
SCSI device sda: drive cache: write back                                        
 sda: sda1                                                                      
  << Here I ran 'fdisk /dev/sdb' to create a partition >>
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)                     
SCSI device sdb: drive cache: write back                                        
 sdb: sdb1                                                                      
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)                     
SCSI device sdb: drive cache: write back                                        
 sdb: sdb1                                                                      
  << Here I ran 'modprobe raid1' to get 'md' ready to go >>
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27                            
md: raid1 personality registered as nr 3
  << Here I ran 'mdadm --create --auto=md --level=1 --raid-devices=2
/dev/md0 /dev/sd[ab]1' >>
md: bind<sda1>                                                                  
md: bind<sdb1>                                                                  
raid1: raid set md0 active with 2 out of 2 mirrors                              
.<6>md: syncing RAID array md0                                                  
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.                
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) f
or reconstruction.                                                              
md: using 128k window, over a total of 78148096 blocks.
  << About 30 seconds pased... >>
ata2: command timeout                                                           
ata2: status=0x51 { DriveReady SeekComplete Error }                             
ata2: called with no error (51)!                                                
SCSI error : <1 0 0 0> return code = 0x8000002                                  
sdb: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sdb, sector 182847                                  
raid1: Disk failure on sdb1, disabling device.                                  
        Operation continuing on 1 devices                                       
md: md0: sync done.                                                             
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1                                                    
 disk 1, wo:1, o:0, dev:sdb1                                                    
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1                                                    
.<6>md: syncing RAID array md0                                                  
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.                
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) f
or reconstruction.                                                              
md: using 128k window, over a total of 78148096 blocks.                         
md: md0: sync done.                                                             
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1
  << Here I ran 'mdadm --remove /dev/md0 /dev/sdb1' >>
md: unbind<sdb1>                                                                
md: export_rdev(sdb1)
  << Here I ran 'mdadm --add /dev/md0 /dev/sdb1' >>
md: bind<sdb1>                                                                  
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1                                                    
 disk 1, wo:1, o:1, dev:sdb1                                                    
.<6>md: syncing RAID array md0                                                  
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.                
md: using maximum available idle IO bandwith (but not more than 200000 KB/sec) f
or reconstruction.                                                              
md: using 128k window, over a total of 78148096 blocks.
  << About 30 seconds passed... >>
ata2: command timeout                                                           
ata2: status=0x51 { DriveReady SeekComplete Error }                             
ata2: called with no error (51)!                                                
SCSI error : <1 0 0 0> return code = 0x8000002                                  
sdb: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sdb, sector 633535                                  
raid1: Disk failure on sdb1, disabling device.                                  
        Operation continuing on 1 devices                                       
md: md0: sync done.                                                             
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1                                                    
 disk 1, wo:1, o:0, dev:sdb1                                                    
RAID1 conf printout:                                                            
 --- wd:1 rd:2                                                                  
 disk 0, wo:0, o:1, dev:sda1
  << Here I ran 'mdadm --stop /dev/md0' >>
md: md0 stopped.                                                                
md: unbind<sdb1>                                                                
md: export_rdev(sdb1)                                                           
md: unbind<sda1>                                                                
md: export_rdev(sda1)
  << Here I ran 'badblocks /dev/sdb', waited 5 minutes, then ran
'badblocks /dev/sda' >>
ata1: command timeout                                                           
ata1: status=0x51 { DriveReady SeekComplete Error }                             
ata1: called with no error (51)!                                                
SCSI error : <0 0 0 0> return code = 0x8000002                                  
sda: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sda, sector 1288576   
ata1: command timeout                                                           
ata1: status=0x51 { DriveReady SeekComplete Error }                             
ata1: called with no error (51)!                                                
SCSI error : <0 0 0 0> return code = 0x8000002                                  
sda: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sda, sector 1462384                                 
ata1: command timeout                                                           
ata1: status=0x51 { DriveReady SeekComplete Error }                             
ata1: called with no error (51)!                                                
SCSI error : <0 0 0 0> return code = 0x8000002                                  
sda: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sda, sector 1509984                          
  << Here I stopped and restarted 'badblocks /dev/sda' >>
ata2: command timeout                                                         
ata2: status=0x51 { DriveReady SeekComplete Error }                             
ata2: called with no error (51)!                                                
SCSI error : <1 0 0 0> return code = 0x8000002                                  
sdb: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sdb, sector 39386112     
ata1: command timeout                                                           
ata1: status=0x51 { DriveReady SeekComplete Error }                             
ata1: called with no error (51)!                                                
SCSI error : <0 0 0 0> return code = 0x8000002                                  
sda: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sda, sector 9316480                                 
ata2: command timeout                                                           
ata2: status=0x51 { DriveReady SeekComplete Error }                             
ata2: called with no error (51)!                                                
SCSI error : <1 0 0 0> return code = 0x8000002                                  
sdb: Current: sense key: Medium Error                                           
    Additional sense: Write error - auto reallocation failed                    
end_request: I/O error, dev sdb, sector 45459184
  << Here I stopped both programs and gave up >>

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"

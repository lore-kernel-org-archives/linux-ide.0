From: Jonathan Benson <airbatica@verizon.net>
Subject: Re: libata machine check on Alpha
Date: Tue, 04 Apr 2006 19:14:37 -0500
Message-ID: <0C1BACFD-F53D-4628-8FA4-AB9159322B25@verizon.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:60037 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750954AbWDEAOi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Apr 2006 20:14:38 -0400
Received: from [66.14.79.209] by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005))
 with ESMTPA id <0IX8007763CD1MR2@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Tue, 04 Apr 2006 19:14:38 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

My apologies for the length ahead of time. Per Tejun Heo's request, I  
have attached a dmesg with
#define ATA_DEBUG set in include/linux/libata.h

Looks like the dmesg buffer length ran past 16k, but I think the  
important parts are in there.

When I get home, I'll try Albert Lee's suggestion for enabling  
ATAPI_ENABLE_DMADIR


93C1080 ctl 0xFFFFFC88093C108A bmdma 0xFFFFFC88093C1000 irq 19
ata_host_add: ENTER
ata_port_start: prd alloc, virt fffffc001fcb2000, dma 9fcb2000
ata2: SATA max UDMA/100 cmd 0xFFFFFC88093C10C0 ctl 0xFFFFFC88093C10CA  
bmdma 0xFFFFFC88093C1008 irq 19
ata_host_add: ENTER
ata_port_start: prd alloc, virt fffffc001fcb6000, dma 9fcb6000
ata3: SATA max UDMA/100 cmd 0xFFFFFC88093C1280 ctl 0xFFFFFC88093C128A  
bmdma 0xFFFFFC88093C1200 irq 19
ata_host_add: ENTER
ata_port_start: prd alloc, virt fffffc001fcdc000, dma 9fcdc000
ata4: SATA max UDMA/100 cmd 0xFFFFFC88093C12C0 ctl 0xFFFFFC88093C12CA  
bmdma 0xFFFFFC88093C1208 irq 19
ata_device_add: probe begin
ata_device_add: ata1: probe begin
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 1, port 0
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 1, dev 0
ata_dev_identify: do ATA identify
ata_exec_command_mmio: ata1: cmd 0xEC
ata_pio_sector: data read
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c68 86:3a01  
87:4003 88:007f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7b09  84==0x4003
ata_dump_id: 88==0x007f  93==0x400b
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata1(0): applying bridge limits
ata_dev_identify: ENTER/EXIT (host 1, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_exec_command_mmio: ata1: cmd 0xEF
ata_host_intr: ata1: protocol 1 (dev_stat 0x50)
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40,  
offset=5
ata1: dev 0 configured for UDMA/100
ata_device_add: ata1: probe end
scsi0 : sata_sil
ata_device_add: ata2: probe begin
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 2, port 1
ata_bus_softreset: ata2: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 2, dev 0
ata_dev_identify: do ATA identify
ata_exec_command_mmio: ata2: cmd 0xEC
ata_pio_sector: data read
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7b09  84==0x4003
ata_dump_id: 88==0x007f  93==0x400b
ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata2(0): applying bridge limits
ata_dev_identify: ENTER/EXIT (host 2, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_exec_command_mmio: ata2: cmd 0xEF
ata_host_intr: ata2: protocol 1 (dev_stat 0x50)
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40,  
offset=5
ata2: dev 0 configured for UDMA/100
ata_device_add: ata2: probe end
scsi1 : sata_sil
ata_device_add: ata3: probe begin
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 3, port 2
ata_bus_softreset: ata3: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 3, dev 0
ata_dev_identify: do ATA identify
ata_exec_command_mmio: ata3: cmd 0xEC
ata_pio_sector: data read
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata_dump_id: 49==0x2f00  53==0x0007  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b  83==0x7b09  84==0x4003
ata_dump_id: 88==0x007f  93==0x400b
ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata_dev_identify: EXIT, drv_stat = 0x50
ata3(0): applying bridge limits
ata_dev_identify: ENTER/EXIT (host 3, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_exec_command_mmio: ata3: cmd 0xEF
ata_host_intr: ata3: protocol 1 (dev_stat 0x50)
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=5 xfer_shift=0, xfer_mode=0x45, base=0x40,  
offset=5
ata3: dev 0 configured for UDMA/100
ata_device_add: ata3: probe end
scsi2 : sata_sil
ata_device_add: ata4: probe begin
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata_bus_reset: ENTER, host 4, port 3
ata_bus_softreset: ata4: bus reset via SRST
ata_dev_classify: found ATAPI device by sig
ata_bus_reset: EXIT
ata_dev_identify: ENTER, host 4, dev 0
ata_dev_identify: do ATAPI identify
ata_exec_command_mmio: ata4: cmd 0xA1
ata_pio_sector: data read
ata4: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000  
87:0000 88:0007
ata_dump_id: 49==0x0b00  53==0x0006  63==0x0407  64==0x0003  75==0x0000
ata_dump_id: 80==0x0020  81==0x0000  82==0x0210  83==0x1000  84==0x0000
ata_dump_id: 88==0x0007  93==0x0000
ata4: dev 0 ATAPI, max UDMA/33
ata_dev_identify: EXIT, drv_stat = 0x50
ata_dev_identify: ENTER/EXIT (host 4, dev 1) -- nodev
ata_host_set_pio: base 0x8 xfer_mode 0xc mask 0x1f x 4
ata_dev_set_xfermode: set features - xfer mode
ata_exec_command_mmio: ata4: cmd 0xEF
ata_host_intr: ata4: protocol 1 (dev_stat 0x50)
ata_dev_set_xfermode: EXIT
ata_dev_set_mode: idx=2 xfer_shift=0, xfer_mode=0x42, base=0x40,  
offset=2
ata4: dev 0 configured for UDMA/33
ata_device_add: ata4: probe end
scsi3 : sata_sil
ata_device_add: probe begin
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 aa 85 87
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 aa 85 87
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 24 00 a8 a5 b4
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 00 00 00 60 00 a8 a5 b4
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (3:0,0,0) 12 00 00 00 24 00 00 00 24
ata_scsi_dump_cdb: CDB (3:0,0,0) 12 00 00 00 60 00 00 00 24
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata_scsi_dump_cdb: CDB (4:0,0,0) 12 00 00 00 24 00 8a b5 b5
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata4: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
CIA machine check: vector=0x670 pc=0xfffffc000053aff0 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000053aff0>]  ra = [<fffffc00005408a8>]  ps = 0007     
Not tainted
pc is at ata_altstatus+0x30/0x90
ra is at ata_qc_timeout+0x1b8/0x1d0
v0 = 000000000000004b  t0 = fffffc88093c12ca  t1 = fffffc88093c1208
t2 = fffffc8900000000  t3 = fffffc8900000000  t4 = 000000000000000b
t5 = 000000000000000a  t6 = fffffffffffff83c  t7 = fffffc001fcf0000
a0 = fffffc001fcdb418  a1 = 000000000000383c  a2 = ffffffffffffffff
a3 = 0000000000000001  a4 = 0000000000000001  a5 = 0000000000000001
t8 = 000000000000001f  t9 = 000000000009564a  t10= 0000000000000000
t11= 0000000000000000  pv = 0000000000000000  at = 0000000000000000
gp = fffffc0000788800  sp = fffffc001fcf3a98
ata4: command 0xa0 timeout, stat 0xf8 host_stat 0x0
ata4: translated ATA stat/err 0xf8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sda: drive cache: write back
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (1:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 3f 00 00 00 00 00 08
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (1:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sda: drive cache: write back
sda:<3>ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 00 00 00 00 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata1: cmd 0xC8
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
sda1
sd 0:0:0:0: Attached scsi disk sda
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sdb: drive cache: write back
ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (2:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 3f 00 00 00 00 00 08
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (2:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sdb: drive cache: write back
sdb:<3>ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 00 00 00 00 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata2: cmd 0xC8
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
sdb1
sd 1:0:0:0: Attached scsi disk sdb
ata_scsi_dump_cdb: CDB (3:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (3:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 3f 00 00 00 00 00 08
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sdc: drive cache: write back
ata_scsi_dump_cdb: CDB (3:0,0,0) 00 00 00 00 00 00 00 00 24
ata_scsi_dump_cdb: CDB (3:0,0,0) 25 00 00 00 00 00 00 00 00
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 3f 00 00 00 00 00 08
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 08
ata_scsi_dump_cdb: CDB (3:0,0,0) 5a 00 08 00 00 00 00 00 24
SCSI device sdc: drive cache: write back
sdc:<3>ata_scsi_dump_cdb: CDB (3:0,0,0) 28 00 00 00 00 00 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata3: cmd 0xC8
ata_host_intr: ata3: protocol 4 (dev_stat 0x50)
sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: measuring checksumming speed
    8regs     :   712.704 MB/sec
    32regs    :   950.272 MB/sec
    alpha     :  1089.536 MB/sec
    alpha prefetch:   950.272 MB/sec
raid5: using function: alpha (1089.536 MB/sec)
raid6: int64x1    236 MB/s
raid6: int64x2    368 MB/s
raid6: int64x4    492 MB/s
raid6: int64x8    332 MB/s
raid6: using algorithm int64x4 (492 MB/s)
md: raid6 personality registered for level 6
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 5, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: rd/c0d0p4: found reiserfs format "3.6" with standard journal
input: AT Translated Set 2 keyboard as /class/input/input0
ReiserFS: rd/c0d0p4: using ordered data mode
ReiserFS: rd/c0d0p4: journal params: device rd/c0d0p4, size 8192,  
journal first block 18, max trans len 1024, max batch 900, max commit  
age 30, max trans age 30
ReiserFS: rd/c0d0p4: checking transaction log (rd/c0d0p4)
ReiserFS: rd/c0d0p4: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
ata_scsi_dump_cdb: CDB (2:0,0,0) 12 01 80 00 fe 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 12 01 80 00 fe 00 00 00 00
ata_scsi_dump_cdb: CDB (3:0,0,0) 12 01 80 00 fe 00 00 00 00
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata1: cmd 0xC8
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata2: cmd 0xC8
ata_scsi_dump_cdb: CDB (3:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata3: cmd 0xC8
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
ata_host_intr: ata3: protocol 4 (dev_stat 0x50)
Adding 506024k swap on /dev/rd/c0d0p2.  Priority:-1 extents:1 across: 
506024k
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Setting latency timer of device 0000:00:07.0 to 64
e100: eth0: e100_probe: addr 0x93c0000, irq 17, MAC addr  
00:A0:C9:EF:DC:F9
md: md0 stopped.
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata1: cmd 0xC8
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata2: cmd 0xC8
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (3:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata3: cmd 0xC8
ata_host_intr: ata3: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 0e 4f f6 bf 00 00 10
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata1: cmd 0xC8
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
ata_scsi_dump_cdb: CDB (2:0,0,0) 28 00 0e 4f f6 bf 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata2: cmd 0xC8
ata_host_intr: ata2: protocol 4 (dev_stat 0x50)
md: bind<sdb1>
ata_scsi_dump_cdb: CDB (3:0,0,0) 28 00 0e 4f f6 bf 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata3: cmd 0xC8
ata_host_intr: ata3: protocol 4 (dev_stat 0x50)
md: bind<sdc1>
ata_scsi_dump_cdb: CDB (1:0,0,0) 28 00 0e 4f f6 bf 00 00 08
ata_sg_setup: 1 sg elements mapped
ata_exec_command_mmio: ata1: cmd 0xC8
ata_host_intr: ata1: protocol 4 (dev_stat 0x50)
md: bind<sda1>
raid5: device sda1 operational as raid disk 0
raid5: device sdc1 operational as raid disk 2
raid5: device sdb1 operational as raid disk 1
raid5: allocated 6282kB for md0
raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
RAID5 conf printout:
--- rd:3 wd:3 fd:0
disk 0, o:1, dev:sda1
disk 1, o:1, dev:sdb1
disk 2, o:1, dev:sdc1
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex


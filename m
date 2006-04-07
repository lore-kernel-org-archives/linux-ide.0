From: Jonathan Benson <airbatica@verizon.net>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 21:01:36 -0500
Message-ID: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64487 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932283AbWDGCBi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Apr 2006 22:01:38 -0400
Received: from [66.14.79.209] by vms046.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-4.02 (built Sep  9 2005))
 with ESMTPA id <0IXB001JWXMPTZ61@vms046.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Thu, 06 Apr 2006 21:01:38 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

 >Hi Jonathan,

 >Could you please give a try to the attached patch and post the  
content of word 62?
 >If word 62 + SiI 3611 looks good, we can turn on the DMADIR  
automatically. Thanks!

Per Albert's request, I've tested his patch to check the status of  
word 62 with the SiI 3611 bridge chip.  I used kernel version 2.6.17- 
rc1, as 2.6.16 reported fuzz when I applied the patch.  2.6.17-rc1  
reported an offset, but applied without any errors.  I've tested with  
the ATAPI_ENABLE_DMADIR workaround enabled, and disabled.  Debugging  
is disabled.  Looks like word 62 returns 0 as its value, dmesg with  
the relevant parts attached below.

If you need any more information, let me know and I'll be happy to  
provide it.

Jonathan Benson

Workaround Enabled

libata version 1.20 loaded.
sata_sil 0000:00:09.0: version 0.9
sata_sil 0000:00:09.0: cache line size not set.  Driver may not function
sata_sil 0000:00:09.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/100 cmd 0xFFFFFC88093C1080 ctl 0xFFFFFC88093C108A  
bmdma 0xFFFFFC88093C1000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFFC88093C10C0 ctl 0xFFFFFC88093C10CA  
bmdma 0xFFFFFC88093C1008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFFC88093C1280 ctl 0xFFFFFC88093C128A  
bmdma 0xFFFFFC88093C1200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFFC88093C12C0 ctl 0xFFFFFC88093C12CA  
bmdma 0xFFFFFC88093C1208 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c68 86:3a01  
87:4003 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata3(0): applying bridge limits
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000  
87:0000 88:0007
ata4: dev 0 word 62 [0]
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 0 word 62 [0]
ata4: dev 0 configured for UDMA/33
scsi3 : sata_sil
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: LITE-ON   Model: DVD SOHD-167T     Rev: 9S16
   Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 3:0:0:0: Attached scsi CD-ROM sr0
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0
sr 3:0:0:0: Attached scsi generic sg3 type 5

Workaround Disabled

libata version 1.20 loaded.
sata_sil 0000:00:09.0: version 0.9
sata_sil 0000:00:09.0: cache line size not set.  Driver may not function
sata_sil 0000:00:09.0: Applying R_ERR on DMA activate FIS errata fix
PCI: Setting latency timer of device 0000:00:09.0 to 64
ata1: SATA max UDMA/100 cmd 0xFFFFFC88093C1080 ctl 0xFFFFFC88093C108A  
bmdma 0xFFFFFC88093C1000 irq 19
ata2: SATA max UDMA/100 cmd 0xFFFFFC88093C10C0 ctl 0xFFFFFC88093C10CA  
bmdma 0xFFFFFC88093C1008 irq 19
ata3: SATA max UDMA/100 cmd 0xFFFFFC88093C1280 ctl 0xFFFFFC88093C128A  
bmdma 0xFFFFFC88093C1200 irq 19
ata4: SATA max UDMA/100 cmd 0xFFFFFC88093C12C0 ctl 0xFFFFFC88093C12CA  
bmdma 0xFFFFFC88093C1208 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c68 86:3a01  
87:4003 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01  
87:4003 88:007f
ata3: dev 0 ATA-7, max UDMA/133, 240121728 sectors: LBA
ata3(0): applying bridge limits
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000  
87:0000 88:0007
ata4: dev 0 word 62 [0]
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 0 word 62 [0]
ata4: dev 0 configured for UDMA/33
scsi3 : sata_sil
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
   Type:   Direct-Access                      ANSI SCSI revision: 05
CIA machine check: vector=0x670 pc=0xfffffc00005330e0 code=0x98
machine check type: processor detected hard error
pc = [<fffffc00005330e0>]  ra = [<fffffc000052d148>]  ps = 0007     
Not tainted
pc is at ata_altstatus+0x30/0x90
ra is at ata_qc_timeout+0x178/0x190
v0 = 0000000000000001  t0 = fffffc88093c12ca  t1 = fffffc88093c1208
t2 = fffffc8900000000  t3 = 0000000020010058  t4 = 0000000000000000
t5 = 00000000256d7116  t6 = 00000000fffb8c53  t7 = fffffc001fc20000
a0 = fffffc001fedec18  a1 = fffffc001fc23a48  a2 = 0000000000000318
a3 = fffffc0000610722  a4 = 0000000000000000  a5 = 0000000000000001
t8 = 000000000000001f  t9 = 000000000008efbe  t10= 0000000000000000
t11= 0000000000000000  pv = 0000000000000000  at = 0000000000000000
gp = fffffc000075f400  sp = fffffc001fc23a88
ata4: command 0xa0 timeout, stat 0xf8 host_stat 0x0
ata4: translated ATA stat/err 0xf8/00 to SCSI SK/ASC/ASCQ 0xb/47/00
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 240121728 512-byte hdwr sectors (122942 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 2:0:0:0: Attached scsi generic sg2 type 0


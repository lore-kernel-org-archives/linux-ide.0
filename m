From: kenneth topp <caught@prodigy.net>
Subject: via sata issues
Date: Tue, 20 Dec 2005 10:41:42 -0500 (EST)
Message-ID: <Pine.LNX.4.63.0512201030300.4462@static>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63]:8159 "EHLO
	pop-satin.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1751099AbVLTPlp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 10:41:45 -0500
Received: from user-12ldo29.cable.mindspring.com ([69.86.224.73] helo=bllue.dyndns.org)
	by pop-satin.atl.sa.earthlink.net with esmtp (Exim 3.36 #10)
	id 1EojcV-0004zM-00
	for linux-ide@vger.kernel.org; Tue, 20 Dec 2005 10:41:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by bllue.dyndns.org (Postfix) with ESMTP id 6E7818A784
	for <linux-ide@vger.kernel.org>; Tue, 20 Dec 2005 10:41:42 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


1) why use ataN instead of sdX in messages, it just makes it more 
difficult to track, especially since there are holes, and you cannot see 
the mapping in sysfs...

2) I've got tons of these messages, and I had some drive failures, but I 
cannot imagine theyt are all drive failures.  the system still hangs 
mostly on ata1/2 command time outs, which is why I'm going to move those 
disks from onboard via to another tx4.    Any advice?  I'm getting system 
hangs even for disks on the promise (I have to swear off the WDC HDD). 
Running: kernel-smp-2.6.14-1.1775_FC5 which is 2.6.15-rc6.  The newer 
kernel from davej panics on the via (getting a seial cable for the dump).

this is a sort | uniq of messages:

  kernel: ata3: status=0x50 { DriveReady SeekComplete }
  kernel: ata4: status=0x50 { DriveReady SeekComplete }
  kernel: ata4: status=0x52 { DriveReady SeekComplete Index }
  kernel: ata5: status=0x50 { DriveReady SeekComplete }
  kernel: ata6: status=0x50 { DriveReady SeekComplete }
  kernel: ata1: command 0x25 timeout, stat 0x50 host_stat 0x4
  kernel: ata1: command 0x35 timeout, stat 0x50 host_stat 0x4
  kernel: ata1: command 0xea timeout, stat 0x50 host_stat 0x0
  kernel: ata2: command 0x35 timeout, stat 0x50 host_stat 0x4
  kernel: ata3: command timeout
  kernel: ata4: command timeout
  kernel: ata5: command timeout
  kernel: ata6: command timeout

-- boot up messages -- 
SCSI subsystem initialized
libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) 
-> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.0, from 11 to 9
sata_via 0000:00:0f.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xBC02 bmdma 0xC800 irq 169
ata2: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xC808 irq 169
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 
88:407f
ata2: dev 0 ATA-6, max UDMA/133, 488397168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_via
   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
   Vendor: ATA       Model: WDC WD2500JD-00H  Rev: 08.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
sata_promise 0000:00:07.0: version 1.03
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 18 (level, low) -> IRQ 177
ata3: SATA max UDMA/133 cmd 0xF8862200 ctl 0xF8862238 bmdma 0x0 irq 177
ata4: SATA max UDMA/133 cmd 0xF8862280 ctl 0xF88622B8 bmdma 0x0 irq 177
ata5: SATA max UDMA/133 cmd 0xF8862300 ctl 0xF8862338 bmdma 0x0 irq 177
ata6: SATA max UDMA/133 cmd 0xF8862380 ctl 0xF88623B8 bmdma 0x0 irq 177
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_promise
ata4: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e8 86:3c02 87:4023 
88:203f
ata4: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_promise
ata5: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 
88:407f
ata5: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata5: dev 0 configured for UDMA/133
scsi4 : sata_promise
ata6: no device found (phy stat 00000000)
scsi5 : sata_promise
   Vendor: ATA       Model: WDC WD4000YR-01P  Rev: 01.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
   Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdd: drive cache: write back
  sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
   Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sde: drive cache: write back
SCSI device sde: 781422768 512-byte hdwr sectors (400088 MB)
SCSI device sde: drive cache: write back
  sde: sde1
sd 4:0:0:0: Attached scsi disk sde


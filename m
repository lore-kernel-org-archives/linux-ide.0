From: Jonathan Blake Benson <airbatica@verizon.net>
Subject: libata machine check on Alpha
Date: Mon, 03 Apr 2006 13:56:23 -0500
Message-ID: <1br232p2g092l611qrqvmvpuus2bqp7bc2@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:58821 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751044AbWDCS4l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 14:56:41 -0400
Received: from raptor ([71.123.243.201])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IX500HIFTXSNSE4@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 03 Apr 2006 13:56:16 -0500 (CDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I posted a couple of months ago regarding enabling libata.atapi on a
Digital Alpha 164LX, equipped with a Silicon Image 3114 controller.  I
decied to give kernel 2.6.16 (release, was previously using rc-1) a
shot, and it no longer longer panics.  I still have a Lite-ON DVD ROM
drive connected via a sil3611 bridge to port number 4, hoping that I
can avoid using the onboard CMD646.

No panic this time, though it appears to throw a machine check.  The
system continues all the way to multi-user, and the Maxtor drives are
usable.  Hope the attached dmesg helps.  Let me know if I can be of
any assitance.

Jonathan Benson


libata version 1.20 loaded.
sata_sil 0000:00:09.0: version 0.9
sata_sil 0000:00:09.0: cache line size not set.  Driver may not
function
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
ata4: dev 0 ATAPI, max UDMA/33
ata4: dev 0 configured for UDMA/33
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120P0    Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 05
CIA machine check: vector=0x670 pc=0xfffffc000053af50 code=0x98
machine check type: processor detected hard error
pc = [<fffffc000053af50>]  ra = [<fffffc0000540078>]  ps = 0007    Not
tainted
pc is at ata_altstatus+0x30/0x90
ra is at ata_qc_timeout+0x168/0x180
v0 = 0000000000000000  t0 = fffffc88093c12ca  t1 = fffffc88093c1208
t2 = fffffc8900000000  t3 = fffffc001fcdb418  t4 = 0000000000000000
t5 = 0000000017bfabb0  t6 = 0000000000000000  t7 = fffffc001fcf0000
a0 = fffffc001fcdb418  a1 = fffffc00006f5f38  a2 = fffffc001ff8b960
a3 = 0000000000000000  a4 = 0000000000000000  a5 = 0000000000000001
t8 = 000000000000001f  t9 = 000000000008bb52  t10= 0000000000000000
t11= 0000000000000000  pv = 0000000000000000  at = 0000000000000000
gp = fffffc0000788600  sp = fffffc001fcf3ad8
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


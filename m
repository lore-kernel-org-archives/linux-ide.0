From: Brett Russ <russb@emc.com>
Subject: how to enable write back cache on SATA drive?
Date: Tue, 31 Aug 2004 21:41:02 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <ch39av$75s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:59848 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266566AbUIABvq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2004 21:51:46 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C2KHp-0004Rp-00
	for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2004 03:51:45 +0200
Received: from pseudo-nat-129.isus.emc.com ([128.221.197.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2004 03:51:45 +0200
Received: from russb by pseudo-nat-129.isus.emc.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 01 Sep 2004 03:51:45 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

A coworker is trying to get this done to no avail.  He's tried hdparm, 
blktool, sginfo, and scsiinfo without luck--drives appear in write 
through cache mode and performance testing confirms.  I've not been 
directly involved but need to see progress.  I had the most hope for 
blktool but that failed with "BLKFLSBUF: Operation not supported"

Devices are Maxtor 250G connected to ICH6R in Enhanced non-AHCI mode 
using Garzik's 2.6.8.1 libata bk kernel tree (last sync'd ~20040820).

See results of some commands below...all snippets from emails to me.

===> blktool
linux:~/blktool-4 # ./blktool /dev/sda wcache on
   BLKFLSBUF: Operation not supported

===> scsiinfo
I can't seem to write the caching mode page back:

     # scsiinfo -cRX /dev/sda 1 1 0 0 0 0 0 0 0
     Unable to store Caching Page 08h
     18 00 00 00 18 00 00 00 70 00 05 00 00 00 00 06
     00 00 00 00 24 00 00 00 00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Thinking I was calling it incorrectly, I installed the xscsi rpm to use
the recommended scsi-config command, and that fails when it tries to
run this command:

     # /usr/bin/scsiinfo  -c -X -m /dev/sda
     Unable to read Caching Page 08h

The "-m" says to show modifiable fields, so perhaps none of the fields are
modifiable? It works when -m is not specified, since that's how I got the
string of values above:

     # /usr/bin/scsiinfo  -c -X  /dev/sda
     0 1 0 0 0 0 0 0 0

===> sginfo
sginfo behaviour similar to scsiinfo.

===> hdparm
hdparm reported it wasn't supported on scsi devices.


Following is relevant output from kernel boot:

libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE880 ctl 0xE802 bmdma 0xE080 irq 19
ata2: SATA max UDMA/133 cmd 0xE480 ctl 0xE402 bmdma 0xE088 irq 19
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7d09 84:4003 85:7c49 86:3c01 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 1 cfg 49:2f00 82:7c6b 83:7d09 84:4003 85:7c49 86:3c01 87:4003 
88:207f
ata1: dev 1 ATA, max UDMA/133, 490234752 sectors: lba48
ata1: dev 0 configured for UDMA/133
ata1: dev 1 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7d09 84:4003 85:7c49 86:3c01 87:4003 
88:207f
ata2: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 1 cfg 49:2f00 82:7c6b 83:7d09 84:4003 85:7c49 86:3c01 87:4003 
88:207f
ata2: dev 1 ATA, max UDMA/133, 490234752 sectors: lba48
ata2: dev 0 configured for UDMA/133
ata2: dev 1 configured for UDMA/133
scsi1 : ata_piix
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sda: drive cache: write through
  sda:
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdb: drive cache: write through
  sdb:
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdc: drive cache: write through
  sdc:
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 0
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
SCSI device sdd: drive cache: write through
  sdd:
Attached scsi disk sdd at scsi1, channel 0, id 1, lun 0



Thanks for pointers!
BR


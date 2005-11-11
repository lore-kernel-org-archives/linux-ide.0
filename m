From: Spencer Tuttle <rodeojones@fastmail.fm>
Subject: Re: Marvell MV88SX6041 SATA Driver PIO4 Mode Not DMA
Date: Fri, 11 Nov 2005 12:15:22 -0700
Message-ID: <4374EDCA.4080305@fastmail.fm>
References: <1131648518.26701.247242836@webmail.messagingengine.com> <437471D0.3090404@pobox.com> <20051111121447.GQ3699@suse.de> <4374A4AC.8010007@pobox.com> <20051111142905.GV3699@suse.de> <20051111143850.GX3699@suse.de> <4374D01B.9010706@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.contentwatch.com ([64.90.206.132]:43489 "EHLO
	mail.contentwatch.com") by vger.kernel.org with ESMTP
	id S1751077AbVKKTPD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 11 Nov 2005 14:15:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.contentwatch.com (Postfix) with ESMTP id 149774DAE3
	for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2005 12:15:02 -0700 (MST)
Received: from mail.contentwatch.com ([127.0.0.1])
 by localhost (mail.contentwatch.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26758-17 for <linux-ide@vger.kernel.org>;
 Fri, 11 Nov 2005 12:15:01 -0700 (MST)
Received: from [10.1.1.143] (vlxgw.contentwatch.com [64.90.206.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.contentwatch.com (Postfix) with ESMTP id D1A624DADA
	for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2005 12:15:00 -0700 (MST)
In-Reply-To: <4374D01B.9010706@fastmail.fm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Spencer Tuttle wrote:
>>>>>> Spencer Tuttle wrote:
>>>>>>
>>>>>>
>>>>>>> I have just compiled the new 2.6.14 kernel from the 
>>>>>>> gentoo-sources tree.
>>>>>>>
>>>>>>> I can access the drives just fine, but it seems really slow.  
>>>>>>> Here is
>>>>>>> the dmesg output when I load the kernel module
>>>>>>
>>>>>>
>>>>>> That's expected, since the driver in 2.6.14 only does PIO mode.
>>>>>>
>>>>>> Try 2.6.14-gitN which supports EDMA.
> 
> 
> 
> Ok I will seek this out and compile it.

Ok, i have it compiled and running, when I modprobe sata_mv i get
libata version 1.12 loaded.
sata_mv 0000:03:04.0: version 0.25
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 9 (level, low) -> IRQ 9
sata_mv 0000:03:04.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF89A2120 bmdma 0x0 irq 9
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF89A4120 bmdma 0x0 irq 9
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF89A6120 bmdma 0x0 irq 9
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF89A8120 bmdma 0x0 irq 9
ATA: abnormal status 0x80 on port 0xF89A211C
ATA: abnormal status 0x80 on port 0xF89A211C
ata1: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003 
88:203f
ata1: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_mv
ATA: abnormal status 0x80 on port 0xF89A411C
ATA: abnormal status 0x80 on port 0xF89A411C
ata2: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003 
88:203f
ata2: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_mv
ATA: abnormal status 0x80 on port 0xF89A611C
ATA: abnormal status 0x80 on port 0xF89A611C
ata3: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003 
88:203f
ata3: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_mv
ATA: abnormal status 0x80 on port 0xF89A811C
ATA: abnormal status 0x80 on port 0xF89A811C
ata4: dev 0 cfg 49:2f00 82:7869 83:7d09 84:4003 85:7869 86:3c01 87:4003 
88:203f
ata4: dev 0 ATA-7, max UDMA/100, 156301488 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_mv
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
   Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sdd: drive cache: write back
  sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd


Do I need to be concerned with the abnormal status? In the bios of my 
controller I have them setup as JBOD.

Does this driver support the RAID1 and RAID0 levels that are available 
on the controller?

Spencer


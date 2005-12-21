From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Re: Kernel or patch suggestions for DMA enables Marvell Driver
Date: Tue, 20 Dec 2005 18:35:23 -0800
Message-ID: <43A8BF6B.1090006@physics.ucsd.edu>
References: <43A86AF2.2080508@physics.ucsd.edu> <E1EooUH-0008VA-Vj@highlab.com> <43A87273.2060403@physics.ucsd.edu> <43A88218.1040205@physics.ucsd.edu> <E1Eoq94-00009u-SS@highlab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dsl093-032-179.snd1.dsl.speakeasy.net ([66.93.32.179]:29643
	"EHLO partlyharmless.local") by vger.kernel.org with ESMTP
	id S932262AbVLUCfZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Dec 2005 21:35:25 -0500
In-Reply-To: <E1Eoq94-00009u-SS@highlab.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Kuzminsky <seb@highlab.com>
Cc: linux-ide@vger.kernel.org

Sebastian Kuzminsky wrote:

>Terrence Martin <tmartin@physics.ucsd.edu> wrote:
>  
>
>>Nope it appears I have the same problem, the system hangs on reboot with 
>>rc5 as well as rc6.
>>    
>>
>
>Are you using Raids groups as PVs with LVM?  I'm seeing some hangs with
>that configuration in 2.6.15-rc5.  I'm still chasing after it, might be
>operator error...
>
>
>  
>
I am not use LVM but I do use raid 1 software.

Actually the machine eventually booted, it just took a while.

The errors I get with 2.6.15-r5 are

sata_mv 0000:03:04.0: version 0.5
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 56 (level, low) -> IRQ 185
sata_mv 0000:03:04.0: Applying B2 workarounds to unknown rev
sata_mv 0000:03:04.0: 32 slots 4 ports unknown mode IRQ via MSI
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF88A2120 bmdma 0x0 irq 185
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF88A4120 bmdma 0x0 irq 185
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF88A6120 bmdma 0x0 irq 185
ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF88A8120 bmdma 0x0 irq 185
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
ata7: no device found (phy stat 00000000)
scsi6 : sata_mv
ata8: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:407f
ata8: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
ata8: slow completion (cmd ef)
ata8: dev 0 configured for UDMA/133
scsi7 : sata_mv
ata9: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 
88:407f
ata9: dev 0 ATA-7, max UDMA/133, 390721968 sectors: LBA48
ata9: slow completion (cmd ef)
ata9: dev 0 configured for UDMA/133
scsi8 : sata_mv
  Vendor: ATA       Model: ST3200826AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdc: drive cache: write back
 sdc:<3>ata8: Entering mv_eng_timeout
mmio_base f8880000 ap f6b91314 qc f6b917f0 scsi_cmnd f6393e00 &cmnd f6393e44
ata8: status=0x50 { DriveReady SeekComplete }
ata8: error=0x01 { AddrMarkNotFound }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
 unknown partition table
sd 7:0:0:0: Attached scsi disk sdc
  Vendor: ATA       Model: ST3200826AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdd: drive cache: write back
 sdd:<3>ata8: Entering mv_eng_timeout
mmio_base f8880000 ap f6b91314 qc f6b917f0 scsi_cmnd f6b96080 &cmnd f6b960c4
ata9: Entering mv_eng_timeout
mmio_base f8880000 ap f679c314 qc f679c7f0 scsi_cmnd f6393e00 &cmnd f6393e44
ata8: status=0x50 { DriveReady SeekComplete }
ata8: error=0x01 { AddrMarkNotFound }
sdc: Current: sense key: No Sense
    Additional sense: No additional sense information
ata9: status=0x50 { DriveReady SeekComplete }
ata9: error=0x01 { AddrMarkNotFound }
sdd: Current: sense key: No Sense
    Additional sense: No additional sense information
 unknown partition table
sd 8:0:0:0: Attached scsi disk sdd

This is two seagate 200GB disks connected to two of the Marvell SATA 
ports on this Supermicro Xeon motherboard. The other two sata 
controllers are Intel which work fine.

The disks otherwise are brand new out of the box. I have never seen that 
error=0x01 { AddrMarkNotFound } before. Any ideas?

Terrence


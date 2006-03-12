From: Jeff Garzik <jeff@garzik.org>
Subject: current #upstream bug?
Date: Sun, 12 Mar 2006 10:42:42 -0500
Message-ID: <44144172.9040304@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090802060000060905050107"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:46535 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750840AbWCLPmq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 10:42:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090802060000060905050107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I see this in current #upstream, on an x86-64 SMP box with sata_nv and 
sata_mv:

> libata version 1.20 loaded.
> sata_nv 0000:00:07.0: version 0.8
> ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
> GSI 18 sharing vector 0xC1 and IRQ 18
> ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LSA0] -> GSI 23 (level, high) -> IRQ 193
> PCI: Setting latency timer of device 0000:00:07.0 to 64
> ata1: SATA max UDMA/133 cmd 0x28D0 ctl 0x28FA bmdma 0x28B0 irq 193
> ata2: SATA max UDMA/133 cmd 0x28D8 ctl 0x28FE bmdma 0x28B8 irq 193
> ata1: SATA link up 1.5 Gbps (SStatus 113)
> ata1: dev 0 cfg 49:2f00 82:3469 83:7f61 84:4003 85:3469 86:3e41 87:4003 88:407f
> ata1: dev 0 ATA-6, max UDMA/133, 488281250 sectors: LBA48
> nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
> ata1: dev 0 cfg 49:2f00 82:3469 83:7f61 84:4003 85:3469 86:3e41 87:4003 88:407f
> ata1: dev 0 configured for UDMA/133
> scsi2 : sata_nv
> ata2: SATA link down (SStatus 0)
> ata2: PIO error
> ata2: dev 0 failed to IDENTIFY (I/O error)
> scsi3 : sata_nv
>   Vendor: ATA       Model: WDC WD2500JD-75H  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
> SCSI device sda: 488281250 512-byte hdwr sectors (250000 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: drive cache: write back
>  sda:<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
>  sda1 sda2 sda3 sda4 <<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
>  sda5<4>nv_sata: Primary device added
> nv_sata: Primary device removed
> nv_sata: Secondary device added
> nv_sata: Secondary device removed
>  sda6 >
> sd 2:0:0:0: Attached scsi disk sda

The problem is that it complains about a PIO error and that a device 
failed IDENTIFY, when clearly (SStatus==0) there is no device present.

Full dmesg attached.  sata_mv stopped finding its ATA device, but I 
haven't even begun to look into that yet.

	Jeff



--------------090802060000060905050107
Content-Type: application/x-bzip;
 name="dmesg.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.txt.bz2"

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
hEZgjA==
--------------090802060000060905050107--

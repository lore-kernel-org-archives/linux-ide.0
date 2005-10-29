From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: assertion failure in libata-core
Date: Sat, 29 Oct 2005 13:27:35 -0400
Message-ID: <4363B107.2080209@pobox.com>
References: <4363ACDE.1060408@sara.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53637 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751158AbVJ2R1m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 29 Oct 2005 13:27:42 -0400
In-Reply-To: <4363ACDE.1060408@sara.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bram Stolk <bram@sara.nl>
Cc: linux-ide@vger.kernel.org

Bram Stolk wrote:
> Hello,
> 
> 
> I've been trying very hard to get my sata dvd burner to work.
> It is a plextor PX-716SA.
> 
> I tried the following kernels:
> 
> linux-2.6.14-rc5
> linux-2.6.14
> linux-2.6.14-rc5-mm1 (contains sil24 support)
> 
> All with the same result: assertion failure.
> 
> Assertion failed! qc->flags &
> ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3232
> 
> Now, my board has 2 sata interfaces: one from intel,
> and one from Sillicon Image.
> 
> If I use libata.atapi_enabled=1 and connect the drive to the
> intel sata, I get the assertion mentioned above.
> 
> If I connect the drive to the sil sata, it is not detected,
> and I get this error:
> sata_sil24 version 0.22
> ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 19 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:05:00.0 to 64
> ata5: SATA max UDMA/100 cmd 0xF8838000 ctl 0x0 bmdma 0x0 irq 19
> ata6: SATA max UDMA/100 cmd 0xF883A000 ctl 0x0 bmdma 0x0 irq 19
> ata5: no device found (phy stat 00000000)
> scsi4 : sata_sil24
> sata_sil24 ata6: error interrupt on port1
>   stat=0x80000001 irq=0xb60002 cmd_err=1 sstatus=0x113 serror=0x0
> sata_sil24 ata6: resetting controller...
> scsi5 : sata_sil24
> 
> How can I use this SATA DVD drive under linux on sata-ahci or sata-sil24?

Wait until we fix ATAPI, alas....

Your feedback here helps, though.

	Jeff




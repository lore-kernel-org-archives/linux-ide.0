From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.11-rc5: sata_sil shows drive twice...
Date: Mon, 28 Feb 2005 12:07:01 -0500
Message-ID: <42234FB5.30500@pobox.com>
References: <42234B1C.1080500@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34215 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261689AbVB1RHo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Feb 2005 12:07:44 -0500
In-Reply-To: <42234B1C.1080500@arcor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakashp@arcor.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Prakash Punnoor wrote:
> hi,
> 
> dmesg shows this:
> 
> 
> -- ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 18 (level, high) -> IRQ 18
> ata1: SATA max UDMA/100 cmd 0xF0806080 ctl 0xF080608A bmdma 0xF0806000 irq 18
> ata2: SATA max UDMA/100 cmd 0xF08060C0 ctl 0xF08060CA bmdma 0xF0806008 irq 18
> ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3c69 86:3c01 87:4003 88:20ff
> ata1: dev 0 ATA, max UDMA7, 156368016 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_sil
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_sil
>   Vendor: ATA       Model: SAMSUNG SP0812C   Rev: SU10
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4 < sda5 >
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> 
> 
> but I only have one physical drive attached. I don't seem to have problems
> though. Yesterday I got an oops, but I don't know whether it is connected. I
> copied it here just in case.
> 
> I don't know whether rc4 or earlier showed this beahaviour. I am sure that
> 2.6.10 didn't show it.

The double-output is normal for the SCSI layer, and has occurred on 
2.6.10 and previous.

The oops has nothing to do with SATA.

	Jeff



From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Booting from SATA disables IDE?
Date: Fri, 01 Apr 2005 12:04:01 -0500
Message-ID: <424D7F01.1060204@pobox.com>
References: <1921eeb1e202db77fdccb439f85ac532@axiros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18380 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262797AbVDAREU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Apr 2005 12:04:20 -0500
In-Reply-To: <1921eeb1e202db77fdccb439f85ac532@axiros.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Egger <de@axiros.com>
Cc: linux-ide@vger.kernel.org

Daniel Egger wrote:
> So everytime I boot from SATA I cannot use PATA anymore because
> the driver loads but doesn't work and vice versa (PATA before SATA)
> does work but only in theory because I have no system on the PATA
> drive and couldn't install one even if I wanted to (and I do not).

Well, sata_via never touches the VIA PATA side of things.  Probably a 
config or BIOS error, or similar.


> libata version 1.10 loaded.
> sata_via version 1.0
> ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 169
> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 169
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 
> 88:407f
> ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata1: dev 0 configured for UDMA/133
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_via
> elevator: using anticipatory as default io scheduler
>   Vendor: ATA       Model: Maxtor 6B200M0    Rev: BANC
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sda: drive cache: write back
>  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

Where's the IDE driver output?

	Jeff



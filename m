From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: Possible performance issue with sata_sil og Gigabyte i-Ram
Date: Tue, 23 Jan 2007 23:21:13 +0000
Message-ID: <20070123232113.0d6e8b4e@localhost.localdomain>
References: <20070123205301.GK1054@nixx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58768 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965582AbXAWXKG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Jan 2007 18:10:06 -0500
In-Reply-To: <20070123205301.GK1054@nixx.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?T2RkYmrDuHJu?= Kvalsund <oddbjorn@nixx.no>
Cc: linux-ide@vger.kernel.org

> Other people using this device report of read/write speeds constantly
> maxing out their SATA150 or PCI-bus. Is this my sil3114 being the
> bottleneck? Other devices on the PCI-bus? My general system (see link to

Possibly. 80Mbytes/sec seems to be about all you get from PCI bus with
many machines. Remember the SATA150, UDMA/133 and PCI bus limits are
largely theoretical, especially as most ATA controllers have significant
turn around time between commands and cannot queue.

> from what I can tell from dmesg (U)DMA should be enabled for this drive.
> I have tried enabling UDMA/133 for the controller (in sata_sil.c), giving this
> output on boot:

If you are getting 80Mb/sec then UDMA is enabled 8)

> libata version 2.00 loaded.
> sata_sil 0000:03:03.0: version 2.0
> ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 19 (level, low) -> IRQ 17
> ata1: SATA max UDMA/133 cmd 0xD081AC80 ctl 0xD081AC8A bmdma 0xD081AC00 irq 17
> ata2: SATA max UDMA/133 cmd 0xD081ACC0 ctl 0xD081ACCA bmdma 0xD081AC08 irq 17
> ata3: SATA max UDMA/133 cmd 0xD081AE80 ctl 0xD081AE8A bmdma 0xD081AE00 irq 17
> ata4: SATA max UDMA/133 cmd 0xD081AEC0 ctl 0xD081AECA bmdma 0xD081AE08 irq 17
> scsi0 : sata_sil
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: ATA-7, max UDMA/133, 1048319 sectors: LBA 
> ata1.00: ata1: dev 0 multi count 16
> ata1.00: Drive reports diagnostics failure. This may indicate a drive
> ata1.00: fault or invalid emulation. Contact drive vendor for information.
> ata1.00: configured for UDMA/133

This looks correct - the diagnostics failure appears to be an i-Ram
firmware bug so we warn about it only.

> I'm using the old piix-driver (not libata) for the IBM-disk, as I was
> having some problems getting it to work with the libata-driver. I might

What sort of problems ? I've got an iRAM here for debugging/testing
courtesy of a company using them and the one I have seems to pass all the
testing I've thrown at it.

Alan

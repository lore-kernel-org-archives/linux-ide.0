From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problems with SATA/AHCI with 'nosmp'  boot option
Date: Tue, 04 Oct 2005 06:31:42 -0400
Message-ID: <43425A0E.9050500@pobox.com>
References: <43312397.9080501@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:18086 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932222AbVJDKbq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 06:31:46 -0400
In-Reply-To: <43312397.9080501@reub.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-ide@vger.kernel.org

Reuben Farrelly wrote:
> Hi,
> 
> While trying to gather more info about a problem with the latest sky2.c 
> Gig ethernet driver hanging, I thought I'd boot my SMP built kernel (on 
> an SMP/HT machine) with the 'nosmp' boot option.
> 
> However when I did this, I could no longer boot the machine, because the 
> ahci
> driver reported timeouts when probing the drives attached to the SATA 
> ports, like this:
> 
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH6: IDE controller at PCI slot 0000:00:1f.1
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 73
> ICH6: chipset revision 3
> ICH6: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 81
> ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl 
> SATA mode
> ahci(0000:00:1f.2) flags: 64bit ncq led slum part
> ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 81
> ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 81
> ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 81
> ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 81
> ata1 is slow to respond, please be patient
> ata1 failed to respond (30 secs)
> scsi0 : ahci
> ata2 is slow to respond, please be patient
> ata2 failed to respond (30 secs)

Sounds like AHCI or MSI is broken.

	Jeff



From: Mark Lord <liml@rtr.ca>
Subject: Re: CompactFlash and HD unhappy together on the same IDE channel
Date: Sat, 18 Aug 2007 21:16:24 -0400
Message-ID: <46C799E8.8080407@rtr.ca>
References: <46C69913.1060505@g7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4156 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbXHSBQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Aug 2007 21:16:26 -0400
In-Reply-To: <46C69913.1060505@g7.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Malcolm Gillies <malcolm@g7.org>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Malcolm Gillies wrote:
> My PATA hard disk is crippled by CRC errors when it's on the same cable 
> as a 1GB SanDisk Ultra II CompactFlash card in CF to IDE adaptor. Any 
> ideas why?
> 
> By swapping around components, I've established that the problem is 
> unlikely due to the cable (which is 50cm long 80-wire), hard disk or 
> controller. When I swap to another, slower CF card (one that only 
> supports PIO rather than MWDMA), the error goes away and the hard disk 
> operates happily at UDMA/33.
..
> ata_piix 0000:00:1f.1: version 2.11
> PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
> ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, 
> low) -> IRQ
>  11
> PCI: Setting latency timer of device 0000:00:1f.1 to 64
> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: PATA max UDMA/100 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001ffa0 
> irq 14
> ata2: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001ffa8 
> irq 15
> ata1.00: CFA: SanDisk SDCFH-1024, HDX 4.07, max MWDMA2
> ata1.00: 2001888 sectors, multi 0: LBA
> ata1.01: ATA-7: SAMSUNG HD400LD, WQ100-14, max UDMA/100
> ata1.01: 781422768 sectors, multi 0: LBA48
> ata1.01: limited to UDMA/33 due to 40-wire cable
> ata1.00: configured for MWDMA2
> ata1.01: configured for UDMA/33
> ata2.00: ATAPI: LG CD-ROM CRN-8245B, 1.18, max UDMA/33
> ata2.00: configured for UDMA/33
..

Alan / Malcolm,

The fastest DMA speed reported for the CF is MWDMA2, which is considerably
slower than UDMA/33.  When two devices share a cable, normally both must be
limited to the speed of the slower device, which is MWDMA2 in this case.

Both devices report being capable of 120ns cycle times for DMA,
but UDMA double-clocks those cycles, something that is incompatible
with non-UDMA devices.

I don't think we can safely assume that UDMA can co-operate with non-UDMA
on the same cable.  In this case, it might be causing the CF device to falsely
detect control cycles.

???




From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: CF flash IDE failure to attach with 2.6.20+
Date: Mon, 18 Jun 2007 12:57:42 +0100
Message-ID: <20070618125742.28a0bc57@the-village.bc.nu>
References: <11172839.post@talk.nabble.com>
	<46766BD3.4040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32785 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752888AbXFRLwJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 07:52:09 -0400
In-Reply-To: <46766BD3.4040702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew_hall <andrew.a.hall@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Mon, 18 Jun 2007 20:26:11 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Andrew_hall wrote:
> > We have a series of machines that use CF as a boot media. Since upgrading to
> > 2.6.20 (tried .9-.14), system will boot (from the flash media) but then fail
> > to initialise the same media. Here is the dmesg from 2.6.20.14:
> > 
> > ata_piix 0000:00:1f.2: version 2.00ac7
> > ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
> > ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
> > PCI: Setting latency timer of device 0000:00:1f.2 to 64
> > ata1: SATA max UDMA/133 cmd 0xFA00 ctl 0xF902 bmdma 0xF600 irq 19
> > ata2: SATA max UDMA/133 cmd 0xF800 ctl 0xF702 bmdma 0xF608 irq 19
> > scsi0 : ata_piix
> > ata1.00: ATA-0, max MWDMA2, 990864 sectors: LBA
> > ata1.00: ata1: dev 0 multi count 0
> > ata1.00: applying bridge limits
> > ata1.00: configured for MWDMA2
> 
> For some reason, mwdma doesn't work in libata now.  I'm not sure why
> tho.  Alan, can you enlighten us?

No idea at all. All my hardware is still happy. 2.6.20 is an "old" kernel
however so it does predate the fixes you did for ata_piix mode setup ?


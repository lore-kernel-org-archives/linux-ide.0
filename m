From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Problems with SATA/AHCI with 'nosmp'  boot option
Date: Tue, 4 Oct 2005 19:04:01 -0700
Message-ID: <20051004190401.11bc4c7e.rdunlap@xenotime.net>
References: <43312397.9080501@reub.net>
	<43425A0E.9050500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:26820 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751163AbVJECEE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 22:04:04 -0400
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 19:04:03 -0700
In-Reply-To: <43425A0E.9050500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: reuben-lkml@reub.net, linux-ide@vger.kernel.org

On Tue, 04 Oct 2005 06:31:42 -0400 Jeff Garzik wrote:

> Reuben Farrelly wrote:
> > Hi,
> > 
> > While trying to gather more info about a problem with the latest sky2.c 
> > Gig ethernet driver hanging, I thought I'd boot my SMP built kernel (on 
> > an SMP/HT machine) with the 'nosmp' boot option.
> > 
> > However when I did this, I could no longer boot the machine, because the 
> > ahci
> > driver reported timeouts when probing the drives attached to the SATA 
> > ports, like this:
> > 
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > ICH6: IDE controller at PCI slot 0000:00:1f.1
> > ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 73
> > ICH6: chipset revision 3
> > ICH6: not 100% native mode: will probe irqs later
> >     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> > ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 81
> > ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl 
> > SATA mode
> > ahci(0000:00:1f.2) flags: 64bit ncq led slum part
> > ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 81
> > ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 81
> > ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 81
> > ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 81
> > ata1 is slow to respond, please be patient
> > ata1 failed to respond (30 secs)
> > scsi0 : ahci
> > ata2 is slow to respond, please be patient
> > ata2 failed to respond (30 secs)
> 
> Sounds like AHCI or MSI is broken.

Reuben, is AHCI trying to use MSI interrupts in this case?
(reported in /proc/interrupts)

If so, I've seen problems with Linux and MSI interrupts
when "nomsp" is used too.  Can you disable CONFIG_PCI_MSI
or is this a vendor kernel with it already enabled?

I posted a patch about 1 week ago that disables MSI interrupts
if "nomsp" or some similar options are used.  It's in Andrew's
-mm patch set afaik.  or I just put it at
  http://www.xenotime.net/linux/patches/msi_disable2.patch
if you care to try it.

---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law

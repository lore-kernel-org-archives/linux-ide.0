From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: Problems with SATA/AHCI with 'nosmp'  boot option
Date: Thu, 17 Nov 2005 23:07:01 -0800
Message-ID: <20051117230701.1684a43e.rdunlap@xenotime.net>
References: <43312397.9080501@reub.net>
	<43425A0E.9050500@pobox.com>
	<437D5E36.7000103@reub.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:35491 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932511AbVKRHGl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Nov 2005 02:06:41 -0500
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 17 Nov 2005 23:06:40 -0800
In-Reply-To: <437D5E36.7000103@reub.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, 18 Nov 2005 17:53:10 +1300 Reuben Farrelly wrote:

> Hi,
> 
> On 4/10/2005 11:31 p.m., Jeff Garzik wrote:
> > Reuben Farrelly wrote:
> >> Hi,
> >>
> >> While trying to gather more info about a problem with the latest 
> >> sky2.c Gig ethernet driver hanging, I thought I'd boot my SMP built 
> >> kernel (on an SMP/HT machine) with the 'nosmp' boot option.
> >>
> >> However when I did this, I could no longer boot the machine, because 
> >> the ahci
> >> driver reported timeouts when probing the drives attached to the SATA 
> >> ports, like this:
> >>
> >> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> >> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> >> idebus=xx
> >> ICH6: IDE controller at PCI slot 0000:00:1f.1
> >> ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 73
> >> ICH6: chipset revision 3
> >> ICH6: not 100% native mode: will probe irqs later
> >>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
> >>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> >> ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 81
> >> ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl 
> >> SATA mode
> >> ahci(0000:00:1f.2) flags: 64bit ncq led slum part
> >> ata1: SATA max UDMA/133 cmd 0xF8806D00 ctl 0x0 bmdma 0x0 irq 81
> >> ata2: SATA max UDMA/133 cmd 0xF8806D80 ctl 0x0 bmdma 0x0 irq 81
> >> ata3: SATA max UDMA/133 cmd 0xF8806E00 ctl 0x0 bmdma 0x0 irq 81
> >> ata4: SATA max UDMA/133 cmd 0xF8806E80 ctl 0x0 bmdma 0x0 irq 81
> >> ata1 is slow to respond, please be patient
> >> ata1 failed to respond (30 secs)
> >> scsi0 : ahci
> >> ata2 is slow to respond, please be patient
> >> ata2 failed to respond (30 secs)
> > 
> > Sounds like AHCI or MSI is broken.
> > 
> >     Jeff
> 
> I am still seeing this on 2.6.15-rc1-mm1.  I don't think we got any further 
> than to conclude it _might_ be AHCI or MSI.
> 
> What other information is required for me to be able to help someone look 
> closer and/or resolve this bug?
> 
> I have information about my system up at http://www.reub.net/kernel/ including 
> some system specifications and my .config.  (It's a lot easier to put it there 
> than attaching to every email)

Hi,

Jeff sent a message to lkml yesterday that he is seeing some
bad results with MSI interrupts:
  http://lkml.org/lkml/2005/11/17/4

Hopefully that will get some results, although not yet AFAIK.

---
~Randy

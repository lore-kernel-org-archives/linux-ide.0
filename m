From: Andi Kleen <ak@suse.de>
Subject: Re: via boot up hang during probing for no sata disks
Date: Wed, 16 Aug 2006 11:55:51 +0200
Message-ID: <20060816115551.4e2c6434.ak@suse.de>
References: <200608141533.35448.ak@suse.de>
	<20060816051228.GH6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50367 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751074AbWHPJzy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Aug 2006 05:55:54 -0400
In-Reply-To: <20060816051228.GH6371@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Wed, 16 Aug 2006 14:12:28 +0900
Tejun Heo <htejun@gmail.com> wrote:

> On Mon, Aug 14, 2006 at 03:33:35PM +0200, Andi Kleen wrote:
> > 
> > One of my test machines hangs at boot when booting 2.6.18rc4.
> > 
> > It seems to busy loop somewhere because the CPU fans spin up.
> > 
> > The machine doesn't have any disks (just two PATAPI CD-ROMs) 
> > and boots over the network.
> > 
> > The SATA drivers are compiled into the kernel (x86-64 defconfig)
> > 
> > Strangely it seems to only hang with the 64bit kernel -- when
> > I boot a 32bit kernel it usually comes up. It is likely some timing
> > issue because booting with initcall_debug also seems to make 
> > the problem go away. I verified with a printk and without initcall_debug
> > that the hang still happens in svia_init.
> 
> Hello, Andi.
> 
> Can you try the following patch?

This patch seems to fix the problem. Thanks.

I get now just

libata version 2.00 loaded.
sata_via 0000:00:0f.0: version 2.0
GSI 17 sharing vector 0xB9 and IRQ 17
IOAPIC[0]: Set PCI routing entry (1-20 -> 0xb9 -> IRQ 17 Mode:1 Active:1)
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
sata_via 0000:00:0f.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0x2C30 ctl 0x2C26 bmdma 0x2C00 irq 185
ata2: SATA max UDMA/133 cmd 0x2C28 ctl 0x2C22 bmdma 0x2C08 irq 185
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x2C37
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x2C2F
... continues booting without any noticeable delay...


-Andi

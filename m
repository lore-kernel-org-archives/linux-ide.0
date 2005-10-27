From: Jens Axboe <axboe@suse.de>
Subject: Re: Status of Marvell SATA driver (was Re: Trying latest sata_mv - and getting freeze)
Date: Thu, 27 Oct 2005 13:16:51 +0200
Message-ID: <20051027111650.GO4774@suse.de>
References: <435F8AFF.3030404@rol.ru> <435F9737.3050409@emc.com> <435FA5D8.2090406@rol.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:65388 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750718AbVJ0LQ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2005 07:16:28 -0400
Content-Disposition: inline
In-Reply-To: <435FA5D8.2090406@rol.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eugene Crosser <crosser@rol.ru>
Cc: Brett Russ <russb@emc.com>, linux-ide@vger.kernel.org, multiman@rol.ru, linux-kernel@vger.kernel.org

On Wed, Oct 26 2005, Eugene Crosser wrote:
> Brett, thanks for quick response.
> 
> >> My hardware is SMP Supermicro with 6 disks on
> >> Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
> >> and the sata_mv.c is version 0.25 dated 22 Oct 2005
> >>
> >> The thing works with "old" mvsata340 driver, but the "new" kernel with
> >> your driver freezes when it starts to probe disks.  Even Magic SysRq
> >> does not work.  The last lines I see on screen are like this:
> >>
> >> sata_mv version 0.25
> >> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
> >> sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
> >> ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
> >> ata2: .... <same things>            0xF8C24120 ...
> >> ...
> >> ata8: .... <same thing>             0xF8C38120 ...
> >> ATA: abnormal status 0x80 on port 0xF8C2211C
> >> ... <five more lines identical to the above>
> >> ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
> >>
> >> - and at this point it freezes hard.
> >> Any suggestions for me?  Any information I can collect to help
> >> troubleshooting?
> [...]
> > In the meantime, try turning off SMP and seeing if that makes a
> > difference.  There still might be a problem with the spinlocks and if so
> > it should go away in uniprocessor mode.
> 
> 'nosmp' makes no difference.

Booting with nosmp isn't enough, you need to compile the kernel with
CONFIG_SMP turned off. Otherwise the spinlocks will still be used and
could cause a hard hang.

-- 
Jens Axboe


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Wed, 19 Dec 2007 21:27:27 +0000
Message-ID: <20071219212727.4e0a47c3@the-village.bc.nu>
References: <fa.Fg53DJSEh/kZhf/uRCv9FYZsaSQ@ifi.uio.no>
	<fa.nPzIjJ2SchPb1LOa/dRWb/WyEZU@ifi.uio.no>
	<fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no>
	<fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no>
	<fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no>
	<fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no>
	<475C2C02.70001@shaw.ca>
	<alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org>
	<47698C39.6040902@pianoinflames.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50134 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753365AbXLSVgD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 16:36:03 -0500
In-Reply-To: <47698C39.6040902@pianoinflames.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marco Gatti <marco@pianoinflames.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Robert Hancock <hancockr@shaw.ca>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, Jeff Garzik <jgarzik@pobox.com>

> > AHCI is a pretty well tested driver, but 99%+ of all testers still tend to 
> > have less than 4GB of memory. So I do *not* believe that the highmem bits 
> > are all that well tested at all. 

Lab tested well and we pretty rapidly found the problems with non Intel
AHCI that had 4GB cases.

> dmesg, see bellow. But everything seems to work fine with it. No ext3 
> issues. On the other hand, the I/O is very low (4.2 MB/s) in comparison 
> to ahci. Maybe this can give us a hint for problems in ahci and 64-bit dma.

4.2MB/sec is abnormally low.


> scsi0 : ata_piix
> scsi1 : ata_piix
> ata1: SATA max UDMA/133 cmd 0x0000000000011cc0 ctl 0x0000000000011cb6 
> bmdma 0x0000000000011c60 irq 22
> ata2: SATA max UDMA/133 cmd 0x0000000000011cb8 ctl 0x0000000000011cb2 
> bmdma 0x0000000000011c68 irq 22

No devices. The messages here don't make any sense at all.

> Adding 2000084k swap on /dev/hdd2.  Priority:-1 extents:1 across:2000084k
> ADDRCONF(NETDEV_UP): eth0: link is not ready

And in fact you are using /dev/hda so you are not using the ata_piix
driver at all but something like the IDE legacy mode PIO driver


From: <Stuart_Hayes@Dell.com>
Subject: RE: [BUG] ide dma_timer_expiry, then hard lockup
Date: Mon, 18 Jun 2007 13:11:40 -0500
Message-ID: <DFEF91B22ED07447AB6AA4B237F913F9B18A05@ausx3mpc125.aus.amer.dell.com>
References: <20070618175713.GD5836@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:40682 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbXFRSLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:11:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070618175713.GD5836@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linas@austin.ibm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


I think reading the IDE status register clears the interrupt in the IDE
device, which might be causing the drive to think it's OK to generate
another interrupt.  This could either cause it to get stuck trying to
service an interrupt that is never getting cleared as you suggested, or
possibly when the next IRQ comes in the IDE IRQ handler gets stuck
waiting for a spinlock that the code you're looking at already owns...?

Perhaps a printk in the IDE IRQ handler would be informative?  It
wouldn't help you figure out how it got where it is, but it might help
you figure out why the system is hanging.

Stuart
 

-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Linas Vepstas
Sent: Monday, June 18, 2007 12:57 PM
To: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [BUG] ide dma_timer_expiry, then hard lockup



I've got a hard lockup in the ide subsystem, probably due to some irq
spew or something like that.

I've just bought a brand new Maxtor 320GB disk driver for the insane
price of $70 US to replace another failing drive. It works well under
light load; I was able to copy about 60GB to it. However, under heavy
load, such as reconstruction of an MD
RAID-1 array, it'll lock up the kernel.  Which means that my system
won't boot :-(

I'm running 2.6.21.1, although the problem seems to occur in 2.6.19 and
2.6.18 too; its been there a while; I vageuly remember similar problems
in 2.6.5 or 2.6.10.

I get an
"hdc: dma_timer_expiry: dma status == 0x21" 

and 10 seconds later,

"hdc: DMA Timeout error"

at which point the system is locked up hard.
Magic sysreq does not work at all. The hard drive activity light stays
fully lit.  Inserting printk's into the kernel, I find the hang to be in
a surprising place: 


ide_dma_timeout_retry() in ide-io.c 
  prints the "hdc: DMA Timeout error" then calls
  HWIF(drive)->ide_dma_end(drive);
    which returns, and then calls 
  hwif->INB(IDE_STATUS_REG) which is needed as an argument to
ide_error()

But this hangs! -- The INB never returns.
Now:  hwif->INB = ide_inb; in ide-iops.c

So putting a printk into ide_inb() shows that
the printk before the readb() is printed, and the
printk after the readb is not (!!)

I find this rather surpriseing, as I can't imagine how the
readb can fail. My current vague theory is that doing this
readb makes the hard drive go really nuts, and it probably
ties some interrupt line high, and so the linux kernel 
gets stuck trying to handle the irq flood. I just don't know
enough about the i386 architecture, or about interrupts, to 
prove or disprove this.

Background: this is on an old dual-cpu intel (coppermine??)
box; the controller is an HighPoint HPT366 on the motherboard.
This is an old parallel ATA (80-pin cable) setup.

I can get the system to boot by sneaking in an 
"hdparm -d0 /dev/hdc" early in the boot process, to turn off 
the use of DMA, but it seems that PIO is so slow, that it takes 
forever to get NFS started.

I can get it to boot, by unplugging /dev/hdc. Unfortunately,
given the RAID mirroring, the only usable copy of /, /usr is on
/dev/hda and te only usable copy of /home is on /dev/hdc, so 
I'm screwed ... 

Any suggestions, experiments, experimental patches, data gathering,
etc. is welcome. The sooner, the better... 

--linas



-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

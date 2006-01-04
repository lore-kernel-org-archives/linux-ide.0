From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 0/5] SATA/ACPI suspend/resume support
Date: Wed, 4 Jan 2006 11:42:22 -0800
Message-ID: <20060104114222.25182742.randy_d_dunlap@linux.intel.com>
References: <20051227153428.4eaad244.randy_d_dunlap@linux.intel.com>
	<87vex7rnfn.fsf@marrow.phys.tohoku.ac.jp>
	<20060103090847.43c2a00d.randy_d_dunlap@linux.intel.com>
	<20060103172649.GV2772@suse.de>
	<20060103190346.GY2772@suse.de>
	<20060103115712.5ac7ec47.randy_d_dunlap@linux.intel.com>
	<87wthh0wcf.fsf@marrow.phys.tohoku.ac.jp>
	<20060103164009.1c7418a7.randy_d_dunlap@linux.intel.com>
	<87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:34989 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S965271AbWADTlc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jan 2006 14:41:32 -0500
In-Reply-To: <87ek3o22z8.fsf@marrow.phys.tohoku.ac.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jae-hyeon Park <jhpark@tuhep.phys.tohoku.ac.jp>
Cc: axboe@suse.de, linux-ide@vger.kernel.org, jgarzik@pobox.com, chris@powerblogs.com


> > > > > > > > I tested kernel 2.6.15-rc7 with your patch applied on my ThinkPad X41.
> > > 
> > > My laptop is ThinkPad X41 Tablet, which has the same SATA controller
> > > as X41.
> > > 
> > > > > > > > While booting, it locks up after printing
> > > > > > > > 
> > > > > > > >     ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
> > > > > > > >     ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
> > > > > > > >     ata1(0): applying bridge limits
> > > > > > > >     ata1: dev 0 configured for UDMA/100
> > > > > > > > 
> > > > > > > > If I select CONFIG_SCSI_SATA_AHCI, then the kernel emits an oops and
> > > > > > > > panics during boot.
> > 
> > This certainly isn't the same failure that Jens saw.
> > 
> > Could there be any informative & helpful messages missing
> > before these messages, e.g., an assert() failure?
> 
> Let me copy as far as I can setting the video mode to 80x60.
> Scrolling back does not work after kernel panic.
> 
> highmem bounce pool size: 64 pages
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> acpi_bus-0201 [27] bus_set_power         : Device is not power manageable
> ahci: probe of 0000:00:1f.2 failed with error -12
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1810 irq 14
> ata1: dev 0 ATA-6, max UDMA/100, 117210240 sectors: LBA
> ata1(0): applying bridge limits
> ata1: dev 0 configured for UDMA/100
> do_drive_set_taskfiles: unexpected GTF length (-1040297340)
> scsi0: ata_piix
>   Vendor: ATA       Model: HTC426060G9AT00   Rev: 00P3
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
> ata2: disabling port
> scsi1 : ata_piix
> SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
> SCSI device sda: drive cache: write back
> SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
> SCSI device sda: drive cache: write back
>  sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000172

Jae-Hyeon,

If you are up to it, please enable libata verbose debugging
and then boot & cause this bug again and send me as much
output as you can collect.
Patch is below.

Thanks,
---
~Randy


From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Enable libata verbose debugging output.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---

 include/linux/libata.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp linux-2615-work/include/linux/libata.h~debugs linux-2615-work/include/linux/libata.h
--- linux-2615-work/include/linux/libata.h~debugs	2006-01-02 19:21:10.000000000 -0800
+++ linux-2615-work/include/linux/libata.h	2006-01-04 11:40:05.000000000 -0800
@@ -37,8 +37,8 @@
 /*
  * compile-time options
  */
-#undef ATA_DEBUG		/* debugging output */
-#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#define ATA_DEBUG		/* debugging output */
+#define ATA_VERBOSE_DEBUG	/* yet more debugging output */
 #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
 #undef ATA_NDEBUG		/* define to disable quick runtime checks */
 #undef ATA_ENABLE_PATA		/* define to enable PATA support in some

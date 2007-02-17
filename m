From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Fri, 16 Feb 2007 16:34:54 -0800
Message-ID: <20070217003454.GA25571@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:36025 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946339AbXBQAe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 19:34:59 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1H0YviC019136
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 19:34:57 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1H0YvOO521690
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 17:34:57 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1H0YuLR005226
	for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 17:34:56 -0700
Content-Disposition: inline
In-Reply-To: <20070130233735.GA7483@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

On Tue, Jan 30, 2007 at 03:37:36PM -0800, Gary Hade wrote:
> On Tue, Jan 30, 2007 at 04:32:34PM +0900, Tejun Heo wrote:
> > Hello, Gary.
> > 
> > Gary Hade wrote:
> > >>> If they verify your fix (ie,
> > >>> GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
> > >>> after SRST), I'll push similar patch upstream.
> > >> Thanks.  If you think that changes to increase the delays are
> > >> the way to go (at least until we can find a better solution)
> > >> I can provide patches.
> > > 
> > > Tejun, 
> > > I haven't heard anything from you on this so I'm including a delay
> > > increase patch against 2.6.20-rc6 for the 'ata-piix' case below.  
> > > I hope that you, Jeff, and others find this acceptable.
> > 
> > Sorry about being unresponsive.  The thing is that the change adds
> > unnecessary 2 secs of delay to a lot of other normal device-not-present
> > cases, so I was hesitant to ack the patch.  I'll give it more thoughts
> > (and respond timely this time :-)
> 
> Thanks!  My followup was untimely so we're even. :-)
> 
> Some of my random thoughts:
> There does appear to be this invalid assumption that 0xFF status 
> always implies device-not-present.  The status register access 
> restrictions in ATA/ATAPI-7 V1 5.14.2 include the statement "The 
> contents of this register, except for BSY, shall be ignored when 
> BSY is set to one." which the code does not honor.  There is apparently 
> past experience that 0xFF status implies device-not-present for some
> controllers (the odd clowns :) but I have no idea how common these are.
> We obviously can't get rid of the check but since we cannot clear
> the read-only status register and there appears to be no specification 
> dictated upper limit on how long it should take for a software reset to 
> complete it just seems like we need to wait long enough to support the 
> slowest known device which may be the GoVault.
> 
> > 
> > > With respect to the 'ahci' case w/2.6.20-rc6 the GoVault device is 
> > > useable following boot although the below messages are being logged 
> > > during initialization.  Please let me know if you have any thoughts 
> > > on this.  
> > >   scsi1 : ahci
> > >   ata2: softreset failed (port busy but CLO unavailable)
> > >   ata2: softreset failed, retrying in 5 secs
> > >   ata2: port is slow to respond, please be patient (Status 0x80)
> > >   ata2: port failed to respond (30 secs, Status 0x80)
> > >   ata2: COMRESET failed (device not ready)
> > >   ata2: hardreset failed, retrying in 5 secs
> > >   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >   ata2.00: ATAPI, max UDMA/66
> > >   ata2.00: configured for UDMA/66
> > 
> > The above should have been fixed in 2.6.20-rc6.  Please test it.  It was
> > caused by the ahci driver incorrectly clearing ahci CAP register and
> > fixed recently.
> 
> I'm clearly seeing this with 2.6.20-rc6 but unlike the ata-piix
> issue it does not appear to be dependent on the port to which the
> device is attached.  I've been playing around with this today and
> found that it could be solved by inserting a delay between the 
> ahci_stop_engine() call and BSY/DRQ check.
> 
> This change:
> --- linux-2.6.20-rc6/drivers/ata/ahci.c.orig	2007-01-30 11:01:20.000000000 -0800
> +++ linux-2.6.20-rc6/drivers/ata/ahci.c	2007-01-30 12:59:38.000000000 -0800
> @@ -804,6 +804,19 @@ static int ahci_softreset(struct ata_por
>  		goto fail_restart;
>  	}
> 
> +	{
> +		int delay;
> +		u8 stat;
> +		for (delay = 0; delay < 2000; delay+=100) {
> +			if (!(ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)))
> +				break;
> +			msleep(100);
> +			stat = ahci_check_status(ap);
> +			ata_port_printk(ap, KERN_INFO, "delay=%d BSY=%d DRQ=%d\n",
> +				delay, (stat & ATA_BUSY)?1:0, (stat & ATA_DRQ)?1:0);
> +		}
> +	}
> +
>  	/* check BUSY/DRQ, perform Command List Override if necessary */
>  	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
>  		rc = ahci_clo(ap);
> 
> Yielded this output both with and without the RDC inserted:
> scsi1 : ahci
> ata2: delay=0 BSY=1 DRQ=0
> ata2: delay=100 BSY=1 DRQ=0
> ata2: delay=200 BSY=1 DRQ=0
> ata2: delay=300 BSY=1 DRQ=0
> ata2: delay=400 BSY=1 DRQ=0
> ata2: delay=500 BSY=1 DRQ=0
> ata2: delay=600 BSY=1 DRQ=0
> ata2: delay=700 BSY=1 DRQ=0
> ata2: delay=800 BSY=1 DRQ=0
> ata2: delay=900 BSY=1 DRQ=0
> ata2: delay=1000 BSY=1 DRQ=0
> ata2: delay=1100 BSY=1 DRQ=0
> ata2: delay=1200 BSY=0 DRQ=0
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: ATAPI, max UDMA/66
> ata2.00: configured for UDMA/66
> 
> So it appears that we may also have a similar device slowness issue 
> with this driver.

Tejun,
I instrumented the code and found that for the SATA hard drive BSY was set 
just before the call to ahci_init_port() from ahci_port_start() and clear 
after the return from ahci_init_port().  For the GoVault BSY was still set 
after the return from ahci_init_port() and remained set for almost 2 seconds.

The below patch which gives BSY some extra time to clear repairs the problem.  
Unlike the extra delay for ata-piix needed by GoVault I believe this delay 
will only be seen for attached devices that need it.  Please let me know 
what you think.  

Thanks.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc


We encountered a problem where the BSY status bit is still 
set on entry to the 'ahci' error handler during initialization
of the Quantum GoVault when attached to an ICH6R/ICH6RW controller.
This caused a software reset failure due to failed BSY/DRQ check
forcing a hard reset with the following messages logged.
  ata1: softreset failed (port busy but CLO unavailable)
  ata1: softreset failed, retrying in 5 secs
  ata1: port is slow to respond, please be patient (Status 0x80)
  ata1: port failed to respond (30 secs, Status 0x80)
  ata1: COMRESET failed (device not ready)
  ata1: hardreset failed, retrying in 5 secs

It was taking almost 2 seconds for BSY to clear following the
return from ahci_init_port() in ahci_port_start() so this patch
gives BSY up to 3 seconds extra time to clear eliminating the
problem.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>

--- linux-2.6.20-rc7/drivers/ata/ahci.c.orig	2007-02-16 10:11:21.000000000 -0800
+++ linux-2.6.20-rc7/drivers/ata/ahci.c	2007-02-16 13:23:04.000000000 -0800
@@ -1423,6 +1423,8 @@ static int ahci_port_start(struct ata_po
 	void *mem;
 	dma_addr_t mem_dma;
 	int rc;
+	u8 status;
+	unsigned long timeout;
 
 	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
@@ -1477,6 +1479,17 @@ static int ahci_port_start(struct ata_po
 	/* initialize port */
 	ahci_init_port(port_mmio, hpriv->cap, pp->cmd_slot_dma, pp->rx_fis_dma);
 
+	status = ahci_check_status(ap);
+
+	/* for some devices we need to delay to allow BSY to clear */
+	if (status & ATA_BUSY) {
+		timeout = jiffies + 3*HZ;
+		while ((status & ATA_BUSY) && time_before(jiffies, timeout)) {
+			msleep(50);
+			status = ahci_check_status(ap);
+		}
+	}
+
 	return 0;
 }
 

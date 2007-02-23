From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Thu, 22 Feb 2007 16:32:00 -0800
Message-ID: <20070223003200.GA11004@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <20070217003454.GA25571@us.ibm.com> <45DC3DAA.2080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:42903 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbXBWAcD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Feb 2007 19:32:03 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1N0W2ou012970
	for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 19:32:03 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l1N0W2I3527962
	for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 17:32:02 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l1N0W11H029535
	for <linux-ide@vger.kernel.org>; Thu, 22 Feb 2007 17:32:02 -0700
Content-Disposition: inline
In-Reply-To: <45DC3DAA.2080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

On Wed, Feb 21, 2007 at 09:40:10PM +0900, Tejun Heo wrote:
> Hello, Gary.
> 
> Gary Hade wrote:
> > I instrumented the code and found that for the SATA hard drive BSY was set 
> > just before the call to ahci_init_port() from ahci_port_start() and clear 
> > after the return from ahci_init_port().  For the GoVault BSY was still set 
> > after the return from ahci_init_port() and remained set for almost 2 seconds.
> > 
> > The below patch which gives BSY some extra time to clear repairs the problem.  
> > Unlike the extra delay for ata-piix needed by GoVault I believe this delay 
> > will only be seen for attached devices that need it.  Please let me know 
> > what you think.
> 
> Can you post full dmesg without the patch?  And which controller are you
> using (lspci -nn please)?  How come it doesn't support CLO?
> 
> I don't think the patch is a good idea.  !BSY wait before reset is
> supposed to be done in ->prereset() if possible.  ahci skips that step
> because waiting for !BSY isn't reliable after hotplug and it often
> wastes 30secs for no good reason after an hotplug event.
> 
> Even if you need to add that specific shorter wait, the correct place
> would be ->prereset() not at the end of ->port_start().
> 
> I don't think fixing here and there for GoVault drive is a good idea.
> It's not gonna be tested widely and GoValut would end up working on some
> controllers while broken on others.  I think recently posted EH
> improvements and faster reset patches should help here.  The first reset
> will fail timely and all in all the drive should be detected in slightly
> over ten secs, which isn't that bad and actually is okay if parallel
> probing is implemented.
> 
> I dunno.  Maybe the correct thing to do is wait briefly for !BSY in
> std_prereset() when SKIP_D2H_BSY is set.

Tejun, I will be on vacation for a few days (returning 3/1) so I 
thought I would go ahead and provide the below patch before you have 
had a chance to review the information I sent you yesterday and actually 
confirm that it still looks like a viable solution.

Thanks,
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
in ahci_softreset() forcing a hard reset with the following 
messages logged.
  ata1: softreset failed (port busy but CLO unavailable)
  ata1: softreset failed, retrying in 5 secs
  ata1: port is slow to respond, please be patient (Status 0x80)
  ata1: port failed to respond (30 secs, Status 0x80)
  ata1: COMRESET failed (device not ready)
  ata1: hardreset failed, retrying in 5 secs

It was taking almost 2 seconds for BSY to clear following the
return from ahci_init_port() in ahci_port_start() so this patch
gives BSY up to 3 seconds extra time to clear during prereset
eliminating the problem.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>

--- linux-2.6.20-rc7/drivers/ata/libata-core.c.orig	2007-02-22 11:52:34.000000000 -0800
+++ linux-2.6.20-rc7/drivers/ata/libata-core.c	2007-02-22 14:59:44.000000000 -0800
@@ -2915,6 +2915,8 @@ int ata_std_prereset(struct ata_port *ap
 	struct ata_eh_context *ehc = &ap->eh_context;
 	const unsigned long *timing = sata_ehc_deb_timing(ehc);
 	int rc;
+	u8 status;
+	unsigned long timeout;
 
 	/* handle link resume & hotplug spinup */
 	if ((ehc->i.flags & ATA_EHI_RESUME_LINK) &&
@@ -2942,9 +2944,19 @@ int ata_std_prereset(struct ata_port *ap
 
 	/* Wait for !BSY if the controller can wait for the first D2H
 	 * Reg FIS and we don't know that no device is attached.
+	 * For other controllers a brief wait (up to 3 secs) may be
+	 * needed for some devices.
 	 */
 	if (!(ap->flags & ATA_FLAG_SKIP_D2H_BSY) && !ata_port_offline(ap))
 		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	else {
+		timeout = jiffies + 3*HZ;
+		status = ata_busy_wait(ap, ATA_BUSY, 300);
+		while ((status & ATA_BUSY) && time_before(jiffies, timeout)) {
+			msleep(50);
+			status = ata_busy_wait(ap, ATA_BUSY, 3);
+		}
+	}
 
 	return 0;
 }

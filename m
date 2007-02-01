From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 16:49:14 -0800
Message-ID: <20070201004914.GA2126@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <45C0731B.2030608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:53953 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161140AbXBAAtR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 19:49:17 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l110nHGC029028
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 19:49:17 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l110nHM2547806
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 17:49:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l110nG7K024817
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2007 17:49:16 -0700
Content-Disposition: inline
In-Reply-To: <45C0731B.2030608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

On Wed, Jan 31, 2007 at 07:44:43PM +0900, Tejun Heo wrote:
> Gary Hade wrote:
> > Some of my random thoughts:
> > There does appear to be this invalid assumption that 0xFF status 
> > always implies device-not-present.  The status register access 
> > restrictions in ATA/ATAPI-7 V1 5.14.2 include the statement "The 
> > contents of this register, except for BSY, shall be ignored when 
> > BSY is set to one." which the code does not honor.  There is apparently 
> > past experience that 0xFF status implies device-not-present for some
> > controllers (the odd clowns :) but I have no idea how common these are.
> 
> The 0xff is the value we get when there is no device present and the
> motherboard manufacturer forgot to pull down the ATA bus.  It's not very
> uncommon in cheap PATA world and, following the weird tradition, some
> SATA controllers choose to emulate 0xff if there is no device attached
> (link not established).  Not sure how many of them does it but intel's
> SATA chipset is one of them, so we're pretty much stuck with it.
> 
> ie. In many P/SATA setups, your patch would add 2 extra secs of waiting
> for empty ports.
> 
> > We obviously can't get rid of the check but since we cannot clear
> > the read-only status register and there appears to be no specification 
> > dictated upper limit on how long it should take for a software reset to 
> > complete it just seems like we need to wait long enough to support the 
> > slowest known device which may be the GoVault.
> 
> Agreed but still hesitant to ack the patch.  :-)
> 
> I'm gonna work on parallel probing for libata.  I think we can easily
> hide extra 2 secs of waiting with parallel probing.  It will take some
> time but that seems to be the 'right' thing to do especially considering
> the fact that 150ms sleep has been enough for gazillions of ATA devices
> during last decade except for this GoVault drive.
> 
> I'll leave this thread in my to-do folder and apply your patch after
> parallel probing is in place (optimistic ETA 1 month).  How does that sound?

Thanks.  Solution sounds great.  ETA may be an issue since 
we need to get the device enabled in a near-term release.
I'll let you know.

Polling version included below.  GoVault appeared to be the only 
currently known device that would benefit from polling so I 
didn't think the extra code was necessary.  After considering
Jeff's comment, it makes sense prepare for the possibility 
of those future slow but not quite so slow devices.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc


Controllers such as the ICH6R/ICH6RW may set the status to 0xFF 
when software reset is initiated even when the device is present.
Since some removable media devices can take longer than 150ms 
to complete the 0xFF status check can fail even when the device 
is present.  For example, a software reset for the Quantum GoVault 
removable hard can take as long as 2 seconds to complete.

This patch eliminates incorrect software reset failures for 
slower than normal software reset responders by adding an 
additional 2 second wait when a 0xFF status is detected following
the current 150ms wait.

Signed-off-by: Gary Hade <garyhade@us.ibm.com>

--- linux-2.6.20-rc6/drivers/ata/libata-core.c.orig	2007-01-24 18:19:28.000000000 -0800
+++ linux-2.6.20-rc6/drivers/ata/libata-core.c	2007-01-31 12:00:52.000000000 -0800
@@ -2653,6 +2653,8 @@ static unsigned int ata_bus_softreset(st
 				      unsigned int devmask)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 status;
+	unsigned long timeout;
 
 	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
 
@@ -2683,11 +2685,22 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
+	/* For those controllers where the status could start out at
+	 * 0xFF even though the device is present we wait up to 2 seconds
+	 * longer for slower removable media devices to respond.
+	 */
+	status = ata_check_status(ap);
+	timeout = jiffies + 2*HZ;
+	while (status == 0xFF && time_before(jiffies, timeout)) {
+		msleep(50);
+		status = ata_check_status(ap);
+	}
+
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF)
+	if (status == 0xFF)
 		return 0;
 
 	ata_bus_post_reset(ap, devmask);

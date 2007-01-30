From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Tue, 30 Jan 2007 15:37:36 -0800
Message-ID: <20070130233735.GA7483@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:54617 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbXA3Xhj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 18:37:39 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l0UNcGGa000457
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 18:38:16 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0UNbchp234000
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 18:37:38 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0UNbb4U010642
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 18:37:38 -0500
Content-Disposition: inline
In-Reply-To: <45BEF492.9000000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

On Tue, Jan 30, 2007 at 04:32:34PM +0900, Tejun Heo wrote:
> Hello, Gary.
> 
> Gary Hade wrote:
> >>> If they verify your fix (ie,
> >>> GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
> >>> after SRST), I'll push similar patch upstream.
> >> Thanks.  If you think that changes to increase the delays are
> >> the way to go (at least until we can find a better solution)
> >> I can provide patches.
> > 
> > Tejun, 
> > I haven't heard anything from you on this so I'm including a delay
> > increase patch against 2.6.20-rc6 for the 'ata-piix' case below.  
> > I hope that you, Jeff, and others find this acceptable.
> 
> Sorry about being unresponsive.  The thing is that the change adds
> unnecessary 2 secs of delay to a lot of other normal device-not-present
> cases, so I was hesitant to ack the patch.  I'll give it more thoughts
> (and respond timely this time :-)

Thanks!  My followup was untimely so we're even. :-)

Some of my random thoughts:
There does appear to be this invalid assumption that 0xFF status 
always implies device-not-present.  The status register access 
restrictions in ATA/ATAPI-7 V1 5.14.2 include the statement "The 
contents of this register, except for BSY, shall be ignored when 
BSY is set to one." which the code does not honor.  There is apparently 
past experience that 0xFF status implies device-not-present for some
controllers (the odd clowns :) but I have no idea how common these are.
We obviously can't get rid of the check but since we cannot clear
the read-only status register and there appears to be no specification 
dictated upper limit on how long it should take for a software reset to 
complete it just seems like we need to wait long enough to support the 
slowest known device which may be the GoVault.

> 
> > With respect to the 'ahci' case w/2.6.20-rc6 the GoVault device is 
> > useable following boot although the below messages are being logged 
> > during initialization.  Please let me know if you have any thoughts 
> > on this.  
> >   scsi1 : ahci
> >   ata2: softreset failed (port busy but CLO unavailable)
> >   ata2: softreset failed, retrying in 5 secs
> >   ata2: port is slow to respond, please be patient (Status 0x80)
> >   ata2: port failed to respond (30 secs, Status 0x80)
> >   ata2: COMRESET failed (device not ready)
> >   ata2: hardreset failed, retrying in 5 secs
> >   ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >   ata2.00: ATAPI, max UDMA/66
> >   ata2.00: configured for UDMA/66
> 
> The above should have been fixed in 2.6.20-rc6.  Please test it.  It was
> caused by the ahci driver incorrectly clearing ahci CAP register and
> fixed recently.

I'm clearly seeing this with 2.6.20-rc6 but unlike the ata-piix
issue it does not appear to be dependent on the port to which the
device is attached.  I've been playing around with this today and
found that it could be solved by inserting a delay between the 
ahci_stop_engine() call and BSY/DRQ check.

This change:
--- linux-2.6.20-rc6/drivers/ata/ahci.c.orig	2007-01-30 11:01:20.000000000 -0800
+++ linux-2.6.20-rc6/drivers/ata/ahci.c	2007-01-30 12:59:38.000000000 -0800
@@ -804,6 +804,19 @@ static int ahci_softreset(struct ata_por
 		goto fail_restart;
 	}
 
+	{
+		int delay;
+		u8 stat;
+		for (delay = 0; delay < 2000; delay+=100) {
+			if (!(ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)))
+				break;
+			msleep(100);
+			stat = ahci_check_status(ap);
+			ata_port_printk(ap, KERN_INFO, "delay=%d BSY=%d DRQ=%d\n",
+				delay, (stat & ATA_BUSY)?1:0, (stat & ATA_DRQ)?1:0);
+		}
+	}
+
 	/* check BUSY/DRQ, perform Command List Override if necessary */
 	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
 		rc = ahci_clo(ap);

Yielded this output both with and without the RDC inserted:
scsi1 : ahci
ata2: delay=0 BSY=1 DRQ=0
ata2: delay=100 BSY=1 DRQ=0
ata2: delay=200 BSY=1 DRQ=0
ata2: delay=300 BSY=1 DRQ=0
ata2: delay=400 BSY=1 DRQ=0
ata2: delay=500 BSY=1 DRQ=0
ata2: delay=600 BSY=1 DRQ=0
ata2: delay=700 BSY=1 DRQ=0
ata2: delay=800 BSY=1 DRQ=0
ata2: delay=900 BSY=1 DRQ=0
ata2: delay=1000 BSY=1 DRQ=0
ata2: delay=1100 BSY=1 DRQ=0
ata2: delay=1200 BSY=0 DRQ=0
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI, max UDMA/66
ata2.00: configured for UDMA/66

So it appears that we may also have a similar device slowness issue 
with this driver.

Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc


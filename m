From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Mon, 29 Jan 2007 17:55:07 -0800
Message-ID: <20070130015507.GA30069@us.ibm.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35624 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbXA3BzK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Jan 2007 20:55:10 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0U1tlQR016909
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 20:55:47 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0U1t9k4304844
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 20:55:09 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0U1t8SW014662
	for <linux-ide@vger.kernel.org>; Mon, 29 Jan 2007 20:55:09 -0500
Content-Disposition: inline
In-Reply-To: <20061221171035.GC6171@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

On Thu, Dec 21, 2006 at 09:10:35AM -0800, Gary Hade wrote:
> On Wed, Dec 20, 2006 at 12:53:57PM +0900, Tejun Heo wrote:
> > Howdy,
> >
> > Gary Hade wrote:
> > > I noticed that Tejun recently provided a "libata: handle 0xff status
> > > properly" patch that is now in mainline that improves this code
> > >   re: http://marc.theaimsgroup.com/?l=linux-ide&m=116038642105802&w=2
> > > but I found that the check still failed but more silently and with no
> > > retries.
> > >
> > > I decided to try increasing the delay that preceeds the above
> > > check [ msleep(150); ] and found that a change from 150ms to
> > > 1000ms caused the problem to disappear.
> >
> > Aieeee, 150ms not enough for the device to send the first FIS after SRST?
> 
> Yea, it appears so. :)
> 
> GoVault access via 'ahci' is also fails in some cable placement
> configurations with:
>   kernel: scsi1 : ahci
>   kernel: ata2: softreset failed (1st FIS failed)
>   kernel: ata2: softreset failed, retrying in 5 secs
>   kernel: ata2: port is slow to respond, please be patient
>   kernel: ata2: port failed to respond (30 secs)
>   kernel: ata2: COMRESET failed (device not ready)
>   kernel: ata2: hardreset failed, retrying in 5 secs
>   kernel: ata2: port is slow to respond, please be patient
>   kernel: ata2: port failed to respond (30 secs)
>   kdump: kexec: failed to load kdump kernel
>   kernel: ata2: COMRESET failed (device not ready)
>   kernel: ata2: reset failed, giving up
> 
> This problem also disappears after reversing ports to which
> the hard drive and GoVault cables are connected.
> 
> The following timeout increase appears to correct the 'ahci' problem:
> 
> --- ./linux-2.6.18.i386/drivers/scsi/ahci.c.orig	2006-12-19 09:07:58.000000000 -0800
> +++ ./linux-2.6.18.i386/drivers/scsi/ahci.c	2006-12-19 13:30:29.000000000 -0800
> @@ -788,7 +788,7 @@ static int ahci_softreset(struct ata_por
> 
>  	writel(1, port_mmio + PORT_CMD_ISSUE);
> 
> -	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 500);
> +	tmp = ata_wait_register(port_mmio + PORT_CMD_ISSUE, 0x1, 0x1, 1, 2500);
>  	if (tmp & 0x1) {
>  		rc = -EIO;
>  		reason = "1st FIS failed";
> 
> 1000ms, 1500ms, 1750ms, and 1900ms didn't work.  2000ms worked so
> 2500ms includes some extra to be safe.  This experience seems to
> be more representative of the 1 to 2 second time (with RDC present)
> mentioned by Quantum (see below) than the 'ata_piix' 600-700ms
> experience.
> 
> >
> > > I then replaced the msleep(150); with:
> > >     {
> > >         int i, ms = 5;
> > >         msleep(ms);
> > >         ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
> > >                                         ms, ata_check_status(ap));
> > >         for (i = 1; i <= 20; i++) {
> > >             ms += 50;
> > >             msleep(50);
> > >             ata_port_printk(ap, KERN_INFO, "status @ %d ms: 0x%x\n",
> > >                                             ms, ata_check_status(ap));
> > >         }
> > >     }
> > >
> > > Output for two cable placement configurations (0xFF check failure
> > > and 0xFF check success) are included below.  Note that there are
> > > cable placement configurations for both the hard drive and
> > > GoVault where the initial status is 0xff. i.e. both transition
> > > from 0xff to 0x7f when BSY bit is cleared but it is taking MUCH
> > > longer for the GoVault (600-700ms for GoVault and <5ms for
> > > hard drive).  It does not appear that the 0xff starting status
> > > is device specific.
> > >
> > > So, it appears that we have a situation with this SATA controller
> > > where a 0xFF status is not an accurate indication that there is
> > > no device.
> > >
> > > Although the 150ms to 1000ms delay increase works for the GoVault
> > > device I am not sure if it is the best long term fix for the problem.
> >
> > I would be surprised if Kovid's sda not detected case is caused by this.
> >  For GoVault (that's SATAPI right?), yeah, maybe.
> 
> Yes, the GoVault is an ATAPI device.
> 
> > For an ATA disk, no way (hopefully).
> 
> Yes, probably true that Kovid got the same errors but for a
> different reason.
> 
> >
> > Can you consult with quantum about it?
> 
> I checked with Quantum about this and they said:
> ---
> "We confirmed that if there's an RDC present when the soft reset is
>  received, then it can take between one and two seconds to complete the
>  reset.  Issuing a SET FEATURES command to the RDC is the longest part of
>  it.
> 
>  Even without an RDC, we've measured time on the order of 170
>  milliseconds. "
> ---
> 
> The RDC has been present for almost all of my testing.  Here
> are comparison traces with and without the RDC which definitely
> confirms the RDC factor.  It also confirms the order of 170ms
> without RDC time that Quantum mentioned.
> 
> ========
> With RDC
> ========
> kernel: ata1: status @ 5 ms: 0xff
> kernel: ata1: status @ 55 ms: 0xff
> kernel: ata1: status @ 105 ms: 0xff
> kernel: ata1: status @ 155 ms: 0xff
> kernel: ata1: status @ 205 ms: 0xff
> kernel: ata1: status @ 255 ms: 0xff
> kernel: ata1: status @ 305 ms: 0xff
> kernel: ata1: status @ 355 ms: 0xff
> kernel: ata1: status @ 405 ms: 0xff
> kernel: ata1: status @ 455 ms: 0xff
> kernel: ata1: status @ 505 ms: 0xff
> kernel: ata1: status @ 555 ms: 0xff
> kernel: ata1: status @ 605 ms: 0xff
> kernel: ata1: status @ 655 ms: 0x7f
> kernel: ata1: status @ 705 ms: 0x7f
> kernel: ata1: status @ 755 ms: 0x7f
> kernel: ata1: status @ 805 ms: 0x7f
> kernel: ata1: status @ 855 ms: 0x7f
> kernel: ata1: status @ 905 ms: 0x7f
> kernel: ata1: status @ 955 ms: 0x7f
> kernel: ata1: status @ 1005 ms: 0x7f
> 
> ===========
> Without RDC
> ===========
> kernel: ata1: status @ 5 ms: 0xff
> kernel: ata1: status @ 55 ms: 0xff
> kernel: ata1: status @ 105 ms: 0xff
> kernel: ata1: status @ 155 ms: 0xff
> kernel: ata1: status @ 205 ms: 0x7f
> kernel: ata1: status @ 255 ms: 0x7f
> kernel: ata1: status @ 305 ms: 0x7f
> kernel: ata1: status @ 355 ms: 0x7f
> kernel: ata1: status @ 405 ms: 0x7f
> kernel: ata1: status @ 455 ms: 0x7f
> kernel: ata1: status @ 505 ms: 0x7f
> kernel: ata1: status @ 555 ms: 0x7f
> kernel: ata1: status @ 605 ms: 0x7f
> kernel: ata1: status @ 655 ms: 0x7f
> kernel: ata1: status @ 705 ms: 0x7f
> kernel: ata1: status @ 755 ms: 0x7f
> kernel: ata1: status @ 805 ms: 0x7f
> kernel: ata1: status @ 855 ms: 0x7f
> kernel: ata1: status @ 905 ms: 0x7f
> kernel: ata1: status @ 955 ms: 0x7f
> kernel: ata1: status @ 1005 ms: 0x7f
> 
> > If they verify your fix (ie,
> > GoVault sometimes take more than 150ms to transmit the first D2H Reg FIs
> > after SRST), I'll push similar patch upstream.
> 
> Thanks.  If you think that changes to increase the delays are
> the way to go (at least until we can find a better solution)
> I can provide patches.

Tejun, 
I haven't heard anything from you on this so I'm including a delay
increase patch against 2.6.20-rc6 for the 'ata-piix' case below.  
I hope that you, Jeff, and others find this acceptable.

With respect to the 'ahci' case w/2.6.20-rc6 the GoVault device is 
useable following boot although the below messages are being logged 
during initialization.  Please let me know if you have any thoughts 
on this.  
  scsi1 : ahci
  ata2: softreset failed (port busy but CLO unavailable)
  ata2: softreset failed, retrying in 5 secs
  ata2: port is slow to respond, please be patient (Status 0x80)
  ata2: port failed to respond (30 secs, Status 0x80)
  ata2: COMRESET failed (device not ready)
  ata2: hardreset failed, retrying in 5 secs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: ATAPI, max UDMA/66
  ata2.00: configured for UDMA/66

Thanks,
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
+++ linux-2.6.20-rc6/drivers/ata/libata-core.c	2007-01-29 16:39:34.000000000 -0800
@@ -2683,6 +2683,13 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
+	/* For those controllers where the status could start out at
+	 * 0xFF even though the device is present we may need to wait
+	 * a little longer for slower removable media devices to respond.
+	 */
+	if (ata_check_status(ap) == 0xFF)
+		msleep(2000);
+
 	/* Before we perform post reset processing we want to see if
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.

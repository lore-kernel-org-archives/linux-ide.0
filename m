From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sun, 28 May 2006 00:15:37 +0200
Message-ID: <20060527221537.GB364@suse.de>
References: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <4478CF1E.8020304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:33581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965002AbWE0WRy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:17:54 -0400
Content-Disposition: inline
In-Reply-To: <4478CF1E.8020304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, Linus Torvalds <torvalds@osdl.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sat, May 27 2006, Mark Lord wrote:
> >>Linus Torvalds wrote:
> >>>On Sat, 27 May 2006, Jens Axboe wrote:
> >>>>>hardware, since the current suspend resumes to silicon defaults rather 
> >>>>>than BIOS defaults (and ata_piix doesn't have a controller reset).
> >>>>Definitely, and we need to cover a lot more controllers than just piix
> >>>>and ahci. Being the selfish bastard that I am, I didn't care much about
> >>>>other devices...
> >>>>
> >>>>diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> >>>>index fa476e7..28878f4 100644
> >>>>--- a/drivers/scsi/libata-core.c
> >>>>+++ b/drivers/scsi/libata-core.c
> >>>>@@ -4297,6 +4297,7 @@ static int ata_start_drive(struct ata_po
> >>>>int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
> >>>>{
> >>>>	if (ap->flags & ATA_FLAG_SUSPENDED) {
> >>>>+		ata_busy_wait(ap, ATA_BUSY, 200000);
> >>>Btw, it might not be enough to wait for ATA_BUSY to clear.
> >>>
> >>>I think you should wait for ATA_DRDY to be set too.
> >>>
> >>>What does it say if you change that "ata_busy_wait()" to
> >>>
> >>>	u8 status = ata_wait_idle(ap);
> >>>	if (!ata_ok(status))
> >>>		printk("ATA status %02x\n", status);
> >>I got rid of the 500msec delay (not needed on my machine anyway),
> >>and then added the above code *in front of* the ata_busy_wait().
> >>
> >>Resume worked, with this output:
> >>
> >>May 27 18:03:33 localhost kernel: ATA status 80
> >>May 27 18:03:33 localhost kernel: ata1: dev 0 configured for UDMA/100
> >>May 27 18:03:33 localhost kernel: ATA status 00
> >>May 27 18:03:33 localhost kernel: ata2: dev 0 configured for UDMA/33
> >>
> >>Note that the second set are for the DVD-RW drive,
> >>which (being ATAPI) doesn't assert ATA_DRDY.
> >
> >Works for me too, I changed the delay to match the 200000 above just to
> >be on the safe side.
> 
> Well a status of 0x80 isn't good, noted above, indicates BSY is still 
> asserted.....

Just commenting on how it worked for me, no issues. And I don't see any
ATA status messages.

-- 
Jens Axboe


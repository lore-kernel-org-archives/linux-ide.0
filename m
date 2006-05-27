From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)    fails: libata issue
Date: Sat, 27 May 2006 23:20:11 +0200
Message-ID: <20060527212011.GA31551@suse.de>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <200605271423.40037.liml@rtr.ca> <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:20082 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964988AbWE0VU1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 17:20:27 -0400
Content-Disposition: inline
In-Reply-To: <4478C1DD.2030204@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sat, May 27 2006, Jeff Garzik wrote:
> >>Jens Axboe wrote:
> >>>This is fine with me, Jeff originally complained it was a layering 
> >>>violation. Unless he really objects, I'd say go for that for 2.6.17 - 
> >>>well actually moving it inside the ATA_FLAG_SUSPENDED case is clearly 
> >>>better.
> >>It breaks 2.6.1[89] stuff, but whatever.  Go ahead and apply Linus's 
> >>patch.  I'll pick up the pieces post 2.6.17.
> >
> >Linus' patch doesn't work for me, seems I still need a little delay
> >before waiting for BSY clear. I'm testing a small additional hack to the
> >pci resume function.
> 
> If it works better for people, just doing an msleep() or mdelay() in 
> device suspend would be better than polling BSY.
> 
> A delay at least works for FIS-based controllers and PMs...

Ok, this one finally works reliably for me. I didn't experiment with
differnet sleep intervals, just picked 500msecs and it worked... The
ata_busy_wait() is _not_ enough for me, what seems to be happening is
that prematurely decides that BSY is cleared while it just hasn't been
asserted yet.

> Post 2.6.17, a lot of work needs to go into actually re-initing the 
> hardware, since the current suspend resumes to silicon defaults rather 
> than BIOS defaults (and ata_piix doesn't have a controller reset).

Definitely, and we need to cover a lot more controllers than just piix
and ahci. Being the selfish bastard that I am, I didn't care much about
other devices...

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..28878f4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4297,6 +4297,7 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+		ata_busy_wait(ap, ATA_BUSY, 200000);
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
@@ -4846,6 +4847,7 @@ int ata_pci_device_suspend(struct pci_de
 
 int ata_pci_device_resume(struct pci_dev *pdev)
 {
+	msleep(500);
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);

-- 
Jens Axboe


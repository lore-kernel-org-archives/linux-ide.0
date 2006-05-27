From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM)      fails: libata issue
Date: Sun, 28 May 2006 00:35:23 +0200
Message-ID: <20060527223523.GD364@suse.de>
References: <Pine.LNX.4.64.0605271144430.5623@g5.osdl.org> <200605272245.30108.axboe@suse.de> <4478BD60.40806@garzik.org> <20060527211157.GA31275@suse.de> <4478C1DD.2030204@garzik.org> <20060527212011.GA31551@suse.de> <Pine.LNX.4.64.0605271444200.5623@g5.osdl.org> <4478CD4E.4000506@rtr.ca> <20060527221131.GA364@suse.de> <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14647 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964966AbWE0WgJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 18:36:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605271519250.5623@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Sat, May 27 2006, Linus Torvalds wrote:
> 
> 
> On Sun, 28 May 2006, Jens Axboe wrote:
> > 
> > Works for me too, I changed the delay to match the 200000 above just to
> > be on the safe side.
> 
> That's insane. That was _not_ what I expected. That wasn't actually 
> supposed to fix anything at all for somebody who had problems.

I realize that, but that is what happens. And I don't think it's a
fluke, it's pretty much 100% reliably failed for me in the later 2.6.17
kernels and this one did 5 resume cycles without even complaining.

> Maybe you didn't remove the half-second delay (which is why it still works 
> for you)? I'd like to see what bits are set when it _isn't_ there, to see 
> if there's something we can trigger on..

The 500msec delay is gone, I can attest to that. This is a straight diff
of what I booted and which apparently works:

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fa476e7..526d1e1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4297,6 +4297,13 @@ static int ata_start_drive(struct ata_po
 int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
 {
 	if (ap->flags & ATA_FLAG_SUSPENDED) {
+#if 0
+		ata_busy_wait(ap, ATA_BUSY, 200000);
+#else
+		u8 stat = ata_wait_idle(ap);
+		if (!ata_ok(stat))
+			printk("ATA status %02x\n", stat);
+#endif
 		ap->flags &= ~ATA_FLAG_SUSPENDED;
 		ata_set_mode(ap);
 	}
@@ -4850,6 +4857,7 @@ int ata_pci_device_resume(struct pci_dev
 	pci_restore_state(pdev);
 	pci_enable_device(pdev);
 	pci_set_master(pdev);
+	//msleep(500);
 	return 0;
 }
 #endif /* CONFIG_PCI */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b80d2e7..80fb1f9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -742,7 +742,7 @@ static inline u8 ata_busy_wait(struct at
 
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
-	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 200000);
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;

-- 
Jens Axboe


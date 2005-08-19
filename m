From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [parisc-linux] Re: Why toggle_bounce only for disks?
Date: Fri, 19 Aug 2005 09:32:02 -0400
Message-ID: <1124458322.5130.18.camel@mulgrave>
References: <20050806235615.GK3505@roadwarrior.mcmartin.ca>
	 <58cb370e05081903073d9a2b73@mail.gmail.com> <20050819102132.GM6273@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stat16.steeleye.com ([209.192.50.48]:4242 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932676AbVHSNcL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Aug 2005 09:32:11 -0400
In-Reply-To: <20050819102132.GM6273@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, PARISC list <parisc-linux@lists.parisc-linux.org>, Kyle McMartin <kyle@parisc-linux.org>

On Fri, 2005-08-19 at 12:21 +0200, Jens Axboe wrote:
> Because not bouncing is a performance optimization and I only did the
> work on ide-cd to allow it. Your patch breaks ide-cd on highmem i386
> machines, so it's not acceptable.
> 
> Tells us more about this crash instead, I'm pretty sure you are working
> around another issue (your io-mmu code, is it hardware or software?)
> somehwere with this patch.

OK, so the particular fix is wrong; but the logic in ide_toggle_bounce()
is also incorrec.  Our problem is not that we don't want to bounce
highmem in ide-cd, it's that this is a parisc system with an IOMMU and
doesn't have any highmem to begin with.

we need ide_toggle_bounce to return BLK_BOUNCE_ANY always if
PCI_DMA_BUS_IS_PHYS is not set.

James

diff --git a/drivers/ide/ide-lib.c b/drivers/ide/ide-lib.c
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -410,10 +410,10 @@ void ide_toggle_bounce(ide_drive_t *driv
 {
 	u64 addr = BLK_BOUNCE_HIGH;	/* dma64_addr_t */
 
-	if (on && drive->media == ide_disk) {
-		if (!PCI_DMA_BUS_IS_PHYS)
-			addr = BLK_BOUNCE_ANY;
-		else if (HWIF(drive)->pci_dev)
+	if (!PCI_DMA_BUS_IS_PHYS)
+		addr = BLK_BOUNCE_ANY;
+	else if (on && drive->media == ide_disk) {
+		if (HWIF(drive)->pci_dev)
 			addr = HWIF(drive)->pci_dev->dma_mask;
 	}
 



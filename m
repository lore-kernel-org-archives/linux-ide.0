From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Re: libata: PIO bounce copies to avoid long IRQ off runs
Date: Tue, 29 Apr 2008 18:01:28 -0400
Message-ID: <20080429220128.GA25818@havoc.gtf.org>
References: <20080429144754.7d2952c8@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:46791 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbYD2WB3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 18:01:29 -0400
Content-Disposition: inline
In-Reply-To: <20080429144754.7d2952c8@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

I would tend to prefer this version...

	- allocate buffer at init time
	- use lesser-used KM_IRQ1

Original description:

Right now with PIO transfers we can jam the box up horribly as lock
IRQs off when the transfer is from high memory. We still have other
things we need to fix in this area to really make a difference but
this is the buffering side of the fix (the state machine enable/disable
irq stuff is also needed)

Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/ata/libata-sff.c |   82 ++++++++++++++++++++++++++++++-----------------
 include/linux/libata.h   |    6 +++
 2 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 2ec65a8..7e0651c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -665,6 +665,52 @@ unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
 }
 
 /**
+ *	ata_bounce_pio_xfer	-	Transfer a block by PIO from high
+ *	@dev: target device
+ *	@page: highmem page
+ *	@offset: offset in page
+ *	@count: bytes to transfer
+ *	@do_write: writing if set, reading if not
+ *
+ *	Transfer a page of high memory via PIO. Whenever possible use a bounce
+ *	buffer to avoid transfers occuring with local IRQ disable
+ */
+
+static unsigned int ata_bounce_pio_xfer(struct ata_device *dev,
+					struct page *page, unsigned int offset,
+					int count, int rw)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned long flags;
+	unsigned char *buf;
+	unsigned int consumed;
+
+	BUG_ON(offset + count > PAGE_SIZE);
+
+	if (rw == WRITE) {
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ1);
+		memcpy(dev->pio_bounce, buf + offset, count);
+		kunmap_atomic(buf, KM_IRQ1);
+		local_irq_restore(flags);
+	}
+
+	/* do the actual data transfer */
+	consumed = ap->ops->sff_data_xfer(dev, dev->pio_bounce, count, rw);
+
+	if (rw == READ) {
+		/* Read so bounce  data upwards */
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ1);
+		memcpy(buf + offset, dev->pio_bounce, count);
+		kunmap_atomic(buf, KM_IRQ1);
+		local_irq_restore(flags);
+	}
+
+	return consumed;
+}
+
+/**
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
  *
@@ -675,7 +721,7 @@ unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
  */
 static void ata_pio_sector(struct ata_queued_cmd *qc)
 {
-	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
+	int do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? WRITE : READ;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned int offset;
@@ -693,20 +739,10 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use a bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
-				       do_write);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
-	} else {
+	if (PageHighMem(page))
+		ata_bounce_pio_xfer(qc->dev, page, offset, qc->sect_size,
+								do_write);
+	else {
 		buf = page_address(page);
 		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
 				       do_write);
@@ -830,19 +866,9 @@ next_sg:
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
-	} else {
+	if (PageHighMem(page))
+		consumed = ata_bounce_pio_xfer(qc->dev, page, offset, count, rw);
+	else {
 		buf = page_address(page);
 		consumed = ap->ops->sff_data_xfer(dev,  buf + offset, count, rw);
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d1dfe87..ab43fad 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -576,6 +576,12 @@ struct ata_device {
 		u16		id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 		u32		gscr[SATA_PMP_GSCR_DWORDS]; /* PMP GSCR block */
 	};
+
+	/* TODO: if bounce buffer is guaranteed never to be used on a
+	 * system, elide it at compile time.  It is only needed to
+	 * bounce PageHighMem() pages.
+	 */
+	u8			pio_bounce[PAGE_SIZE];
 };
 
 /* Offset into struct ata_device.  Fields above it are maintained

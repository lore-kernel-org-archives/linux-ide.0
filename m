From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC PATCH] libata: PIO via bounce buffer
Date: Fri, 29 Feb 2008 13:51:06 +0000
Message-ID: <20080229135106.4fcf19e3@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43833 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752533AbYB2OCF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Feb 2008 09:02:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

First cut at the problem. Given the lack of certainty about worst case
buffer size (1 page I suspect) this uses kmalloc. We could hang a buffer
off the device (or I think in fact the port as we never do overlapped PIO)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc2-mm1/drivers/ata/libata-core.c linux-2.6.25-rc2-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.25-rc2-mm1/drivers/ata/libata-core.c	2008-02-19 11:03:26.000000000 +0000
+++ linux-2.6.25-rc2-mm1/drivers/ata/libata-core.c	2008-02-27 17:17:14.000000000 +0000
@@ -5052,6 +5052,60 @@
 
 
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
+static void ata_bounce_pio_xfer(struct ata_device *dev, struct page *page, 
+				  unsigned int offset, int count, int do_write)
+{
+	struct ata_port *ap = dev->link->ap;
+	unsigned long flags;
+	unsigned char *zebedee;
+	unsigned char *buf;
+
+	BUG_ON(offset + count > PAGE_SIZE);
+
+	zebedee = kmalloc(count, GFP_ATOMIC);
+	if (likely(zebedee)) {
+		if (do_write) {
+			local_irq_save(flags);
+			buf = kmap_atomic(page, KM_IRQ0);
+			memcpy(zebedee, buf + offset, count);
+			kunmap_atomic(buf, KM_IRQ0);
+			local_irq_restore(flags);
+		}
+		/* do the actual data transfer */
+		ap->ops->data_xfer(dev, zebedee, count, do_write);
+		if (!do_write) {
+			/* Read so bounce  data upwards */
+			local_irq_save(flags);
+			buf = kmap_atomic(page, KM_IRQ0);
+			memcpy(buf + offset, zebedee, count);
+			kunmap_atomic(buf, KM_IRQ0);
+			local_irq_restore(flags);
+		}
+		kfree(zebedee);
+	} else {
+		/* Only used when we are out of buffer memory
+		   as a last last resort */
+		local_irq_save(flags);
+		buf = kmap_atomic(page, KM_IRQ0);
+		/* do the actual data transfer */
+		ap->ops->data_xfer(dev, buf + offset, count, do_write);
+		kunmap_atomic(buf, KM_IRQ0);
+		local_irq_restore(flags);
+	}
+}
+
+/**
  *	ata_pio_sector - Transfer a sector of data.
  *	@qc: Command on going
  *
@@ -5081,21 +5135,13 @@
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use a bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
+	if (PageHighMem(page) || 1 /* TEST FIXME */) {
+		ata_bounce_pio_xfer(qc->dev, page, offset, qc->sect_size,
+								do_write);
 	} else {
 		buf = page_address(page);
-		ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, do_write);
+		ap->ops->data_xfer(qc->dev, buf + offset,
+						qc->sect_size, do_write);
 	}
 
 	qc->curbytes += qc->sect_size;
@@ -5242,19 +5288,9 @@
 
 	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
 
-	if (PageHighMem(page)) {
-		unsigned long flags;
-
-		/* FIXME: use bounce buffer */
-		local_irq_save(flags);
-		buf = kmap_atomic(page, KM_IRQ0);
-
-		/* do the actual data transfer */
-		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
-
-		kunmap_atomic(buf, KM_IRQ0);
-		local_irq_restore(flags);
-	} else {
+	if (PageHighMem(page))
+		ata_bounce_pio_xfer(qc->dev, page, offset, count, do_write);
+	else {
 		buf = page_address(page);
 		ap->ops->data_xfer(qc->dev,  buf + offset, count, do_write);
 	}

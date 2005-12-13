From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata-core.c:  fix parameter bug on kunmap_atomic() calls
Date: Mon, 12 Dec 2005 21:51:20 -0500
Message-ID: <439E3728.6090007@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070204050600020409080604"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39819 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751224AbVLMCva (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Dec 2005 21:51:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070204050600020409080604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix incorrect pointer usage on two calls to kunmap_atomic().
This seems to happen a lot, because kunmap() wants the struct page *,
whereas kunmap_atomic() instead wants the mapped virtual address.

Signed-off-by:  Mark Lord <liml@rtr.ca>

--- linux-2.6.15-rc5/drivers/scsi/libata-core.c.orig    2005-12-11 18:56:23.000000000 -0500
+++ linux/drivers/scsi/libata-core.c    2005-12-12 21:46:04.000000000 -0500
@@ -2447,7 +2447,7 @@
                         struct scatterlist *psg = &qc->pad_sgent;
                         void *addr = kmap_atomic(psg->page, KM_IRQ0);
                         memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-                       kunmap_atomic(psg->page, KM_IRQ0);
+                       kunmap_atomic(addr, KM_IRQ0);
                 }
         } else {
                 if (sg_dma_len(&sg[0]) > 0)
@@ -2721,7 +2721,7 @@
                 if (qc->tf.flags & ATA_TFLAG_WRITE) {
                         void *addr = kmap_atomic(psg->page, KM_IRQ0);
                         memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-                       kunmap_atomic(psg->page, KM_IRQ0);
+                       kunmap_atomic(addr, KM_IRQ0);
                 }

                 sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);

--------------070204050600020409080604
Content-Type: text/x-patch;
 name="libata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata.patch"

--- linux-2.6.15-rc5/drivers/scsi/libata-core.c.orig	2005-12-11 18:56:23.000000000 -0500
+++ linux/drivers/scsi/libata-core.c	2005-12-12 21:46:04.000000000 -0500
@@ -2447,7 +2447,7 @@
 			struct scatterlist *psg = &qc->pad_sgent;
 			void *addr = kmap_atomic(psg->page, KM_IRQ0);
 			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(addr, KM_IRQ0);
 		}
 	} else {
 		if (sg_dma_len(&sg[0]) > 0)
@@ -2721,7 +2721,7 @@
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			void *addr = kmap_atomic(psg->page, KM_IRQ0);
 			memcpy(pad_buf, addr + psg->offset, qc->pad_len);
-			kunmap_atomic(psg->page, KM_IRQ0);
+			kunmap_atomic(addr, KM_IRQ0);
 		}
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);

--------------070204050600020409080604--

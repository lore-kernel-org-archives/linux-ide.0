From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-2.6 1/5] Fix zero sg_dma_len() on 64-bit platform
Date: Fri, 18 Mar 2005 15:29:17 +0800
Message-ID: <423A834D.5080407@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050509070102060504030509"
Received: from bluehawaii.tikira.net ([61.62.22.51]:61412 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261482AbVCRH3z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Mar 2005 02:29:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050509070102060504030509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

   When testing ATAPI PIO data transfer on the ppc64 platform,  __atapi_pio_bytes() got zero when
sg_dma_len() is used. I checked the <asm-ppc64/scatterlish.h>, the struct scatterlist is defined as:

struct scatterlist {
	struct page *page;
	unsigned int offset;
	unsigned int length;

	/* For TCE support */
	u32 dma_address;
	u32 dma_length;
};

#define sg_dma_address(sg)	((sg)->dma_address)
#define sg_dma_len(sg)		((sg)->dma_length)

So, if the scatterlist is not DMA mapped, sg_dma_len() will return zero on ppc64.
The same problem should occur on the x86-64 platform.
On the i386 platform, sg_dma_len() returns sg->length, that's why the problem does not occur on an i386.

Changes:
- Use sg->length if the scatterlist is not DMA mapped (yet).

   Attached please find the patch against the libata-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---------------------------------------
--- libata-2.6/drivers/scsi/libata-core.c	2005-03-17 16:42:32.000000000 +0800
+++ libata-2.6-sgdma/drivers/scsi/libata-core.c	2005-03-17 17:23:42.000000000 +0800
@@ -2071,7 +2071,7 @@
  	sg = qc->sg;
  	sg->page = virt_to_page(buf);
  	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg_dma_len(sg) = buflen;
+	sg->length = buflen;
  }

  void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2101,11 +2101,12 @@
  	dma_addr_t dma_address;

  	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
-				     sg_dma_len(sg), dir);
+				     sg->length, dir);
  	if (dma_mapping_error(dma_address))
  		return -1;

  	sg_dma_address(sg) = dma_address;
+	sg_dma_len(sg) = sg->length;

  	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
  		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
@@ -2310,7 +2311,7 @@
  	qc->cursect++;
  	qc->cursg_ofs++;

-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
  		qc->cursg++;
  		qc->cursg_ofs = 0;
  	}
@@ -2347,7 +2348,7 @@
  	page = nth_page(page, (offset >> PAGE_SHIFT));
  	offset %= PAGE_SIZE;

-	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	count = min(sg->length - qc->cursg_ofs, bytes);

  	/* don't cross page boundaries */
  	count = min(count, (unsigned int)PAGE_SIZE - offset);
@@ -2358,7 +2359,7 @@
  	qc->curbytes += count;
  	qc->cursg_ofs += count;

-	if (qc->cursg_ofs == sg_dma_len(sg)) {
+	if (qc->cursg_ofs == sg->length) {
  		qc->cursg++;
  		qc->cursg_ofs = 0;
  	}
@@ -2371,7 +2372,7 @@
  	kunmap(page);

  	if (bytes) {
-		if (qc->cursg_ofs < sg_dma_len(sg))
+		if (qc->cursg_ofs < sg->length)
  			goto next_page;
  		goto next_sg;
  	}

--------------050509070102060504030509
Content-Type: text/plain;
 name="sg_dma_len.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sg_dma_len.diff"

--- libata-2.6/drivers/scsi/libata-core.c	2005-03-17 16:42:32.000000000 +0800
+++ libata-2.6-sgdma/drivers/scsi/libata-core.c	2005-03-17 17:23:42.000000000 +0800
@@ -2071,7 +2071,7 @@
 	sg = qc->sg;
 	sg->page = virt_to_page(buf);
 	sg->offset = (unsigned long) buf & ~PAGE_MASK;
-	sg_dma_len(sg) = buflen;
+	sg->length = buflen;
 }
 
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
@@ -2101,11 +2101,12 @@
 	dma_addr_t dma_address;
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
-				     sg_dma_len(sg), dir);
+				     sg->length, dir);
 	if (dma_mapping_error(dma_address))
 		return -1;
 
 	sg_dma_address(sg) = dma_address;
+	sg_dma_len(sg) = sg->length;
 
 	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
 		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
@@ -2310,7 +2311,7 @@
 	qc->cursect++;
 	qc->cursg_ofs++;
 
-	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg_dma_len(&sg[qc->cursg])) {
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == (&sg[qc->cursg])->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2347,7 +2348,7 @@
 	page = nth_page(page, (offset >> PAGE_SHIFT));
 	offset %= PAGE_SIZE;
 
-	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
+	count = min(sg->length - qc->cursg_ofs, bytes);
 
 	/* don't cross page boundaries */
 	count = min(count, (unsigned int)PAGE_SIZE - offset);
@@ -2358,7 +2359,7 @@
 	qc->curbytes += count;
 	qc->cursg_ofs += count;
 
-	if (qc->cursg_ofs == sg_dma_len(sg)) {
+	if (qc->cursg_ofs == sg->length) {
 		qc->cursg++;
 		qc->cursg_ofs = 0;
 	}
@@ -2371,7 +2372,7 @@
 	kunmap(page);
 
 	if (bytes) {
-		if (qc->cursg_ofs < sg_dma_len(sg))
+		if (qc->cursg_ofs < sg->length)
 			goto next_page;
 		goto next_sg;
 	}

--------------050509070102060504030509--



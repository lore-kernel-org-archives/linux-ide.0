From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata highmem fix
Date: Tue, 2 Nov 2004 08:17:12 -0500
Message-ID: <20041102131712.GA9445@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:1490 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261652AbUKBNRP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2004 08:17:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Uses the new nth_page() to fix highmem bug, a la IDE's fix.

Thanks Bart.  Tested with CONFIG_HIGHMEM but not >4GB.

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-core.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

through these ChangeSets:

<bzolnier@elka.pw.edu.pl> (04/11/02 1.2462)
   [PATCH] libata PIO bugfix
   
   Untested but based on working IDE fix.
   
   We need to kmap()/kunmap() the current page
   not the first page of the scatterlist segment.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-11-02 08:15:17 -05:00
+++ b/drivers/scsi/libata-core.c	2004-11-02 08:15:17 -05:00
@@ -2169,14 +2169,20 @@
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
 	struct page *page;
+	unsigned int offset;
 	unsigned char *buf;
 
 	if (qc->cursect == (qc->nsect - 1))
 		ap->pio_task_state = PIO_ST_LAST;
 
 	page = sg[qc->cursg].page;
-	buf = kmap(page) +
-	      sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+	offset = sg[qc->cursg].offset + qc->cursg_ofs * ATA_SECT_SIZE;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
+
+	buf = kmap(page) + offset;
 
 	qc->cursect++;
 	qc->cursg_ofs++;
@@ -2202,17 +2208,28 @@
 	struct ata_port *ap = qc->ap;
 	struct page *page;
 	unsigned char *buf;
-	unsigned int count;
+	unsigned int offset, count;
 
 	if (qc->curbytes == qc->nbytes - bytes)
 		ap->pio_task_state = PIO_ST_LAST;
 
 next_sg:
 	sg = &qc->sg[qc->cursg];
+
+next_page:
 	page = sg->page;
+	offset = sg->offset + qc->cursg_ofs;
+
+	/* get the current page and offset */
+	page = nth_page(page, (offset >> PAGE_SHIFT));
+	offset %= PAGE_SIZE;
 
 	count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);
-	buf = kmap(page) + sg->offset + qc->cursg_ofs;
+
+	/* don't cross page boundaries */
+	count = min(count, (unsigned int)PAGE_SIZE - offset);
+
+	buf = kmap(page) + offset;
 
 	bytes -= count;
 	qc->curbytes += count;
@@ -2230,8 +2247,11 @@
 
 	kunmap(page);
 
-	if (bytes)
+	if (bytes) {
+		if (qc->cursg_ofs < sg_dma_len(sg))
+			goto next_page;
 		goto next_sg;
+	}
 }
 
 static void atapi_pio_bytes(struct ata_queued_cmd *qc)

From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [libata] PIO bugfix
Date: Sat, 30 Oct 2004 23:57:34 +0200
Message-ID: <200410302357.34131.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:29942 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261351AbUJ3WJy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Oct 2004 18:09:54 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:47987 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S29182AbUJ3WJw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Oct 2004 00:09:52 +0200
Received: from chello062179088136.chello.pl ([62.179.88.136]:62851 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S49675AbUJ3VxL (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Sat, 30 Oct 2004 23:53:11 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


Untested but based on working IDE fix.

We need to kmap()/kunmap() the current page
not the first page of the scatterlist segment.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-30 23:51:12 +02:00
+++ b/drivers/scsi/libata-core.c	2004-10-30 23:51:12 +02:00
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

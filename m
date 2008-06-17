From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/2] libata: don't check whether to use DMA
 or not for no data commands
Date: Tue, 17 Jun 2008 12:36:26 +0900
Message-ID: <4857313A.1000405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39307 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbYFQDhb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 23:37:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: luke@lukeross.name

There's no reason to check whether to use DMA or not for no data
commands.  Don't do it.  While at it, make local variable using_pio in
atapi_xlat() set iff ATAPI_PROT_PIO is going to be used and rename
ata_check_atapi_dma() to atapi_check_dma() for consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
It's late in the -rc cycle but these two patches are to work around
specific hardware and low risk.  Thanks.

 drivers/ata/libata-core.c |    4 ++--
 drivers/ata/libata-scsi.c |   16 +++++++---------
 drivers/ata/libata.h      |    2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -2343,8 +2343,8 @@ static unsigned int atapi_xlat(struct at
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
-	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (scmd->sc_data_direction == DMA_NONE);
+	int using_pio = !nodata && (dev->flags & ATA_DFLAG_PIO);
 	unsigned int nbytes;
 
 	memset(qc->cdb, 0, dev->cdb_len);
@@ -2362,7 +2362,7 @@ static unsigned int atapi_xlat(struct at
 	ata_qc_set_pc_nbytes(qc);
 
 	/* check whether ATAPI DMA is safe */
-	if (!using_pio && ata_check_atapi_dma(qc))
+	if (!nodata && !using_pio && atapi_check_dma(qc))
 		using_pio = 1;
 
 	/* Some controller variants snoop this value for Packet
@@ -2402,13 +2402,11 @@ static unsigned int atapi_xlat(struct at
 	qc->tf.lbam = (nbytes & 0xFF);
 	qc->tf.lbah = (nbytes >> 8);
 
-	if (using_pio || nodata) {
-		/* no data, or PIO data xfer */
-		if (nodata)
-			qc->tf.protocol = ATAPI_PROT_NODATA;
-		else
-			qc->tf.protocol = ATAPI_PROT_PIO;
-	} else {
+	if (nodata)
+		qc->tf.protocol = ATAPI_PROT_NODATA;
+	else if (using_pio)
+		qc->tf.protocol = ATAPI_PROT_PIO;
+	else {
 		/* DMA data xfer */
 		qc->tf.protocol = ATAPI_PROT_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4297,7 +4297,7 @@ void ata_sg_clean(struct ata_queued_cmd 
 }
 
 /**
- *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
+ *	atapi_check_dma - Check whether ATAPI DMA can be supported
  *	@qc: Metadata associated with taskfile to check
  *
  *	Allow low-level driver to filter ATA PACKET commands, returning
@@ -4310,7 +4310,7 @@ void ata_sg_clean(struct ata_queued_cmd 
  *	RETURNS: 0 when ATAPI DMA can be used
  *               nonzero otherwise
  */
-int ata_check_atapi_dma(struct ata_queued_cmd *qc)
+int atapi_check_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
Index: work/drivers/ata/libata.h
===================================================================
--- work.orig/drivers/ata/libata.h
+++ work/drivers/ata/libata.h
@@ -106,7 +106,7 @@ extern void ata_sg_clean(struct ata_queu
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
+extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern void ata_dev_init(struct ata_device *dev);
 extern void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp);
